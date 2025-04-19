import 'package:circuit_recognition/services/ai/project/project-services.dart';
import 'package:circuit_recognition/widgets/button/go-next-button.dart';
import 'package:circuit_recognition/widgets/textfield/custom-textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import '../../../themes/themes.dart';
import '../../../utils/responsive.dart';
import '../../../widgets/text/top-text.dart';

// ignore: must_be_immutable
class SaveProject extends StatefulWidget {
  SaveProject({Key? key}) : super(key: key);

  @override
  State<SaveProject> createState() => _SaveProjectState();
}

class _SaveProjectState extends State<SaveProject> {
  TextEditingController projectNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late ProjectServices projectServices;

  @override
  void initState() {
    super.initState();
    projectServices = Provider.of<ProjectServices>(context, listen: false);
  }

  void saveData() async {
    if (projectNameController.text.isEmpty ||
        descriptionController.text.isEmpty) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Eksik Bilgi',
        text: 'Lütfen proje ismi ve açıklama girin.',
      );
      return;
    }
    QuickAlert.show(
      context: context,
      type: QuickAlertType.loading,
      title: 'Yükleniyor...',
      text: 'Lütfen bekleyin',
      barrierDismissible: false,
    );

    await projectServices.saveProject(
        projectNameController.text, descriptionController.text);

    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: 'Başarılı',
      text: 'Proje kaydedildi!',
    );

    await Future.delayed(Duration(seconds: 1));
    Navigator.pushNamed(context, "/home");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: Responsive.responsivePadding(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: Responsive.blockSizeVertical(context) * 7),
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

            CustomTextField(
              subText: "",
              controller: projectNameController,
              height: 54,
              width: 348,
              issubFixIcon: true,
              subFixIconPath: 'assets/hard-work.png',
            ),
            SizedBox(height: Responsive.blockSizeHorizontal(context) * 20),
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

            CustomTextField(
                subText: "",
                controller: descriptionController,
                height: 200,
                width: 348),
            GoNextButton(onTap: saveData),
          ],
        ),
      ),
    );
  }
}
