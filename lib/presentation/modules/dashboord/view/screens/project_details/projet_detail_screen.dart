import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_app/application/dependencyInjection/dependency_injection.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';
import 'package:project_management_app/application/navigation/routes_constants.dart';
import 'package:project_management_app/domain/models/project.dart';
import 'package:project_management_app/presentation/modules/tasks/view/screens/create_task_screen.dart';

import 'package:project_management_app/presentation/modules/dashboord/view/screens/members_screen.dart';
import 'package:project_management_app/presentation/modules/dashboord/view/widgets/members_card.dart';
import 'package:project_management_app/presentation/modules/dashboord/view/widgets/project_detail_card.dart';
import 'package:project_management_app/presentation/modules/dashboord/viewmodel/project_details_view_models/project_detail_view_model.dart';
import 'package:project_management_app/presentation/modules/tasks/view/screens/project_tasks_screens.dart';
import 'package:project_management_app/presentation/modules/tasks/view/screens/task_detail_screen.dart';
import 'package:project_management_app/presentation/sharedwidgets/custom_appbar.dart';
import 'package:project_management_app/presentation/sharedwidgets/custom_listtile.dart';
import 'package:project_management_app/presentation/sharedwidgets/custom_button.dart';

import 'package:project_management_app/presentation/sharedwidgets/image_widget.dart';
import 'package:project_management_app/presentation/stateRender/state_render_impl.dart';
import 'package:project_management_app/presentation/utils/colors.dart';
import 'package:project_management_app/presentation/utils/styles.dart';
import 'package:provider/provider.dart';

import '../../../../../sharedwidgets/custom_add_button.dart';
import '../../../../../sharedwidgets/custom_button.dart';
import '../../../../addmember/view/screens/custom_search_delegate.dart';

class ProjectDetailScreen extends StatefulWidget {
  const ProjectDetailScreen({
    super.key,
  });

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {
  final ProjectDetailViewModel _viewModel = instance<ProjectDetailViewModel>();

  @override
  void initState() {
    _viewModel.start();
    super.initState();
  }

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
                      height: 20.h,
                    ),
                    Selector<ProjectDetailViewModel,Project>(
                      selector: (context, ProjectDetailViewModel) => ProjectDetailViewModel.dashBoardViewModel.project ,
                      builder:  (context, data, child){
                        print("**** REBUILD *****");
                        return ProjectDetailCard(
                          project: _viewModel.dashBoardViewModel.project,
                        );
                      }
                    ),
                    /*Consumer<ProjectDetailViewModel>(
                      builder: (context, ProjectDetailViewModel, child){
                        print("**** REBUILD *****");
                        return ProjectDetailCard(
                          project: _viewModel.dashBoardViewModel.project,
                        );
                      } ,
                    ),*/
                    const SizedBox(
                      height: 30,
                    ),
                    _showProjectDescription(),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Members',
                            style: robotoSemiBold.copyWith(fontSize: 16)),
                        GestureDetector(
                          onTap: () => Get.to(() => MembersScreen(),
                              arguments: _viewModel),
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
                    StreamBuilder<FlowState>(
                        stream: _viewModel.outputState,
                        builder: (context, snapshot) {
                          return snapshot.data?.getScreenWidget(
                                  context, _showMembers(), () {}) ??
                              _showMembers();
                        }),
                    const SizedBox(
                      height: 25,
                    ),
                    _reportIssueSection(),
                    const SizedBox(
                      height: 20,
                    ),
                    _tasksSection(),
                     SizedBox(
                      height: 40.h,
                    ),
                    _viewModel.isManger()
                        ? _showCreateTaskButton()
                        : const SizedBox.shrink(),
                    const SizedBox(
                      height: 20,
                    ),
                    _addIssueButton() ,
                    const SizedBox(
                      height: 20,
                    ),
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
          Selector<ProjectDetailViewModel,String>(
            selector: (context, ProjectDetailViewModel) => ProjectDetailViewModel.dashBoardViewModel.project.description!,
            builder: (context, data, child){
              print("----rebuild description----");
              return Text(
                _viewModel.dashBoardViewModel.project.description!,
                style: robotoMedium.copyWith(
                    color: AppColors.secondaryTxt, fontSize: 13),
              );
            },
            /*child: Text(
              _viewModel.dashBoardViewModel.project.description!,
              style: robotoMedium.copyWith(
                  color: AppColors.secondaryTxt, fontSize: 13),
            ),*/
          )
        ],
      ),
    );
  }

  Widget _showMembers() {
    return MembersCard(children: [
      ...List.generate(_viewModel.projectMember.length, (index) {
        log(_viewModel.projectMember.length.toString());
        return const ImagePlaceHolder(
            imgBorder: true,
            radius: 17,
            imageUrl:
                'https://images.unsplash.com/photo-1567784177951-6fa58317e16b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80');
      }),
      CustomAddButton(
        onTap: () {
          showSearch(
              context: context,
              delegate:
                  CustomSearchDelegate(afterSelectingUser: (selectedMember) {
                Get.toNamed(AppRoutes.addMemberScreen,
                    arguments: selectedMember);
              }));
        },
      ),
    ]);
  }

  Widget _reportIssueSection() {
    return CustomListTile(
        leading: const Icon(Icons.report_problem_outlined,
            color: AppColors.primary),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: AppColors.accent,
          size: 13,
        ),
        title: const Text("View issues"),
        onTap: () {
          Get.toNamed(AppRoutes.issuesScreen);
        });
  }

  Widget _tasksSection() {
    return CustomListTile(
        leading: const Icon(Icons.task_outlined, color: AppColors.primary),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: AppColors.accent,
          size: 13,
        ),
        title: const Text("View tasks"),
        onTap: () {
          Get.to(()=>ProjectTasksScreens()) ;
        });
  }

  Widget _addIssueButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: CustomButton(
          widget: const Icon(
            Icons.report_gmailerrorred,
            color: Colors.white,
          ),
          buttonColor: Colors.red.shade300,
          onPressed: () {
            Get.toNamed(AppRoutes.reportIssueScreen);
          },
          text: 'Report an Issue'),
    );
  }

  Widget _showCreateTaskButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: CustomButton(
          onPressed: () {
            Get.to(() => const CreateTaskScreen());
            //Get.to(()=> TaskDetailScreen()) ;
          },
          text: 'Create new Task'),
    );
  }
}
