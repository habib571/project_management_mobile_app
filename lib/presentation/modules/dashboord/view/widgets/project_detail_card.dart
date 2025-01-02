import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_management_app/presentation/sharedwidgets/image_widget.dart';
import 'package:project_management_app/presentation/utils/colors.dart';
import 'package:project_management_app/presentation/utils/styles.dart';

import '../../../../../domain/models/project.dart';

class ProjectDetailCard extends StatelessWidget {
  const ProjectDetailCard({super.key, });
  //final Project project;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17), color: Colors.white),
      child: Row(
        children: [
          _showTitles() ,
          const SizedBox(width: 15,) ,
          _showTitles()
        ],
      ),
    );
  }

  Widget _showTitles() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Project",
          style: robotoMedium.copyWith(
              color: AppColors.secondaryTxt, fontSize: 13),
        ),
        Text(
          "Due date",
          style: robotoMedium.copyWith(
              color: AppColors.secondaryTxt, fontSize: 13),
        ),
        Text(
          "Created by",
          style: robotoMedium.copyWith(
              color: AppColors.secondaryTxt, fontSize: 13),
        ),
      ],
    );
  }

  Widget _showContent() {
    return Column(
      children: [
        Text(
          'Erp app',
          style: robotoMedium.copyWith(fontSize: 14),
        ),
        Row(
          children: [
            Image.asset('assets/calendar.png'),
            Text('02/05/2025')
          ],
        ),
        Row(
          children: [
            const ImagePlaceHolder(
              radius: 10,
              imageUrl:
                  'https://images.unsplash.com/photo-1567784177951-6fa58317e16b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
            ),
            Text(
               'habib rouatbi',
              style: robotoMedium.copyWith(fontSize: 14),
            )
          ],
        )
      ],
    );
  }
}
