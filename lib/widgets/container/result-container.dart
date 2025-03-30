import 'package:flutter/material.dart';

import '../../themes/themes.dart';
import '../../utils/responsive.dart';

class ResultContainer extends StatelessWidget {
  const ResultContainer({
    super.key,
    required this.resultList,
  });

  final List resultList;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: Responsive.containerWidth(context, 35),
        crossAxisSpacing: 5,
        mainAxisSpacing: 10,
        childAspectRatio: 2.25,
      ),
      itemCount: resultList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 150,
            child: Container(
              decoration: BoxDecoration(
                color: index % 2 == 0
                    ? AppColors.resultContainerBackground
                    : AppColors.primaryColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.resultBorder),
              ),
              child: Center(
                child: Text(
                  resultList[index],
                  style: TextStyle(
                      fontSize: 15,
                      color: AppColors.resultText,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}