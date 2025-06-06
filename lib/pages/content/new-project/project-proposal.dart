import 'package:circuit_recognition/widgets/text/top-text.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../../../services/content/content-services.dart';
import '../../../utils/responsive.dart';
import '../../../widgets/container/example-project-container.dart';

class ProjectProposal extends StatelessWidget {
  const ProjectProposal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contentServices = Provider.of<ContentServices>(context);

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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TopText(text: "Yapılabilecek Projeler"),
              SizedBox(height: Responsive.blockSizeVertical(context) * 5),
              Center(
                child: Text(
                  contentServices.updatedResultList.isNotEmpty
                      ? "Mevcut malzemeler: ${contentServices.updatedResultList.join(', ')}"
                      : "Malzeme listesi boş.",
                  style: TextStyle(color: Theme.of(context).colorScheme.onPrimary,fontWeight: FontWeight.w500),
                ),
              ),
          
          
              SizedBox(height: Responsive.blockSizeVertical(context) * 5),
              ...contentServices.projectProposals.map((project) => Padding(
                    padding: EdgeInsets.only(
                        bottom: Responsive.blockSizeVertical(context) * 2),
                    child: ExampleProjectContainer(
                      title: project['title']!,
                      description: project['description']!,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
