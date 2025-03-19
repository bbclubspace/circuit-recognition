import 'package:circuit_recognition/themes/themes.dart';
import 'package:flutter/material.dart';

class ContentContainer extends StatelessWidget {
  final Color backgroundColor;
  final double height;
  final double width;

  final Color? strokeTopColor;
  final double? strokeTopWidth;

  final Color? strokeBottomColor;
  final double? strokeBottomWidth;

  final Color? strokeLeftColor;
  final double? strokeLeftWidth;

  final Color? strokeRightColor;
  final double? strokeRightWidth;

  const ContentContainer({
    required this.backgroundColor,
    required this.height,
    required this.width,
    super.key,
    this.strokeTopColor,
    this.strokeTopWidth,
    this.strokeBottomColor,
    this.strokeBottomWidth,
    this.strokeLeftColor,
    this.strokeLeftWidth,
    this.strokeRightColor,
    this.strokeRightWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: AppColors.secondContainer,
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.primaryColor,
            backgroundColor,
          ],
        ),
        // Kenarlık özelliklerini dinamik olarak oluşturuyoruz
        border: _getBorder(),
      ),
    );
  }

  Border? _getBorder() {
    final BorderSide? topSide = strokeTopColor != null && strokeTopWidth != null
        ? BorderSide(color: strokeTopColor!, width: strokeTopWidth!)
        : null;

    final BorderSide? bottomSide = strokeBottomColor != null && strokeBottomWidth != null
        ? BorderSide(color: strokeBottomColor!, width: strokeBottomWidth!)
        : null;

    final BorderSide? leftSide = strokeLeftColor != null && strokeLeftWidth != null
        ? BorderSide(color: strokeLeftColor!, width: strokeLeftWidth!)
        : null;

    final BorderSide? rightSide = strokeRightColor != null && strokeRightWidth != null
        ? BorderSide(color: strokeRightColor!, width: strokeRightWidth!)
        : null;

    if (topSide == null &&
        bottomSide == null &&
        leftSide == null &&
        rightSide == null) {
      return null;
    }
    return Border(
      top: topSide ?? BorderSide.none,
      bottom: bottomSide ?? BorderSide.none,
      left: leftSide ?? BorderSide.none,
      right: rightSide ?? BorderSide.none,
    );
  }
}