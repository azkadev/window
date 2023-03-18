library window;

import "package:universal_io/io.dart";

import 'package:flutter/material.dart';

import 'bitsdojo_window/bitsdojo_window.dart';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}

class Window {
  static Future<void> init({
    required Size initialSize,
    required Size minSize,
  }) async {
    if (Platform.isAndroid) {
    } else if (Platform.isIOS) {
    } else {
      doWhenWindowReady(() {
        
        appWindow.minSize = minSize;
        appWindow.size = initialSize;
        appWindow.alignment = Alignment.center;
        appWindow.show();
      });
    }
    return;
  }
}
