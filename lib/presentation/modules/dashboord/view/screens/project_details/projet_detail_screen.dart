import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:project_management_app/application/dependencyInjection/dependency_injection.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';
import 'package:project_management_app/application/navigation/routes_constants.dart';
import 'package:project_management_app/domain/models/project.dart';
import 'package:project_management_app/domain/models/project_member.dart';
import 'package:project_management_app/presentation/modules/tasks/view/screens/manage_task_screen.dart';

import 'package:project_management_app/presentation/modules/dashboord/view/screens/members_screen.dart';
import 'package:project_management_app/presentation/modules/dashboord/view/widgets/members_card.dart';
import 'package:project_management_app/presentation/modules/dashboord/view/widgets/project_detail_card.dart';
import 'package:project_management_app/presentation/modules/dashboord/viewmodel/project_details_view_models/project_detail_view_model.dart';
import 'package:project_management_app/presentation/modules/tasks/view/screens/project_tasks_screens.dart';
import 'package:project_management_app/presentation/sharedwidgets/custom_appbar.dart';
import 'package:project_management_app/presentation/sharedwidgets/custom_listtile.dart';
import 'package:project_management_app/presentation/sharedwidgets/custom_button.dart';
import 'package:project_management_app/presentation/sharedwidgets/image_widget.dart';
import 'package:project_management_app/presentation/stateRender/state_render_impl.dart';
import 'package:project_management_app/presentation/utils/colors.dart';
import 'package:project_management_app/presentation/utils/styles.dart';
import 'package:provider/provider.dart';

import '../../../../../../application/constants/constants.dart';
import '../../../../../sharedwidgets/custom_add_button.dart';
import '../../../../managemembers/view/screens/custom_search_delegate.dart';
import '../../../../meeting/view/screens/meetings_screen.dart';

class ProjectDetailScreen extends StatefulWidget {
   const ProjectDetailScreen({
    super.key,
  });

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {
  late final ProjectDetailViewModel _viewModel ;

  @override
  void initState() {
    _viewModel  = context.read<ProjectDetailViewModel>();
    _viewModel.start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
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
                    //We must select the Project not any attribute (update the name and the due date) --to modify
                    Selector<ProjectDetailViewModel,Project?>(
                      selector: (context, viewModel) => viewModel.dashBoardViewModel.project ,
                      builder:  (context, data, child){
                        return ProjectDetailCard(
                          project: _viewModel.dashBoardViewModel.project!,
                        );
                      }
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    _showProjectDescription(),
                    const SizedBox(
                      height: 30,
                    ),

                    const SizedBox(
                      height: 15,
                    ),
                    Text('Progress',
                        style: robotoSemiBold.copyWith(fontSize: 16)),
                    const SizedBox(
                      height: 15,
                    ),
                    _showProgress(),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Members',
                            style: robotoSemiBold.copyWith(fontSize: 16)),
                        GestureDetector(
                          onTap: () => Get.to(() => MembersScreen(),arguments: _viewModel),
                          child: Text(
                            'View members details ',
                            style: robotoRegular.copyWith(
                                color: Colors.lightBlue, fontSize: 13),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 25,
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
                    const SizedBox(
                      height: 20,
                    ),
                     _meetingSection() ,
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
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: AppColors.accent.withOpacity(0.5), blurRadius: 10)
          ],
          borderRadius: BorderRadius.circular(12)
      ),
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
            selector: (context, viewModel) =>viewModel.dashBoardViewModel.project!.description!,
            builder: (context, data, child){
              return Text(
                _viewModel.dashBoardViewModel.project!.description!,
                style: robotoMedium.copyWith(
                    color: AppColors.secondaryTxt, fontSize: 13),
              );
            },
          )
        ],
      ),
    );
  }

  Widget _showMembers() {
    return MembersCard(children: [
      ...List.generate(_viewModel.projectMember.length, (index) {
        log(_viewModel.projectMember.length.toString());
        return  ImagePlaceHolder(
            imgBorder: true,
            radius: 17,
            imageUrl: _viewModel.projectMember[index].user!.imageUrl,  //"${Constants.baseUrl}/images/${_viewModel.projectMember[index].user!.imageUrl}",
            fullName: _viewModel.projectMember[index].user!.fullName,
        );

      }),
      CustomAddButton(
        onTap: () {
          showSearch(
              context: context,
              delegate:CustomSearchDelegate(afterSelectingUser: (selectedUser) {
                ProjectMember newMember = ProjectMember.selectedMemberToBeAdded(selectedUser, _viewModel.dashBoardViewModel.project!.id!);
                Get.toNamed(AppRoutes.manageMemberScreen,arguments: {"member": newMember,"toEdit": false,},
                );
                }
              )
          );
        },
      ),
    ]);
  }
  Widget _showProgress() {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
        BoxShadow(color: AppColors.accent.withOpacity(0.5), blurRadius: 10)
    ],
    borderRadius: BorderRadius.circular(12)
    ) ,
      child:  CircularPercentIndicator(

         animation: true,
          radius: 40,
          lineWidth: 10.0,
          percent:_viewModel.dashBoardViewModel.project!.progress!  ,
          center: Text(
            "${(_viewModel.dashBoardViewModel.project!.progress! * 100).toStringAsFixed(0)}%" ,
            style: robotoBold.copyWith(color: AppColors.primaryTxt),
          ),
          backgroundColor: AppColors.accent,
          progressColor: AppColors.primary
      )
    );
  }

  Widget _reportIssueSection() {
    return CustomListTile(
        leading: const Icon(Icons.report_problem_outlined,
            color: AppColors.primary),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: AppColors.primary,
          size: 13,
        ),
        title:  Text(
            "View issues" ,
          style: robotoRegular.copyWith(fontSize: 16),
        ),
        onTap: () {
          Get.toNamed(AppRoutes.issuesScreen);
        });
  }
  Widget _meetingSection() {
    return CustomListTile(
        leading: const Icon(Icons.video_camera_front_outlined,
            color: AppColors.primary),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: AppColors.primary,
          size: 13,
        ),
        title:  Text(
            "meetings" ,
          style: robotoRegular.copyWith(fontSize: 16),

        ),
        onTap: () {
          Get.to(() => const MeetingsScreen()) ;
        });
  }


  Widget _tasksSection() {
    return CustomListTile(
        leading: const Icon(Icons.task_outlined, color: AppColors.primary),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: AppColors.primary,
          size: 13,
        ),
        title:  Text(
            "tasks" ,
           style: robotoRegular.copyWith(fontSize: 16),
        ),
        onTap: () {
          Get.to(()=>const ProjectTasksScreens()) ;
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
            Get.toNamed(AppRoutes.manageTaskScreen , arguments: {"toEdit": false} );
            //Get.to(() => const ManageTaskScreen());
          },
          text: 'Create new Task'),
    );
  }
}
