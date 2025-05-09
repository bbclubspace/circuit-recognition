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
  final bool? isLoading;

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
    this.isLoading,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap?.call(),
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
            if (isLoading == true)
              const CircularProgressIndicator()
            else if (isNetworkImage)
              // Burada ağ üzerinden resim yüklemek için Image.network kullanıyoruz
              Image.network(
                image, // Ağ adresi (URL) burada olacak
                width: 250,
                height: 250,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error, color: Colors.red);
                },
              )
            else
              Image.asset(
                image,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                contentText,
                style: TextStyle(
                  fontSize: Responsive.textSize(context, 4.5),
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.primary,
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
