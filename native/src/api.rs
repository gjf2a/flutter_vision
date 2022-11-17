use std::{cmp::{max, min}, collections::BTreeSet};
use flutter_rust_bridge::{ZeroCopyBuffer};
use correlation_flow::micro_rfft::{COL_DIM, ROW_DIM, MicroFftContext};
use std::collections::HashMap;
pub use particle_filter::sonar3bot::{RobotSensorPosition, BOT, MotorData};
use flutter_rust_bridge::support::lazy_static;
use std::sync::Mutex;

type RgbTriple = (u8, u8, u8);

pub struct SensorData {
    pub sonar_front: i64,
    pub sonar_left: i64,
    pub sonar_right: i64,
    pub left_count: i64,
    pub right_count: i64,
    pub left_speed: i64,
    pub right_speed: i64
}

impl SensorData {
    fn motor_data(&self) -> MotorData {
        MotorData {left_count: self.left_count, right_count: self.right_count, left_speed: self.left_speed, right_speed: self.right_speed}
    }
}

pub fn intensity_rgba(intensities: Vec<u8>) -> ZeroCopyBuffer<Vec<u8>> {
    let mut result = Vec::new();
    for byte in intensities.iter().copied() {
        for _ in 0..3 {
            result.push(byte);
        }
        result.push(u8::MAX);
    }
    ZeroCopyBuffer(result)
}

pub fn yuv_rgba(ys: Vec<u8>, us: Vec<u8>, vs: Vec<u8>, width: i64, height: i64, uv_row_stride: i64, uv_pixel_stride: i64) -> ZeroCopyBuffer<Vec<u8>> {
    ZeroCopyBuffer(inner_yuv_rgba(ys, us, vs, width, height, uv_row_stride, uv_pixel_stride))
}

pub struct ColorCount {
    pub count: i64,
    pub image: ZeroCopyBuffer<Vec<u8>>
}

pub fn color_count(ys: Vec<u8>, us: Vec<u8>, vs: Vec<u8>, width: i64, height: i64, uv_row_stride: i64, uv_pixel_stride: i64) -> ColorCount {
    let rgba = inner_yuv_rgba(ys, us, vs, width, height, uv_row_stride, uv_pixel_stride);
    let mut distinct_colors = BTreeSet::new();
    for i in (0..rgba.len()).step_by(4) {
        let color = (rgba[i], rgba[i+1], rgba[i+2]);
        distinct_colors.insert(color);
    }
    ColorCount {count: distinct_colors.len() as i64, image: ZeroCopyBuffer(rgba)}
}    

const UPPER_SAMPLE_HEIGHT: f64 = 0.25;
const UPPER_SAMPLE_WIDTH: f64 = 0.25;
const LOWER_SAMPLE_WIDTH: f64 = 0.3;
const LOWER_SAMPLE_HEIGHT: f64 = 0.25;

pub fn groundline_sample_overlay(ys: Vec<u8>, us: Vec<u8>, vs: Vec<u8>, width: i64, height: i64, uv_row_stride: i64, uv_pixel_stride: i64) -> ZeroCopyBuffer<Vec<u8>> {
    let mut image = inner_yuv_rgba(ys, us, vs, width, height, uv_row_stride, uv_pixel_stride);
    let upper_max_y = (height as f64 * UPPER_SAMPLE_HEIGHT) as i64;
    let upper_left_x_end = (width as f64 * UPPER_SAMPLE_WIDTH) as i64;
    let upper_right_x_start = width - upper_left_x_end;
    let lower_x_start = (width as f64 * (0.5 - LOWER_SAMPLE_WIDTH / 2.0)) as i64;
    let lower_width = (width as f64 * LOWER_SAMPLE_WIDTH) as i64;
    let lower_height = (height as f64 * LOWER_SAMPLE_HEIGHT) as i64;
    let lower_y_start = (height as f64 * (1.0 - LOWER_SAMPLE_HEIGHT)) as i64;
    let white = (255, 255, 255);
    overlay_rectangle_on(&mut image, width, (0, 0), (upper_left_x_end, upper_max_y), white);
    overlay_rectangle_on(&mut image, width, (upper_right_x_start, 0), (upper_left_x_end, upper_max_y), white);
    overlay_rectangle_on(&mut image, width, (lower_x_start, lower_y_start), (lower_width, lower_height), white);
    ZeroCopyBuffer(image)
}

fn point2index(x: i64, y: i64, width: i64) -> usize {
    ((y * width + x) * 4) as usize
}

/// Translated and adapted from: https://stackoverflow.com/a/57604820/906268
fn inner_yuv_rgba(ys: Vec<u8>, us: Vec<u8>, vs: Vec<u8>, width: i64, height: i64, uv_row_stride: i64, uv_pixel_stride: i64) -> Vec<u8> {
    let mut result = Vec::new();
    for y in 0..height {
        for x in 0..width {
            let uv_index = (uv_pixel_stride * (x/2) + uv_row_stride * (y/2)) as usize;
            let index = (y * width + x) as usize;
            let yp = ys[index] as i64;
            let up = us[uv_index] as i64;
            let vp = vs[uv_index] as i64;
            result.push(clamp_u8(yp + vp * 1436 / 1024 - 179));
            result.push(clamp_u8(yp - up * 46549 / 131072 + 44 - vp * 93604 / 131072 + 91));
            result.push(clamp_u8(yp + up * 1814 / 1024 - 227));
            result.push(u8::MAX);
        }
    }
    result
}

fn plot(image: &mut Vec<u8>, x: i64, y: i64, width: i64, color: RgbTriple) {
    let index = point2index(x, y, width);
    if index >= image.len() {
        panic!("Out of bounds at {x}, {y}; width is {width}");
    }
    image[index] = color.0;
    image[index + 1] = color.1;
    image[index + 2] = color.2;
    image[index + 3] = 255;
}

fn overlay_points_on(image: &mut Vec<u8>, width: i64, points: &Vec<(i64,i64)>, color: RgbTriple) {
    for (x, y) in points.iter() {
        plot(image, *x, *y, width, color);
    }
}

fn overlay_rectangle_on(image: &mut Vec<u8>, width: i64, ul_corner: (i64, i64), dimensions: (i64, i64), color: RgbTriple) {
    for x in ul_corner.0..ul_corner.0 + dimensions.0 {
        plot(image, x, ul_corner.1, width, color);
        plot(image, x, ul_corner.1 + dimensions.1 - 1, width, color);
    }
    for y in ul_corner.1..ul_corner.1 + dimensions.1 {
        plot(image, ul_corner.0, y, width, color);
        plot(image, ul_corner.0 + dimensions.0 - 1, y, width, color);
    }
}

fn clamp_u8(value: i64) -> u8 {
    min(max(value, 0), u8::MAX as i64) as u8
}

#[derive(Copy, Clone)]
pub struct CorrelationFlow {
    pub dx: i16, pub dy: i16
}

pub fn get_correlation_flow(prev_ys: Vec<u8>, current_ys: Vec<u8>, width: i64, height: i64) -> CorrelationFlow {
    let mut correlator = MicroFftContext::new();
    let down_prev = downsampled_to(&prev_ys, width, height, COL_DIM as i64, ROW_DIM as i64);
    let down_current = downsampled_to(&current_ys, width, height, COL_DIM as i64, ROW_DIM as i64);
    let (dx, dy) = correlator.measure_translation(&down_prev, &down_current);
    CorrelationFlow {dx, dy}
}

fn downsampled_to(ys: &Vec<u8>, width: i64, height: i64, target_width: i64, target_height: i64) -> Vec<u8> {
    let mut result = Vec::new();
    for y in 0..target_height {
        let old_y = y * height / target_height;
        for x in 0..target_width {
            let old_x = x * width / target_width;
            let i = (old_y * width + old_x) as usize;
            result.push(ys[i]);
        }
    }
    result
}

lazy_static! {
    static ref POS: Mutex<RobotSensorPosition> = Mutex::new(RobotSensorPosition::new(BOT));
}

pub fn reset_position_estimate() {
    let mut pos = POS.lock().unwrap();
    pos.reset();
}

pub fn process_sensor_data(incoming_data: String) -> String {
    let parsed = parse_sensor_data(incoming_data);
    let mut pos = POS.lock().unwrap();
    pos.motor_update(parsed.motor_data());
    let (x, y) = pos.get_pos().position();
    let h = pos.get_pos().heading();
    format!("({x:.2} {y:.2} {h}) {:?} #{}", pos.get_encoder_counts(), pos.num_updates())
}

pub fn parse_sensor_data(incoming_data: String) -> SensorData {
    let parts: HashMap<&str,i64> = incoming_data.split(";").map(|s| {
        let mut ss = s.split(":");
        let key = ss.next().unwrap();
        let value: i64 = ss.next().unwrap().parse().unwrap();
        (key, value)
    }).collect();
    SensorData {
        sonar_front: *parts.get("SF").unwrap(),
        sonar_left: *parts.get("SL").unwrap(),
        sonar_right: *parts.get("SR").unwrap(),
        left_count: *parts.get("LC").unwrap(),
        right_count: *parts.get("RC").unwrap(),
        left_speed: *parts.get("LS").unwrap(),
        right_speed: *parts.get("RS").unwrap(),
    }
}
