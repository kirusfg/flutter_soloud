import 'dart:ffi' as ffi;
import 'dart:io';

import 'package:flutter_soloud/src/bindings_player_ffi.dart';

/// Controller that expose method channel and FFI
class SoLoudController {
  ///
  factory SoLoudController() => _instance ??= SoLoudController._();

  SoLoudController._() {
    initialize();
  }

  static SoLoudController? _instance;

  ///
  late ffi.DynamicLibrary nativeLib;

  ///
  late final FlutterSoLoudFfi soLoudFFI;

  ///
  void initialize() {
    nativeLib = Platform.isLinux
        ? ffi.DynamicLibrary.open('libflutter_soloud_plugin.so')
        : (Platform.isAndroid
            ? ffi.DynamicLibrary.open('libflutter_soloud_plugin.so')
            : (Platform.isWindows
                ? ffi.DynamicLibrary.open('flutter_soloud_plugin.dll')
                : ffi.DynamicLibrary.process()));
    soLoudFFI = FlutterSoLoudFfi.fromLookup(nativeLib.lookup);
  }
}
