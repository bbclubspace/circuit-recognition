import 'package:circuit_recognition/widgets/textfield/custom-textfield.dart';
import 'package:flutter/material.dart';

import '../../../themes/themes.dart';
import '../../../utils/responsive.dart';
import '../../../widgets/text/top-text.dart';

class SaveProject extends StatelessWidget {
  const SaveProject({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController projectNameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: Responsive.responsivePadding(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: Responsive.blockSizeVertical(context) * 5),
            //toptext
            TopText(text: "Yeni proje ekle"),
                        SizedBox(height: Responsive.blockSizeVertical(context) * 7),
            Padding(
              padding: const EdgeInsets.only(right: 250),
              child: Text(
                "Proje ismi",
                style: TextStyle(
                    color: AppColors.textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),

            CustomTextField(subText: "", controller:projectNameController,height: 54,width: 348,issubFixIcon: true,subFixIconPath: 'assets/hard-work.png', ),
            SizedBox(height: Responsive.blockSizeHorizontal(context)*20),
                        Padding(
              padding: const EdgeInsets.only(right: 250),
              child: Text(
                "Açıklama",
                style: TextStyle(
                    color: AppColors.textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
            CustomTextField(subText: "", controller:descriptionController,height: 200,width: 348 ),
          ],
        ),
      ),
    );
  }
}
