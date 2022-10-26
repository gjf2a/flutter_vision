// AUTO GENERATED FILE, DO NOT EDIT.
// Generated by `flutter_rust_bridge`@ 1.49.0.
// ignore_for_file: non_constant_identifier_names, unused_element, duplicate_ignore, directives_ordering, curly_braces_in_flow_control_structures, unnecessary_lambdas, slash_for_doc_comments, prefer_const_literals_to_create_immutables, implicit_dynamic_list_literal, duplicate_import, unused_import, prefer_single_quotes, prefer_const_constructors, use_super_parameters, always_use_package_imports, annotate_overrides, invalid_use_of_protected_member, constant_identifier_names

import 'dart:convert';
import 'dart:async';
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';

abstract class Native {
  Future<Uint8List> intensityRgba(
      {required Uint8List intensities, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kIntensityRgbaConstMeta;

  /// Translated and adapted from: https://stackoverflow.com/a/57604820/906268
  Future<Uint8List> yuvRgba(
      {required Uint8List ys,
      required Uint8List us,
      required Uint8List vs,
      required int width,
      required int height,
      required int uvRowStride,
      required int uvPixelStride,
      dynamic hint});

  FlutterRustBridgeTaskConstMeta get kYuvRgbaConstMeta;

  Future<CorrelationFlow> getCorrelationFlow(
      {required Uint8List prevYs,
      required Uint8List currentYs,
      required int width,
      required int height,
      dynamic hint});

  FlutterRustBridgeTaskConstMeta get kGetCorrelationFlowConstMeta;

  Future<void> resetPositionEstimate({dynamic hint});

  FlutterRustBridgeTaskConstMeta get kResetPositionEstimateConstMeta;

  Future<String> processSensorData(
      {required String incomingData, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kProcessSensorDataConstMeta;

  Future<SensorData> parseSensorData(
      {required String incomingData, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kParseSensorDataConstMeta;
}

class CorrelationFlow {
  final int dx;
  final int dy;

  CorrelationFlow({
    required this.dx,
    required this.dy,
  });
}

class SensorData {
  final int sonarFront;
  final int sonarLeft;
  final int sonarRight;
  final int motorLeft;
  final int motorRight;
  final int actionTag;

  SensorData({
    required this.sonarFront,
    required this.sonarLeft,
    required this.sonarRight,
    required this.motorLeft,
    required this.motorRight,
    required this.actionTag,
  });
}
