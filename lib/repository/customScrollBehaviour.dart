import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Customscrollbehaviour extends MaterialScrollBehavior {
  Set<PointerDeviceKind> get dragDevice =>
      {PointerDeviceKind.mouse, PointerDeviceKind.touch};
}
