import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_app/application/dependencyInjection/dependency_injection.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';
import 'package:project_management_app/application/navigation/routes_constants.dart';
import 'package:project_management_app/domain/models/project.dart';
import 'package:project_management_app/presentation/modules/dashboord/view/screens/members_screen.dart';
import 'package:project_management_app/presentation/modules/dashboord/view/widgets/members_card.dart';
import 'package:project_management_app/presentation/modules/dashboord/view/widgets/project_detail_card.dart';
import 'package:project_management_app/presentation/modules/dashboord/viewmodel/project_detail_view_model.dart';
import 'package:project_management_app/presentation/sharedwidgets/custom_appbar.dart';
import 'package:project_management_app/presentation/sharedwidgets/image_widget.dart';
import 'package:project_management_app/presentation/stateRender/state_render_impl.dart';
import 'package:project_management_app/presentation/utils/colors.dart';
import 'package:project_management_app/presentation/utils/styles.dart';

import '../../../../sharedwidgets/custom_button.dart';
import '../../../../sharedwidgets/custum_search_delegate.dart';

class ProjectDetailScreen extends StatefulWidget {
  const ProjectDetailScreen({super.key, });


  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {
  @override
  void initState() {
     _viewModel.start() ;
    super.initState();
  }
  final ProjectDetailViewModel _viewModel = instance<ProjectDetailViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.scaffold,
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
                      project: _viewModel.project,
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
                          onTap: () => Get.to(() =>  MembersScreen()),
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
                    CustomButton(text: 'Add member',onPressed: () {
                      showSearch(context: context, delegate: CustomSearchDelegate("find users ...."));
                    }, ),
                    StreamBuilder<FlowState>(
                        stream: _viewModel.outputState,
                        builder: (context, snapshot) {
                          return snapshot.data?.getScreenWidget(
                                  context, _showMembers(), () {}) ??
                              _showMembers();
                        })
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
            _viewModel.project.description!,
            style: robotoMedium.copyWith(
                color: AppColors.secondaryTxt, fontSize: 13),
          )
        ],
      ),
    );
  }

  Widget _showMembers() {
    return MembersCard(children: [
      ...List.generate(_viewModel.projectMember.length, (index) {
        return const ImagePlaceHolder(
            radius: 17,
            imageUrl:
                'https://images.unsplash.com/photo-1567784177951-6fa58317e16b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80');
      }),
      GestureDetector(
        onTap: () {},
        child: Container(
          height: 34,
          width: 34,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primary, width: 2),
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Icon(Icons.add,
                size: 25, color: AppColors.primary), // Adjust size if needed
          ),
        ),
      )
    ]);
  }
}
