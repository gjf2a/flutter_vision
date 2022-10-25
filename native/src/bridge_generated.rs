#![allow(
    non_camel_case_types,
    unused,
    clippy::redundant_closure,
    clippy::useless_conversion,
    clippy::unit_arg,
    clippy::double_parens,
    non_snake_case,
    clippy::too_many_arguments
)]
// AUTO GENERATED FILE, DO NOT EDIT.
// Generated by `flutter_rust_bridge`@ 1.49.0.

use crate::api::*;
use core::panic::UnwindSafe;
use flutter_rust_bridge::*;

// Section: imports

// Section: wire functions

fn wire_intensity_rgba_impl(port_: MessagePort, intensities: impl Wire2Api<Vec<u8>> + UnwindSafe) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "intensity_rgba",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_intensities = intensities.wire2api();
            move |task_callback| Ok(intensity_rgba(api_intensities))
        },
    )
}
fn wire_yuv_rgba_impl(
    port_: MessagePort,
    ys: impl Wire2Api<Vec<u8>> + UnwindSafe,
    us: impl Wire2Api<Vec<u8>> + UnwindSafe,
    vs: impl Wire2Api<Vec<u8>> + UnwindSafe,
    width: impl Wire2Api<i64> + UnwindSafe,
    height: impl Wire2Api<i64> + UnwindSafe,
    uv_row_stride: impl Wire2Api<i64> + UnwindSafe,
    uv_pixel_stride: impl Wire2Api<i64> + UnwindSafe,
) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "yuv_rgba",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_ys = ys.wire2api();
            let api_us = us.wire2api();
            let api_vs = vs.wire2api();
            let api_width = width.wire2api();
            let api_height = height.wire2api();
            let api_uv_row_stride = uv_row_stride.wire2api();
            let api_uv_pixel_stride = uv_pixel_stride.wire2api();
            move |task_callback| {
                Ok(yuv_rgba(
                    api_ys,
                    api_us,
                    api_vs,
                    api_width,
                    api_height,
                    api_uv_row_stride,
                    api_uv_pixel_stride,
                ))
            }
        },
    )
}
fn wire_get_correlation_flow_impl(
    port_: MessagePort,
    prev_ys: impl Wire2Api<Vec<u8>> + UnwindSafe,
    current_ys: impl Wire2Api<Vec<u8>> + UnwindSafe,
    width: impl Wire2Api<i64> + UnwindSafe,
    height: impl Wire2Api<i64> + UnwindSafe,
) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "get_correlation_flow",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_prev_ys = prev_ys.wire2api();
            let api_current_ys = current_ys.wire2api();
            let api_width = width.wire2api();
            let api_height = height.wire2api();
            move |task_callback| {
                Ok(get_correlation_flow(
                    api_prev_ys,
                    api_current_ys,
                    api_width,
                    api_height,
                ))
            }
        },
    )
}
// Section: wrapper structs

// Section: static checks

// Section: allocate functions

// Section: impl Wire2Api

pub trait Wire2Api<T> {
    fn wire2api(self) -> T;
}

impl<T, S> Wire2Api<Option<T>> for *mut S
where
    *mut S: Wire2Api<T>,
{
    fn wire2api(self) -> Option<T> {
        (!self.is_null()).then(|| self.wire2api())
    }
}
impl Wire2Api<i64> for i64 {
    fn wire2api(self) -> i64 {
        self
    }
}
impl Wire2Api<u8> for u8 {
    fn wire2api(self) -> u8 {
        self
    }
}

// Section: impl IntoDart

impl support::IntoDart for CorrelationFlow {
    fn into_dart(self) -> support::DartAbi {
        vec![self.dx.into_dart(), self.dy.into_dart()].into_dart()
    }
}
impl support::IntoDartExceptPrimitive for CorrelationFlow {}

// Section: executor

support::lazy_static! {
    pub static ref FLUTTER_RUST_BRIDGE_HANDLER: support::DefaultHandler = Default::default();
}

#[cfg(not(target_family = "wasm"))]
#[path = "bridge_generated.io.rs"]
mod io;
#[cfg(not(target_family = "wasm"))]
pub use io::*;
