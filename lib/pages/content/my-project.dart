import 'package:circuit_recognition/services/ai/project/project-services.dart';
import 'package:circuit_recognition/widgets/container/content-container.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../../themes/themes.dart';
import '../../utils/responsive.dart';
import '../../widgets/myproject/project-text-and-image.dart';
import '../../widgets/text/top-text.dart';

class MyProject extends StatefulWidget {
  const MyProject({Key? key}) : super(key: key);

  @override
  State<MyProject> createState() => _MyProjectState();
}

class _MyProjectState extends State<MyProject> {
  Map<String, dynamic>? latestProject;
  List<Map<String, dynamic>> allProjects = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProjects();
  }

  Future<void> fetchProjects() async {
    final projectService = Provider.of<ProjectServices>(context, listen: false);
    List<Map<String, dynamic>> projects = await projectService.getProjectData();
    Map<String, dynamic>? latest = projects.isNotEmpty ? projects.first : null;

    setState(() {
      allProjects = projects;
      latestProject = latest;
      isLoading = false;
    });
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
        child: isLoading
            ? Center(
                child:
                    CircularProgressIndicator(color: AppColors.secondaryColor))
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TopText(text: "Projelerim"),
                  SizedBox(height: Responsive.blockSizeVertical(context) * 5),
                  latestProject != null
                      ? ContentContainer(
                          heightPercentage: 25,
                          widthPercentage: 90,
                          backgroundColor: AppColors.firstContainer,
                          strokeBottomColor: AppColors.firstStrokeColor,
                          strokeBottomWidth: 5,
                          isNewProjectContainer: false,
                          image: 'assets/hard-work.png',
                          isNetworkImage: false,
                          contentText:
                              latestProject!['projectName'] ?? 'Proje ismi yok',
                        )
                      : Text("Henüz proje eklenmemiş",
                          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
                  SizedBox(height: Responsive.blockSizeVertical(context) * 3),
                  Expanded(
                    child: ListView.builder(
                      itemCount: allProjects.length,
                      itemBuilder: (context, index) {
                        var project = allProjects[index];
                        return Column(
                          children: [
                            ProjectTextAndImage(
                              image: 'assets/working.png',
                              text: project['projectName'] ?? 'Proje',
                            ),
                            SizedBox(
                                height:
                                    Responsive.blockSizeVertical(context) * 2)
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
