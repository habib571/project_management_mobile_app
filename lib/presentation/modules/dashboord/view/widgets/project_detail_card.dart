import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:project_management_app/application/navigation/routes_constants.dart';
import 'package:project_management_app/presentation/sharedwidgets/image_widget.dart';
import 'package:project_management_app/presentation/utils/colors.dart';
import 'package:project_management_app/presentation/utils/styles.dart';
import '../../../../../application/constants/constants.dart';
import '../../../../../domain/models/project.dart';
import '../../../manageprojects/viewmodel/manage-project-view-model.dart';


class ProjectDetailCard extends StatelessWidget {
    ProjectDetailCard({
    super.key, required this.project,
  });
    final viewModel = GetIt.instance.get<ManageProjectViewModel>(param1: true);

  final Project project;
  @override
  Widget build(BuildContext context) {
    return Container(

      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: AppColors.accent.withOpacity(0.5), blurRadius: 10)
          ],
          borderRadius: BorderRadius.circular(12)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              children: [
                _showTitles(),
                const SizedBox(width: 15),
                _showContent(),
              ],
            ),
          ),

          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {
              Get.toNamed(AppRoutes.addproject,arguments: {"toEdit": true});
            },
          ),
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
        const SizedBox(
          height: 12,
        ),
        Text(
          "Due date",
          style: robotoMedium.copyWith(
              color: AppColors.secondaryTxt, fontSize: 13),
        ),
        const SizedBox(
          height: 12,
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          project.name ?? "",
          style: robotoMedium.copyWith(fontSize: 14),
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          children: [
            Image.asset('assets/calendar.png'),
             Text(project.endDate ?? "")
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          children: [
            ImagePlaceHolder(
              radius: 10,
              imageUrl: project.createdBy?.imageUrl,//"${Constants.baseUrl}/images/${project.createdBy?.imageUrl}" ,
              fullName: project.createdBy?.fullName ?? "Loading ..." ,
            ),
            const SizedBox(
              width: 7,
            ),
            Text(
              project.createdBy?.fullName ?? "" ,
              style: robotoMedium.copyWith(fontSize: 14),
            )
          ],
        )
      ],
    );
  }
}
