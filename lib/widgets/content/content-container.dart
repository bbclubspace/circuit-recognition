import 'package:circuit_recognition/themes/themes.dart';
import 'package:circuit_recognition/utils/responsive.dart';
import 'package:flutter/material.dart';

class ContentContainer extends StatelessWidget {
  final Color backgroundColor;
  final double heightPercentage;
  final double widthPercentage;

  final String image;
  final String contentText;

  final Color? strokeTopColor;
  final double? strokeTopWidth;

  final Color? strokeBottomColor;
  final double? strokeBottomWidth;

  final Color? strokeLeftColor;
  final double? strokeLeftWidth;

  final Color? strokeRightColor;
  final double? strokeRightWidth;

  final Function? onTap;

  const ContentContainer({
    required this.backgroundColor,
    required this.heightPercentage,
    required this.widthPercentage,
    super.key,
    this.strokeTopColor,
    this.strokeTopWidth,
    this.strokeBottomColor,
    this.strokeBottomWidth,
    this.strokeLeftColor,
    this.strokeLeftWidth,
    this.strokeRightColor,
    this.strokeRightWidth,
    required this.image,
    required this.contentText,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap!(),
      child: Container(
        height: Responsive.containerHeight(context, heightPercentage),
        width: Responsive.containerWidth(context, widthPercentage),
        decoration: BoxDecoration(
          color: AppColors.secondContainer,
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primaryColor,
              backgroundColor,
            ],
          ),
          border: _getBorder(),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              width: Responsive.containerWidth(context, 15),
              height: Responsive.containerHeight(context, 15),
              fit: BoxFit.contain,
            ),
            Center(
              child: Text(
                contentText,
                style: TextStyle(
                  fontSize: Responsive.textSize(context, 4.5),
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
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