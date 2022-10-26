// AUTO GENERATED FILE, DO NOT EDIT.
// Generated by `flutter_rust_bridge`@ 1.49.0.
// ignore_for_file: non_constant_identifier_names, unused_element, duplicate_ignore, directives_ordering, curly_braces_in_flow_control_structures, unnecessary_lambdas, slash_for_doc_comments, prefer_const_literals_to_create_immutables, implicit_dynamic_list_literal, duplicate_import, unused_import, prefer_single_quotes, prefer_const_constructors, use_super_parameters, always_use_package_imports, annotate_overrides, invalid_use_of_protected_member, constant_identifier_names

import "bridge_definitions.dart";
import 'dart:convert';
import 'dart:async';
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';

import 'package:meta/meta.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';
import 'package:meta/meta.dart';
import 'dart:ffi' as ffi;

class NativeImpl implements Native {
  final NativePlatform _platform;
  factory NativeImpl(ExternalLibrary dylib) =>
      NativeImpl.raw(NativePlatform(dylib));

  /// Only valid on web/WASM platforms.
  factory NativeImpl.wasm(FutureOr<WasmModule> module) =>
      NativeImpl(module as ExternalLibrary);
  NativeImpl.raw(this._platform);
  Future<Uint8List> intensityRgba(
          {required Uint8List intensities, dynamic hint}) =>
      _platform.executeNormal(FlutterRustBridgeTask(
        callFfi: (port_) => _platform.inner.wire_intensity_rgba(
            port_, _platform.api2wire_uint_8_list(intensities)),
        parseSuccessData: _wire2api_ZeroCopyBuffer_Uint8List,
        constMeta: kIntensityRgbaConstMeta,
        argValues: [intensities],
        hint: hint,
      ));

  FlutterRustBridgeTaskConstMeta get kIntensityRgbaConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "intensity_rgba",
        argNames: ["intensities"],
      );

  Future<Uint8List> yuvRgba(
          {required Uint8List ys,
          required Uint8List us,
          required Uint8List vs,
          required int width,
          required int height,
          required int uvRowStride,
          required int uvPixelStride,
          dynamic hint}) =>
      _platform.executeNormal(FlutterRustBridgeTask(
        callFfi: (port_) => _platform.inner.wire_yuv_rgba(
            port_,
            _platform.api2wire_uint_8_list(ys),
            _platform.api2wire_uint_8_list(us),
            _platform.api2wire_uint_8_list(vs),
            _platform.api2wire_i64(width),
            _platform.api2wire_i64(height),
            _platform.api2wire_i64(uvRowStride),
            _platform.api2wire_i64(uvPixelStride)),
        parseSuccessData: _wire2api_ZeroCopyBuffer_Uint8List,
        constMeta: kYuvRgbaConstMeta,
        argValues: [ys, us, vs, width, height, uvRowStride, uvPixelStride],
        hint: hint,
      ));

  FlutterRustBridgeTaskConstMeta get kYuvRgbaConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "yuv_rgba",
        argNames: [
          "ys",
          "us",
          "vs",
          "width",
          "height",
          "uvRowStride",
          "uvPixelStride"
        ],
      );

  Future<CorrelationFlow> getCorrelationFlow(
          {required Uint8List prevYs,
          required Uint8List currentYs,
          required int width,
          required int height,
          dynamic hint}) =>
      _platform.executeNormal(FlutterRustBridgeTask(
        callFfi: (port_) => _platform.inner.wire_get_correlation_flow(
            port_,
            _platform.api2wire_uint_8_list(prevYs),
            _platform.api2wire_uint_8_list(currentYs),
            _platform.api2wire_i64(width),
            _platform.api2wire_i64(height)),
        parseSuccessData: _wire2api_correlation_flow,
        constMeta: kGetCorrelationFlowConstMeta,
        argValues: [prevYs, currentYs, width, height],
        hint: hint,
      ));

  FlutterRustBridgeTaskConstMeta get kGetCorrelationFlowConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "get_correlation_flow",
        argNames: ["prevYs", "currentYs", "width", "height"],
      );

  Future<void> resetPositionEstimate({dynamic hint}) =>
      _platform.executeNormal(FlutterRustBridgeTask(
        callFfi: (port_) => _platform.inner.wire_reset_position_estimate(port_),
        parseSuccessData: _wire2api_unit,
        constMeta: kResetPositionEstimateConstMeta,
        argValues: [],
        hint: hint,
      ));

  FlutterRustBridgeTaskConstMeta get kResetPositionEstimateConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "reset_position_estimate",
        argNames: [],
      );

  Future<String> processSensorData(
          {required String incomingData, dynamic hint}) =>
      _platform.executeNormal(FlutterRustBridgeTask(
        callFfi: (port_) => _platform.inner.wire_process_sensor_data(
            port_, _platform.api2wire_String(incomingData)),
        parseSuccessData: _wire2api_String,
        constMeta: kProcessSensorDataConstMeta,
        argValues: [incomingData],
        hint: hint,
      ));

  FlutterRustBridgeTaskConstMeta get kProcessSensorDataConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "process_sensor_data",
        argNames: ["incomingData"],
      );

// Section: wire2api

  String _wire2api_String(dynamic raw) {
    return raw as String;
  }

  Uint8List _wire2api_ZeroCopyBuffer_Uint8List(dynamic raw) {
    return raw as Uint8List;
  }

  CorrelationFlow _wire2api_correlation_flow(dynamic raw) {
    final arr = raw as List<dynamic>;
    if (arr.length != 2)
      throw Exception('unexpected arr length: expect 2 but see ${arr.length}');
    return CorrelationFlow(
      dx: _wire2api_i16(arr[0]),
      dy: _wire2api_i16(arr[1]),
    );
  }

  int _wire2api_i16(dynamic raw) {
    return raw as int;
  }

  int _wire2api_u8(dynamic raw) {
    return raw as int;
  }

  Uint8List _wire2api_uint_8_list(dynamic raw) {
    return raw as Uint8List;
  }

  void _wire2api_unit(dynamic raw) {
    return;
  }
}

// Section: api2wire

@protected
int api2wire_u8(int raw) {
  return raw;
}

class NativePlatform extends FlutterRustBridgeBase<NativeWire> {
  NativePlatform(ffi.DynamicLibrary dylib) : super(NativeWire(dylib));
// Section: api2wire

  @protected
  ffi.Pointer<wire_uint_8_list> api2wire_String(String raw) {
    return api2wire_uint_8_list(utf8.encoder.convert(raw));
  }

  @protected
  int api2wire_i64(int raw) {
    return raw;
  }

  @protected
  ffi.Pointer<wire_uint_8_list> api2wire_uint_8_list(Uint8List raw) {
    final ans = inner.new_uint_8_list_0(raw.length);
    ans.ref.ptr.asTypedList(raw.length).setAll(0, raw);
    return ans;
  }
// Section: api_fill_to_wire

}

// ignore_for_file: camel_case_types, non_constant_identifier_names, avoid_positional_boolean_parameters, annotate_overrides, constant_identifier_names

// AUTO GENERATED FILE, DO NOT EDIT.
//
// Generated by `package:ffigen`.

/// generated by flutter_rust_bridge
class NativeWire implements FlutterRustBridgeWireBase {
  /// Holds the symbol lookup function.
  final ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
      _lookup;

  /// The symbols are looked up in [dynamicLibrary].
  NativeWire(ffi.DynamicLibrary dynamicLibrary)
      : _lookup = dynamicLibrary.lookup;

  /// The symbols are looked up with [lookup].
  NativeWire.fromLookup(
      ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
          lookup)
      : _lookup = lookup;

  void store_dart_post_cobject(
    DartPostCObjectFnType ptr,
  ) {
    return _store_dart_post_cobject(
      ptr,
    );
  }

  late final _store_dart_post_cobjectPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(DartPostCObjectFnType)>>(
          'store_dart_post_cobject');
  late final _store_dart_post_cobject = _store_dart_post_cobjectPtr
      .asFunction<void Function(DartPostCObjectFnType)>();

  void wire_intensity_rgba(
    int port_,
    ffi.Pointer<wire_uint_8_list> intensities,
  ) {
    return _wire_intensity_rgba(
      port_,
      intensities,
    );
  }

  late final _wire_intensity_rgbaPtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(ffi.Int64,
              ffi.Pointer<wire_uint_8_list>)>>('wire_intensity_rgba');
  late final _wire_intensity_rgba = _wire_intensity_rgbaPtr
      .asFunction<void Function(int, ffi.Pointer<wire_uint_8_list>)>();

  void wire_yuv_rgba(
    int port_,
    ffi.Pointer<wire_uint_8_list> ys,
    ffi.Pointer<wire_uint_8_list> us,
    ffi.Pointer<wire_uint_8_list> vs,
    int width,
    int height,
    int uv_row_stride,
    int uv_pixel_stride,
  ) {
    return _wire_yuv_rgba(
      port_,
      ys,
      us,
      vs,
      width,
      height,
      uv_row_stride,
      uv_pixel_stride,
    );
  }

  late final _wire_yuv_rgbaPtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(
              ffi.Int64,
              ffi.Pointer<wire_uint_8_list>,
              ffi.Pointer<wire_uint_8_list>,
              ffi.Pointer<wire_uint_8_list>,
              ffi.Int64,
              ffi.Int64,
              ffi.Int64,
              ffi.Int64)>>('wire_yuv_rgba');
  late final _wire_yuv_rgba = _wire_yuv_rgbaPtr.asFunction<
      void Function(
          int,
          ffi.Pointer<wire_uint_8_list>,
          ffi.Pointer<wire_uint_8_list>,
          ffi.Pointer<wire_uint_8_list>,
          int,
          int,
          int,
          int)>();

  void wire_get_correlation_flow(
    int port_,
    ffi.Pointer<wire_uint_8_list> prev_ys,
    ffi.Pointer<wire_uint_8_list> current_ys,
    int width,
    int height,
  ) {
    return _wire_get_correlation_flow(
      port_,
      prev_ys,
      current_ys,
      width,
      height,
    );
  }

  late final _wire_get_correlation_flowPtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(
              ffi.Int64,
              ffi.Pointer<wire_uint_8_list>,
              ffi.Pointer<wire_uint_8_list>,
              ffi.Int64,
              ffi.Int64)>>('wire_get_correlation_flow');
  late final _wire_get_correlation_flow =
      _wire_get_correlation_flowPtr.asFunction<
          void Function(int, ffi.Pointer<wire_uint_8_list>,
              ffi.Pointer<wire_uint_8_list>, int, int)>();

  void wire_reset_position_estimate(
    int port_,
  ) {
    return _wire_reset_position_estimate(
      port_,
    );
  }

  late final _wire_reset_position_estimatePtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Int64)>>(
          'wire_reset_position_estimate');
  late final _wire_reset_position_estimate =
      _wire_reset_position_estimatePtr.asFunction<void Function(int)>();

  void wire_process_sensor_data(
    int port_,
    ffi.Pointer<wire_uint_8_list> incoming_data,
  ) {
    return _wire_process_sensor_data(
      port_,
      incoming_data,
    );
  }

  late final _wire_process_sensor_dataPtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(ffi.Int64,
              ffi.Pointer<wire_uint_8_list>)>>('wire_process_sensor_data');
  late final _wire_process_sensor_data = _wire_process_sensor_dataPtr
      .asFunction<void Function(int, ffi.Pointer<wire_uint_8_list>)>();

  ffi.Pointer<wire_uint_8_list> new_uint_8_list_0(
    int len,
  ) {
    return _new_uint_8_list_0(
      len,
    );
  }

  late final _new_uint_8_list_0Ptr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<wire_uint_8_list> Function(
              ffi.Int32)>>('new_uint_8_list_0');
  late final _new_uint_8_list_0 = _new_uint_8_list_0Ptr
      .asFunction<ffi.Pointer<wire_uint_8_list> Function(int)>();

  void free_WireSyncReturnStruct(
    WireSyncReturnStruct val,
  ) {
    return _free_WireSyncReturnStruct(
      val,
    );
  }

  late final _free_WireSyncReturnStructPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(WireSyncReturnStruct)>>(
          'free_WireSyncReturnStruct');
  late final _free_WireSyncReturnStruct = _free_WireSyncReturnStructPtr
      .asFunction<void Function(WireSyncReturnStruct)>();
}

class wire_uint_8_list extends ffi.Struct {
  external ffi.Pointer<ffi.Uint8> ptr;

  @ffi.Int32()
  external int len;
}

typedef DartPostCObjectFnType = ffi.Pointer<
    ffi.NativeFunction<ffi.Bool Function(DartPort, ffi.Pointer<ffi.Void>)>>;
typedef DartPort = ffi.Int64;
