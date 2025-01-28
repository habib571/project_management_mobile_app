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
import 'package:project_management_app/presentation/modules/dashboord/viewmodel/project_detail_view_model.dart';
import 'package:project_management_app/presentation/modules/tasks/view/screens/task_detail_screen.dart';
import 'package:project_management_app/presentation/sharedwidgets/custom_appbar.dart';
import 'package:project_management_app/presentation/sharedwidgets/custom_listtile.dart';
import 'package:project_management_app/presentation/sharedwidgets/custom_button.dart';

import 'package:project_management_app/presentation/sharedwidgets/image_widget.dart';
import 'package:project_management_app/presentation/stateRender/state_render_impl.dart';
import 'package:project_management_app/presentation/utils/colors.dart';
import 'package:project_management_app/presentation/utils/styles.dart';

import '../../../../sharedwidgets/custom_add_button.dart';
import '../../../../sharedwidgets/custom_button.dart';
import '../../../searchmember/view/custom_search_delegate.dart';

class ProjectDetailScreen extends StatefulWidget {
  const ProjectDetailScreen({super.key, });

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}
class _ProjectDetailScreenState extends State<ProjectDetailScreen> {

  final ProjectDetailViewModel _viewModel = instance<ProjectDetailViewModel>();

  @override
  void initState() {
     _viewModel.start() ;
    super.initState();
  }

  final ProjectDetailViewModel _viewModel = instance.get<ProjectDetailViewModel>();


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

                      project: _viewModel.dashBoardViewModel.project,

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

                          onTap: () => Get.to(() =>  MembersScreen() ,arguments: _viewModel),

                          child: Text(
                            'View members details ',
                            style: robotoRegular.copyWith(
                                color: Colors.lightBlue, fontSize: 13),
                          ),
                        )
                      ],
                    ),
                     SizedBox(
                      height: 15.h,
                    ),

                    StreamBuilder<FlowState>(
                        stream: _viewModel.outputState,
                        builder: (context, snapshot) {
                          return snapshot.data?.getScreenWidget(
                                  context, _showMembers(), () {}) ??
                              _showMembers();

                        }),
                    SizedBox(
                      height: 25.h,
                    ),
                    _reportIssueSection(),
                    SizedBox(
                      height: 20.h,
                    ),
                    _tasksSection(),
                    SizedBox(
                      height: 25.h,
                    ),
                    _addIssueButton()


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

            _viewModel.dashBoardViewModel.project.description!,

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
        log(_viewModel.projectMember.length.toString());
        return const ImagePlaceHolder(
            imgBorder: true,
            radius: 17,
            imageUrl:'https://images.unsplash.com/photo-1567784177951-6fa58317e16b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80');
      }),

      CustomAddButton(onTap: () {
        showSearch(context: context ,delegate: CustomSearchDelegate(
            afterSelectingUser: (selectedMember){
              Get.toNamed(AppRoutes.addMemberScreen,arguments: selectedMember);
            }
        ));
        },
      ),
    ]);
  }


  Widget _reportIssueSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Report Issue', style: robotoSemiBold.copyWith(fontSize: 16)),
         SizedBox(
          height: 15.h,
        ),
        CustomListTile(
            leading: const Icon(Icons.report_problem_outlined,color: AppColors.primary),
            trailing: const Icon(Icons.arrow_forward_ios,color: AppColors.accent,size: 13,),
            title: const Text("View issues"),
            onTap: () {
              Get.toNamed(AppRoutes.issuesScreen);
            })
      ],
    );
  }
  Widget _tasksSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Tasks', style: robotoSemiBold.copyWith(fontSize: 16)),
         SizedBox(
          height: 15.h,
        ),
        CustomListTile(
            leading: const Icon(Icons.task_outlined,color: AppColors.primary),
            trailing: const Icon(Icons.arrow_forward_ios,color: AppColors.accent,size: 13,),
            title: const Text("View tasks"),
            onTap: () {})
      ],
    );
  }

  Widget _addIssueButton() {
    return CustomButton(
        buttonColor: AppColors.accent,
        onPressed: () {
          Get.toNamed(AppRoutes.reportIssueScreen);
        },
        text: 'Report an Issue');
  }


 Widget _showCreateTaskButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20) ,
      child: CustomButton(
          onPressed: () {
            Get.to(()=> CreateTaskScreen()) ;
            //Get.to(()=> TaskDetailScreen()) ;
          },
          text: 'Create new Task'
      ),
    ) ;

  }



}
