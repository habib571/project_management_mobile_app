import 'package:flutter/material.dart';
import 'package:project_management_app/application/constants/constants.dart';
import 'package:project_management_app/presentation/modules/tasks/view/widget/task_priority_card.dart';
import 'package:project_management_app/presentation/modules/tasks/view/widget/task_status_card.dart';
import 'package:project_management_app/presentation/sharedwidgets/custom_appbar.dart';
import 'package:project_management_app/presentation/sharedwidgets/image_widget.dart';
import 'package:project_management_app/presentation/utils/colors.dart';
import 'package:project_management_app/presentation/utils/styles.dart';

class TaskDetailScreen extends StatelessWidget {
  const TaskDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _showBody(),
    );
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
              Text("Task name", style: robotoBold.copyWith(fontSize: 16)),
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
                  SizedBox(height: 35,) ,
                  Text("Description", style: robotoBold.copyWith(fontSize: 16)),
                  SizedBox(height:15 ) ,
                  Text(
                      "bla bla bla bla bla bla bla bla bla bla bla bla"
                          " bla bla bla,bla bla bla bla bla bla bla bla bla "
                          "bla bla bla bla bla bla,bla bla bla,bla bla blabla bla bla" ,
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
                "02/05/2015",
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
              const ImagePlaceHolder(
                  radius: 10, imageUrl: Constants.userProfileImageUrl),
              const SizedBox(
                width: 5,
              ),
              Text("Habib rouatbi",style:  robotoBold.copyWith(fontSize: 15 ,color:AppColors.secondaryTxt),)
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
              const ImagePlaceHolder(
                  radius: 10, imageUrl: Constants.userProfileImageUrl),
              const SizedBox(
                width: 5,
              ),
              Text("Habib rouatbi",style:  robotoBold.copyWith(fontSize: 15 ,color:AppColors.secondaryTxt),)
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
        TaskStatusCard(taskStatusModel: TaskStatusModel.type("To-do")),
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
        TaskPriorityCard(taskPriorityModel: TaskPriorityModel.type("High"))
      ],
    );
  }
}
