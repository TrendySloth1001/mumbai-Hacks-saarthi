import 'package:flutter/material.dart';
import 'colors.dart';


class xShadowStyle {
  static final verticalProductShadow = BoxShadow(
      color: xColors.darkGrey.withOpacity(0.1),
      blurRadius: 50,
      spreadRadius: 7,
      offset: const Offset(0, 2));
  static final horizontalProductShadow = BoxShadow(
      color: xColors.darkGrey.withOpacity(0.1),
      blurRadius: 50,
      spreadRadius: 7,
      offset: const Offset(0, 2));
}
