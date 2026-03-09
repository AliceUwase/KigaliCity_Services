import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Custom ScrollBehavior to enable mouse dragging on desktop and web.
class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
        PointerDeviceKind.stylus,
      };
}
