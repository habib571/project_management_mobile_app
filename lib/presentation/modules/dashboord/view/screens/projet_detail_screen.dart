import 'package:flutter/material.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';
import 'package:project_management_app/presentation/modules/dashboord/view/widgets/project_detail_card.dart';
import 'package:project_management_app/presentation/sharedwidgets/custom_appbar.dart';
import 'package:project_management_app/presentation/utils/colors.dart';
import 'package:project_management_app/presentation/utils/styles.dart';

class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.scaffold ,
          body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomAppBar(title: 'Project Details'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: 50.h,
                  ),
                  _showProjectInfo(),
                  SizedBox(
                    height: 30.h,
                  ),
                  _showProjectDescription()
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }

  Widget _showProjectInfo() {
    return const ProjectDetailCard();
  }

  Widget _showProjectDescription() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: robotoMedium.copyWith(fontSize: 14),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'erp app for saudien customer aims to manage all company ressources adding to that financal anf human ressources',
            style: robotoMedium.copyWith(
                color: AppColors.secondaryTxt, fontSize: 13),
          )
        ],
      ),
    );
  }
}
