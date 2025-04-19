import 'package:flutter/material.dart';

import '../../themes/themes.dart';
import '../../utils/responsive.dart';

class ExampleProjectContainer extends StatefulWidget {
  final String title;
  final String description;

  const ExampleProjectContainer({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  State<ExampleProjectContainer> createState() =>
      _ExampleProjectContainerState();
}

class _ExampleProjectContainerState extends State<ExampleProjectContainer> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 288,
      decoration: BoxDecoration(
        color: AppColors.containerColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: Responsive.blockSizeVertical(context) * 2),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      color: AppColors.authButtonText,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    softWrap: true,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                icon: Icon(
                  _isExpanded
                      ? Icons.arrow_drop_up
                      : Icons.arrow_drop_down_circle,
                  color: AppColors.iconButtonColor,
                ),
              ),
            ],
          ),
          if (_isExpanded)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(
                widget.description,
                style: TextStyle(color: AppColors.descriptionTextColor),
              ),
            ),
        ],
      ),
    );
  }
}
