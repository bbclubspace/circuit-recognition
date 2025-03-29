import 'package:flutter/material.dart';

class Responsive {
  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
  static double blockSizeHorizontal(BuildContext context) =>
      screenWidth(context) / 100;
  static double blockSizeVertical(BuildContext context) =>
      screenHeight(context) / 100;

  // Responsive text sizes
  static double textSize(BuildContext context, double size) =>
      blockSizeHorizontal(context) * size;

  // Responsive padding
  static EdgeInsets responsivePadding(BuildContext context ) =>
      EdgeInsets.symmetric(
        horizontal: blockSizeHorizontal(context) * 5,
        vertical: blockSizeVertical(context) * 2,
      );

  // Responsive container sizes
  static double containerWidth(BuildContext context, double percentage) =>
      screenWidth(context) * (percentage / 100);
  static double containerHeight(BuildContext context, double percentage) =>
      screenHeight(context) * (percentage / 100);
}
