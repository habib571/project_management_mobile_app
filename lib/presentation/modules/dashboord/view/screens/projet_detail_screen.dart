import 'package:flutter/material.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';
import 'package:project_management_app/presentation/modules/dashboord/view/widgets/project_detail_card.dart';
import 'package:project_management_app/presentation/utils/colors.dart';
import 'package:project_management_app/presentation/utils/styles.dart';

class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_back_rounded))),
              Expanded(
                  child: Text(
                'Project Detail',
                style: robotoBold.copyWith(fontSize: 18),
              ))
            ],
          ) ,
          SizedBox(height: 50.h,) ,
          _showProjectInfo() ,
          SizedBox(height: 30.h,) ,
          _showProjectDescription()
        ],
      ),
    ));
  }

  _showProjectInfo() {
    ProjectDetailCard();
  }

  Widget _showProjectDescription() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: robotoMedium.copyWith(fontSize: 14),
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
              child: Text(
            'erp app for saudien customer aims to manage all company ressources adding to that financal anf human ressources',
            style: robotoMedium.copyWith(
                color: AppColors.secondaryTxt, fontSize: 13),
          ))
        ],
      ),
    );
  }
}
