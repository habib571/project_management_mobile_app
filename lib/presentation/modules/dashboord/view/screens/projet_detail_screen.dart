import 'package:flutter/material.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';
import 'package:project_management_app/domain/models/project.dart';
import 'package:project_management_app/presentation/modules/dashboord/view/widgets/members_card.dart';
import 'package:project_management_app/presentation/modules/dashboord/view/widgets/project_detail_card.dart';
import 'package:project_management_app/presentation/sharedwidgets/custom_appbar.dart';
import 'package:project_management_app/presentation/sharedwidgets/image_widget.dart';
import 'package:project_management_app/presentation/utils/colors.dart';
import 'package:project_management_app/presentation/utils/styles.dart';

class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({super.key, required this.project});
  // final DashBoardViewModel _viewModel = instance<DashBoardViewModel>();
  final Project project;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor : AppColors.scaffold ,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 25.h,
              ),
              const CustomAppBar(title: 'Project Details'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50.h,
                    ),
                    ProjectDetailCard(
                      project: project,
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    _showProjectDescription(),
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Members',
                            style: robotoSemiBold.copyWith(fontSize: 16)),
                        GestureDetector(
                          child: Text(
                            'View members details ',
                            style: robotoRegular.copyWith(
                                color: Colors.lightBlue, fontSize: 13),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    _showMembers()
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget _showProjectDescription() {
    return Container(
      width: double.infinity,
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
            project.description!,
            style: robotoMedium.copyWith(
                color: AppColors.secondaryTxt, fontSize: 13),
          )
        ],
      ),
    );
  }

  Widget _showMembers() {
    return MembersCard(
        children:   [
         ...List.generate(14, (index) {
            return const ImagePlaceHolder(
                radius: 15,
                imageUrl:
                'https://images.unsplash.com/photo-1567784177951-6fa58317e16b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80');
          }) ,
          IconButton(onPressed: () {}, icon: Icon(Icons.add_circle_outline) ,iconSize: 30,)
        ]
    );
  }
}
