library flutter_vision;

export 'ffi.dart';

import 'dart:ui' as dartui;

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'ffi.dart';

class CameraImagePainter extends CustomPainter {
  late dartui.Image _lastImage;
  bool _initialized = false;
  int _width = 0, _height = 0;

  Future<void> setImage(CameraImage img) async {
    _lastImage = await makeColorFrom(img);
    _width = _lastImage.width;
    _height = _lastImage.height;
    _initialized = true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (_initialized) {
      canvas.drawImage(_lastImage, Offset(-_width/2, -_height/2), Paint());
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => _initialized;
}

Future<dartui.Image> makeGrayscaleFrom(CameraImage img) async {
  Uint8List proc = await api.intensityRgba(intensities: img.planes[0].bytes);
  return makeImageFrom(proc, img.width, img.height);
}

Future<dartui.Image> makeColorFrom(CameraImage img) async {
  Uint8List proc = await api.yuvRgba(ys: img.planes[0].bytes, us: img.planes[1].bytes, vs: img.planes[2].bytes, width: img.width, height: img.height, uvRowStride: img.planes[1].bytesPerRow, uvPixelStride: img.planes[1].bytesPerPixel!);
  return makeImageFrom(proc, img.width, img.height);
}

// This is super-clunky. I wonder if there's a better way...
Future<dartui.Image> makeImageFrom(Uint8List intensities, int width, int height) async {
  dartui.ImmutableBuffer rgba = await dartui.ImmutableBuffer.fromUint8List(intensities);
  dartui.Codec c = await dartui.ImageDescriptor.raw(rgba, width: width, height: height, pixelFormat: dartui.PixelFormat.rgba8888).instantiateCodec(targetWidth: width, targetHeight: height);
  dartui.FrameInfo frame = await c.getNextFrame();
  dartui.Image result = frame.image.clone();
  frame.image.dispose();
  return result;
}