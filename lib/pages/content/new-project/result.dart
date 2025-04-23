import 'package:circuit_recognition/services/content/content-services.dart';
import 'package:circuit_recognition/widgets/button/go-next-button.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import '../../../utils/responsive.dart';
import '../../../widgets/button/project-proposal-button.dart';
import '../../../widgets/container/result-container.dart';
import '../../../widgets/text/top-text.dart';

class Result extends StatelessWidget {
  final List<String>? resultList;

  const Result({Key? key, this.resultList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ContentServices contentServices= Provider.of<ContentServices>(context, listen: false);
    if (resultList != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<ContentServices>(context, listen: false)
            .setResults(resultList!);
      });
    }

    void goSaveProject() {
      Navigator.pushNamed(context, "/save-project");
    }
void goProjectProposal() async {
  final validItems = contentServices.updatedResultList.isNotEmpty
      ? contentServices.updatedResultList
      : contentServices.resultList;

  if (validItems.isEmpty) {
    await QuickAlert.show(
      context: context,
      type: QuickAlertType.warning,
      title: 'Eksik Bilgi',
      text: 'Proje oluşturmak için önce malzeme listesi girilmelidir.',
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

  final result = await contentServices.projectProposal();
  Navigator.of(context, rootNavigator: true).pop();
  if (result != null) {
    await QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: 'Başarılı',
      text: 'Proje önerileri oluşturuldu.',
      autoCloseDuration: const Duration(seconds: 1),
    );
    Navigator.pushNamed(context, "/project-proposal");
    print("Gelen Projeler: ${contentServices.projectProposals}");
  } else {
    await QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Hata',
      text: 'Proje önerileri alınamadı. Lütfen tekrar deneyin.',
    );
  }
}



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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: TopText(text: "Yapay zeka sonuçları"),
            ),
            SizedBox(height: Responsive.blockSizeVertical(context) * 5),
            Padding(
              padding: EdgeInsets.only(left: 90),
              child: Text(
                "Malzeme ekle/çıkart",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(height: Responsive.blockSizeVertical(context)),
            const Flexible(
                flex: 1,
                child: SingleChildScrollView(child: ResultContainer())),
            SizedBox(height: Responsive.blockSizeVertical(context) * 5),
            ProjectProposalButton(onTap: goProjectProposal,),
            SizedBox(height: Responsive.blockSizeVertical(context) * 15),
            GoNextButton(onTap: goSaveProject),
          ],
        ),
      ),
    );
  }
}


