import 'package:flutter/material.dart';
import 'package:project_management_app/presentation/modules/tasks/view/widget/task_priority_card.dart';
import 'package:project_management_app/presentation/modules/tasks/view/widget/task_status_card.dart';
import 'package:project_management_app/presentation/utils/styles.dart';

import '../../../../../application/constants/constants.dart';
import '../../../../../application/helpers/get_storage.dart';
import '../../../../../domain/models/task.dart';
import '../../../../sharedwidgets/image_widget.dart';
import '../../../../utils/colors.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({super.key, required this.task, required this.isAssignedToMe, });

  final TaskModel task ;
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
               Text(
                 widget.task.name! ,
                 style: robotoBold.copyWith(fontSize: 14, color: AppColors.secondaryTxt),
               ) ,
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
                   Text(widget.task.assignedUser!.fullName,style:  robotoBold.copyWith(fontSize: 15 ,color:AppColors.secondaryTxt),)
                 ],
               ),
               IconButton(
                onPressed:(){} ,
                icon: const Icon(Icons.edit_outlined),
               ) ,
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
                       Text(
                        widget.task.deadline?? "02/05/2025",
                         style: robotoBold.copyWith(fontSize: 15 ,color:AppColors.secondaryTxt),
                       )
                     ],
                   ),
                   InkWell(
                       child: TaskStatusCard(taskStatusModel: TaskStatusModel.type(widget.task.status!), isAssignedToMe: widget.isAssignedToMe,),
                        onTap: (){},
                   )
                 ],
               ) ,

             ],
           ) ,


    ) ;
  }
}


