import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:project_management_app/application/navigation/routes_constants.dart';
import 'package:project_management_app/presentation/sharedwidgets/image_widget.dart';
import 'package:project_management_app/presentation/utils/colors.dart';
import 'package:project_management_app/presentation/utils/styles.dart';
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
        borderRadius: BorderRadius.circular(17),
        color: Colors.white,
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
            const ImagePlaceHolder(
              radius: 10,
              imageUrl:
                  'https://images.unsplash.com/photo-1567784177951-6fa58317e16b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
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
