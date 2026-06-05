import 'package:flutter/material.dart';

extension Responsive on BuildContext {
  Size get size => MediaQuery.of(this).size;

  double get w => size.width;
  double get h => size.height;

  bool get isMobile => w < 600;
  bool get isTablet => w >= 600 && w < 1024;
  bool get isDesktop => w >= 1024;

  double wp(double percent) => w * percent;
  double hp(double percent) => h * percent;
}