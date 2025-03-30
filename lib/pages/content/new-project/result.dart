import 'package:circuit_recognition/widgets/button/go-next-button.dart';
import 'package:flutter/material.dart';
import '../../../themes/themes.dart';
import '../../../utils/responsive.dart';
import '../../../widgets/container/result-container.dart';
import '../../../widgets/text/top-text.dart';

class Result extends StatelessWidget {
  const Result({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List resultList = ["Ardunio", "LCD ekran", "Direnç", "Led"];
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: Responsive.responsivePadding(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Responsive.blockSizeVertical(context) * 10),
            //toptext
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: TopText(text: "Yapay zeka sonuçları"),
            ),
            SizedBox(height: Responsive.blockSizeVertical(context) * 7),
            //result text
            Padding(
              padding: EdgeInsets.only(left: 90),
              child: Text("Malzeme ekle/çıkart",
                  style: TextStyle(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
            ),
            SizedBox(height: Responsive.blockSizeVertical(context)),
            //results
            ResultContainer(resultList: resultList),
            SizedBox(height: Responsive.blockSizeVertical(context) * 20),
            GoNextButton(onTap: () {})
          ],
        ),
      ),
    );
  }
}


