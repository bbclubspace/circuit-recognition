import 'dart:io';
import 'package:circuit_recognition/pages/content/new-project/result.dart';
import 'package:circuit_recognition/services/ai/ai-services.dart';

import 'package:circuit_recognition/utils/responsive.dart';
import 'package:circuit_recognition/widgets/button/go-next-button.dart';
import 'package:circuit_recognition/widgets/text/top-text.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

import '../../../themes/themes.dart';
import '../../../widgets/container/content-container.dart';

class AddImage extends StatefulWidget {
  const AddImage({Key? key}) : super(key: key);

  @override
  State<AddImage> createState() => _NewProjectState();
}

class _NewProjectState extends State<AddImage> {
  final _imagepicker = ImagePicker();
  final List<String> result = [];
  RxString picture = "".obs;
  RxList idList = [].obs;
  late AiServices aiServices;

  @override
  void initState() {
    super.initState();
    aiServices = Provider.of<AiServices>(context, listen: false);
  }

void goResult() async {
  if (aiServices.imageUrl.isEmpty) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Hata!',
      text: 'Resim urlsi alınamadı',
    );
    return; // imageUrl boşsa işlemi durdur
  }

  aiServices.setIsResultNotGet(true);
  if (aiServices.isResultNotGet) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.loading,
      title: 'Yükleniyor...',
      text: 'Lütfen bekleyin',
      barrierDismissible: false,
    );
  }

  final resultData = await aiServices.uploadImageAi();
  result.clear();
  result.addAll(resultData);
  Navigator.pop(context);
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Result(resultList: result),
    ),
  );

  aiServices.setIsResultNotGet(false);
}


  Future<void> pickImage() async {
    result.clear();
    final pickedFile = await _imagepicker.pickImage(
        source: ImageSource.gallery, imageQuality: 25);

    if (pickedFile == null) {
      print('user cancelled the image selection');
      return;
    } else {
      await aiServices.uploadImage(File(pickedFile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Ionicons.chevron_back_outline),
        ),
        leadingWidth: 80,
      ),
      body: Padding(
        padding: Responsive.responsivePadding(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TopText(text: "Malzemeleri Belirleyelim"),
            SizedBox(height: Responsive.blockSizeVertical(context) * 7),
            Consumer<AiServices>(
              builder: (context, aiServices, _) {
                return ContentContainer(
                  heightPercentage: 35,
                  widthPercentage: 85,
                  backgroundColor: AppColors.secondContainer,
                  strokeTopColor: AppColors.secondStrokeColor,
                  strokeTopWidth: 1.5,
                  isNewProjectContainer: true,
                  image: aiServices.isImageUrl
                      ? aiServices.imageUrl
                      : "assets/photo.png",
                  isNetworkImage: aiServices.isImageUrl,
                  contentText: 'Görsel ekle',
                  onTap: pickImage,
                );
              },
            ),

            SizedBox(height: Responsive.blockSizeVertical(context) * 20),
            GoNextButton(
              onTap: goResult,
            )
          ],
        ),
      ),
    );
  }
}