import 'package:flutter/material.dart';

void doWhenWindowReady(void Function() fn) {}

class appWindow {
  static set minSize(Size size) {}
  static set size(Size size) {}

  static set alignment(Alignment alignment) {}

  static void show() {}

  static bool get isMaximized {
    return false;
  }

  static void maximizeOrRestore() {
    return;
  }

  static void minimize() {
    return;
  }

  static void close() {
    return;
  }
}

class MoveWindow extends StatelessWidget {
  final Widget child;
  const MoveWindow({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
