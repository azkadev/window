library window_app;

import 'package:flutter/foundation.dart';
import "package:universal_io/io.dart";

import 'package:flutter/material.dart';

import 'bitsdojo_window/bitsdojo_window.dart';
export "bitsdojo_window/bitsdojo_window.dart";
 

class WindowApp {
  static Future<void> init({
    required Size initialSize,
    required Size minSize,
  }) async {
    if (Platform.isAndroid) {
    } else if (Platform.isIOS) {
    } else {
      if (!kIsWeb) {
        doWhenWindowReady(() {
          appWindow.minSize = minSize;
          appWindow.size = initialSize;
          appWindow.alignment = Alignment.center;
          appWindow.show();
        });
      }
    }
    return;
  }
}
