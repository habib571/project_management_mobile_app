import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project_management_app/application/constants/constants.dart';
import 'package:project_management_app/domain/models/Task/task.dart';
import 'package:project_management_app/presentation/modules/tasks/view/widget/task_status_card.dart';
import 'package:project_management_app/presentation/sharedwidgets/custom_appbar.dart';
import 'package:project_management_app/presentation/sharedwidgets/image_widget.dart';
import 'package:project_management_app/presentation/utils/colors.dart';
import 'package:project_management_app/presentation/utils/styles.dart';

import '../widget/task priority/task_priority_card.dart';

class TaskDetailScreen extends StatefulWidget {
   const TaskDetailScreen({super.key,});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  //late final TaskDetailsViewModel _viewModel ; //= instance.get<TaskDetailsViewModel>();
  final TaskModel _task = Get.arguments ;


  @override
  void initState() {
    //_viewModel = context.read<TaskDetailsViewModel>();
     //_viewModel.start()  ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _showBody()
    );
        /*StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data
              ?.getScreenWidget(context, _showBody(), () {}) ??
              _showBody();
        },
      )) ;*/

  }

  Widget _showBody() {
    return Column(
      children: [
        const SizedBox(height: 25,) ,
        const CustomAppBar(title: "Task Details"),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_task.name!, style: robotoBold.copyWith(fontSize: 16)),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _showDeadline(),
                  const SizedBox(
                    height: 20,
                  ),
                  _showTaskCreator(),
                  const SizedBox(
                    height: 20,
                  ),
                  _showAssignedTo() ,
                  const SizedBox(
                    height: 20,
                  ),
                  _showStatus(),
                  const SizedBox(
                    height: 20,
                  ),
                  _showPriority(),
                  const SizedBox(height: 35,) ,
                  Text("Description", style: robotoBold.copyWith(fontSize: 16)),
                  const SizedBox(height:15 ) ,
                  Text(
                      _task.description! ,
                     style: robotoMedium.copyWith(color: AppColors.secondaryTxt),
                     )
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _showDeadline() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            "Deadline",
            style: robotoRegular.copyWith(fontSize: 14 ,color: AppColors.secondaryTxt),
          ),
        ),
        Expanded(
          flex: 4,
          child: Row(
            children: [
              Image.asset("assets/calendar.png"),
              Text(
                _task.deadline!,
                style: robotoBold.copyWith(fontSize: 15 ,color:AppColors.secondaryTxt),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _showTaskCreator() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            "Created by",
            style: robotoRegular.copyWith(fontSize: 14 ,color: AppColors.secondaryTxt),
          ),
        ),
         Expanded(
          flex: 4,
          child: Row(
            children: [
              ImagePlaceHolder(
                  radius: 10,
                  imageUrl: Constants.userProfileImageUrl,
                  fullName: _task.project!.createdBy!.fullName,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(_task.project!.createdBy!.fullName,style:  robotoBold.copyWith(fontSize: 15 ,color:AppColors.secondaryTxt),)
            ],
          ),
        ),
      ],
    );
  }

  Widget _showAssignedTo() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            "Assigned To",
            style: robotoRegular.copyWith(fontSize: 14 ,color: AppColors.secondaryTxt),
          ),
        ),
        Expanded(
          flex: 4,
          child: Row(
            children: [
              ImagePlaceHolder(
                  radius: 10,
                  imageUrl: Constants.userProfileImageUrl,
                  fullName: _task.assignedUser!.fullName,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(_task.assignedUser!.fullName,style:  robotoBold.copyWith(fontSize: 15 ,color:AppColors.secondaryTxt),)
            ],
          ),
        ),
      ],
    );

  }

  Widget _showStatus() {
    return Row(
      children: [
        Text(
          "Status",
          style: robotoRegular.copyWith(fontSize: 14 ,color: AppColors.secondaryTxt),
        ),
        const SizedBox(width:30,) ,
        TaskStatusCard(taskStatusModel: TaskStatusModel.type(_task.status!  ,), isAssignedToMe: false, ),
      ],
    );
  }

  Widget _showPriority() {
    return Row(
      children: [
        Text(
          "Priority",
          style: robotoRegular.copyWith(fontSize: 14 ,color: AppColors.secondaryTxt),
        ),
        const SizedBox(width:27,) ,
        TaskPriorityCard(taskPriorityModel: TaskPriorityModel.type(_task.status ?? "To Do"))
      ],
    );
  }
}
