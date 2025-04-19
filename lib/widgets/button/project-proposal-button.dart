import 'package:flutter/material.dart';

import '../../themes/themes.dart';

class ProjectProposalButton extends StatelessWidget {
  const ProjectProposalButton({
    super.key,
    required this.onTap
  });
final VoidCallback? onTap;



  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap?.call(),
      child: Center(
        child: Container(
          width: 230,
          height: 50,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF0E4A67),
                Color(0xFF3CBAFD),
              ],
            ),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Center(
            child: Text(
              "Yapılabilecek projeler",
              style: TextStyle(
                color: AppColors.authButtonText,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ),
        ),
      ),
    );
  }
}