import 'utils/constants.dart';
import 'dart:math' as math;
import 'components/center_widget/center_widget.dart';
import 'components/login_content.dart';
import 'package:login_screen/screens/login_screen/animations/change_screen_animation.dart';
import 'package:ionicons/ionicons.dart';
import 'package:login_screen/utils/helper_functions.dart';
import '../animations/change_screen_animation.dart';
import 'bottom_text.dart';
import 'top_text.dart';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:login_screen/main.dart';
import 'package:flutter_test/flutter_test.dart';
import '../components/login_content.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:ui';
import 'center_widget_clipper.dart';
import 'center_widget_painter.dart';
import '../../../utils/constants.dart';
import 'login_content.dart';

class CenterWidgetPainter extends CustomPainter {
  final Path path;

  const CenterWidgetPainter({required this.path});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..imageFilter = ImageFilter.blur(sigmaX: 10, sigmaY: 10)
      ..color = Colors.black26;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CenterWidgetPainter oldDelegate) => false;
}
