import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';
import 'package:project_management_app/application/navigation/routes_constants.dart';
import 'package:project_management_app/presentation/modules/dashboord/view/screens/projet_detail_screen.dart';
import 'package:project_management_app/presentation/sharedwidgets/custom_button.dart';
import 'package:project_management_app/presentation/utils/colors.dart';
import 'package:project_management_app/presentation/utils/styles.dart';

import '../../../../../domain/models/project.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({super.key, required this.project});
  final Project project ;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(()=>const ProjectDetailScreen()) ;
      },
      child: Card(
        color: AppColors.primary,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      project.name!,
                      style: robotoMedium.copyWith(color: Colors.white, fontSize: 18),
                    ),
                    SizedBox(height: 22.h,) ,
                    SizedBox(
                      width: 110,
                      child: CustomButton(
                        padding: 5,
                        onPressed: () {

                        },
                        text: 'View Project',
                        height: 40,
                        borderRadius: 12,
                        textColor: AppColors.primary,
                        buttonColor: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: CircularPercentIndicator(
                  radius: 40,
                  lineWidth: 10.0,
                  percent: 0.8,
                  center: Text(
                    project.progress.toString(),
                    style: robotoRegular.copyWith(color: Colors.white),
                  ),
                  backgroundColor: AppColors.accent,
                  progressColor: Colors.white
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
