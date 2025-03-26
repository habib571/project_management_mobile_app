import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project_management_app/main.dart';
import 'package:project_management_app/presentation/modules/tasks/view/widget/task%20priority/task_priority_card.dart';
import 'package:project_management_app/presentation/modules/tasks/view/widget/task_status_card.dart';
import 'package:project_management_app/presentation/utils/styles.dart';
import 'package:provider/provider.dart';

import '../../../../../application/constants/constants.dart';
import '../../../../../application/helpers/get_storage.dart';
import '../../../../../application/navigation/routes_constants.dart';
import '../../../../../domain/models/Task/task.dart';
import '../../../../sharedwidgets/image_widget.dart';
import '../../../../utils/colors.dart';
import '../../viewmodel/prject_tasks_view_model.dart';

class TaskWidget extends StatefulWidget {
   const TaskWidget({super.key, required this.task , required this.viewModel, required this.isAssignedToMe, });

  final TaskModel task ;
  final ProjectTasksViewModel viewModel ;
  final bool isAssignedToMe ;


  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {

  String selectedStatus =  "To-do";


  @override
  Widget build(BuildContext context) {
    return Container(
         padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17) ,
          color: Colors.white
        ),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Selector<ProjectTasksViewModel, String>(
                 selector: (_, viewModel) => viewModel.tasks.firstWhere((t) => t.id == widget.task.id).name ?? '',
                 builder: (_, name, __) {
                   print("------- Title --- Card");
                   return Text(
                     name ,//widget.task.name! ,
                     style: robotoBold.copyWith(fontSize: 14, color: AppColors.secondaryTxt),
                   ) ;
                 },
               ),
               /*Text(
                 widget.task.name! ,
                 style: robotoBold.copyWith(fontSize: 14, color: AppColors.secondaryTxt),
               ) ,*/
               TaskPriorityCard(taskPriorityModel: TaskPriorityModel.type(widget.task.priority!)),
               ]),
               const SizedBox(height: 15,)  ,
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Row(
                 children: [
                   Text(
                       "Assigned to :" ,
                       style: robotoSemiBold.copyWith(color: AppColors.secondaryTxt ,fontSize: 14),
                   ),

                   const ImagePlaceHolder(
                       radius: 10, imageUrl: Constants.userProfileImageUrl),
                   const SizedBox(
                     width: 5,
                   ),
                   Selector<ProjectTasksViewModel, String>(
                     selector: (_, viewModel) => viewModel.tasks.firstWhere((t) => t.id == widget.task.id).assignedUser?.fullName ?? '',
                     builder: (_, fullName, __) {
                       print("------- Assigned --- Card");
                       return Text(
                         fullName,
                         style:  robotoBold.copyWith(fontSize: 15 ,color:AppColors.secondaryTxt),
                       ) ;
                     },
                   ),

                   /*Text(
                     widget.task.assignedUser!.fullName,
                     style:  robotoBold.copyWith(fontSize: 15 ,color:AppColors.secondaryTxt),
                   )*/
                 ],
               ),
               widget.isAssignedToMe ? IconButton(
                onPressed:(){
                  widget.viewModel.selectedTask == null ?  widget.viewModel.selectedTask = widget.task : null ;

                  print("+++ ${ widget.viewModel.selectedTask!.name} / ${ widget.viewModel.selectedTask!.status}");
                  Get.toNamed(AppRoutes.manageTaskScreen , arguments: {"toEdit": true } );
                } ,
                icon: const Icon(Icons.edit_outlined),
               )  : const SizedBox.shrink()
             ],
           ),
               const SizedBox(height: 15,) ,
               Row(
                 mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                 children: [
                   Row(
                     children: [
                       Image.asset("assets/calendar.png"),
                       const SizedBox(width: 5,),
                       Selector<ProjectTasksViewModel, String>(
                         selector: (_, viewModel) => viewModel.tasks.firstWhere((t) => t.id == widget.task.id).deadline ?? '',
                         builder: (_, deadline, __) {
                           print("------- Status --- Card");
                           return Text(
                             deadline,
                             style: robotoBold.copyWith(fontSize: 15 ,color:AppColors.secondaryTxt),
                           );
                         },
                       )
                       /*Text(
                        widget.task.deadline?? "02/05/2025",
                         style: robotoBold.copyWith(fontSize: 15 ,color:AppColors.secondaryTxt),
                       )*/
                     ],
                   ),

                  Selector<ProjectTasksViewModel, String>(
                    selector: (_, viewModel) => viewModel.tasks.firstWhere((t) => t.id == widget.task.id).status ?? '',
                    builder: (_, status, __) {
                      print("------- Status --- Card");
                      return TaskStatusCard(
                        taskStatusModel: TaskStatusModel.type(status),
                        viewModel:widget.viewModel,
                        task: widget.task,
                        isAssignedToMe: widget.isAssignedToMe,
                      );
                    },
                  )

                 ],
               ) ,

             ],
           ) ,


    ) ;
  }
}


