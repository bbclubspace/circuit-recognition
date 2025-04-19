import 'package:circuit_recognition/services/content/content-services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../themes/themes.dart';
import '../../utils/responsive.dart';

class ResultContainer extends StatelessWidget {
  const ResultContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ContentServices>(
      builder: (context, provider, _) {
        return GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: Responsive.containerWidth(context, 35),
            crossAxisSpacing: 5,
            mainAxisSpacing: 10,
            childAspectRatio: 2.25,
          ),
          itemCount: provider.resultList.length,
          itemBuilder: (context, index) {
            final item = provider.resultList[index];
            final isRemoved = provider.isRemoved(item);

            return GestureDetector(
              onTap: () => provider.toggleItem(item),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: isRemoved
                        ? Colors.white
                        : AppColors.resultContainerBackground,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.resultBorder),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        item,
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 12, // bir tık küçülttük
                          color: isRemoved ? Colors.grey : AppColors.resultText,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
