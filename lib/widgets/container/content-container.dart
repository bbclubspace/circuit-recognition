import 'package:flutter/material.dart';

import '../../themes/themes.dart';
import '../../utils/responsive.dart';

class ContentContainer extends StatelessWidget {
  final Color backgroundColor;
  final double heightPercentage;
  final double widthPercentage;
  final bool isNetworkImage;
  final String image;
  final String contentText;
  final bool isNewProjectContainer;

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
    required this.image,
    required this.contentText,
    required this.isNetworkImage,
    required this.isNewProjectContainer,
    this.strokeTopColor,
    this.strokeTopWidth,
    this.strokeBottomColor,
    this.strokeBottomWidth,
    this.strokeLeftColor,
    this.strokeLeftWidth,
    this.strokeRightColor,
    this.strokeRightWidth,
    this.onTap,
    super.key,
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
            isNetworkImage
                ? Image.network(
                    image,
                    width: 275,
                    height: 275,
                    fit: BoxFit.contain,
                  )
                : Image.asset(
                    image,
                    width: 60,
                    height: 60,
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

    final BorderSide? bottomSide =
        strokeBottomColor != null && strokeBottomWidth != null
            ? BorderSide(color: strokeBottomColor!, width: strokeBottomWidth!)
            : null;

    final BorderSide? leftSide =
        strokeLeftColor != null && strokeLeftWidth != null
            ? BorderSide(color: strokeLeftColor!, width: strokeLeftWidth!)
            : null;

    final BorderSide? rightSide =
        strokeRightColor != null && strokeRightWidth != null
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
