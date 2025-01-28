import 'package:flutter/material.dart';
import 'package:project_management_app/presentation/modules/tasks/view/widget/task_priority_card.dart';
import 'package:project_management_app/presentation/modules/tasks/view/widget/task_status_card.dart';
import 'package:project_management_app/presentation/utils/styles.dart';

import '../../../../../application/constants/constants.dart';
import '../../../../../domain/models/task.dart';
import '../../../../sharedwidgets/image_widget.dart';
import '../../../../utils/colors.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({super.key, required this.task});
  final TaskModel task ;
  @override
  Widget build(BuildContext context) {
    return Container(
         padding: const EdgeInsets.all(15),
         height: 180,
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
                 task.name! ,
                 style: robotoBold.copyWith(fontSize: 14),
               ) , 
               TaskPriorityCard(taskPriorityModel: TaskPriorityModel.type(task.priority!)),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Row(
                     children: [
                       Image.asset("assets/calendar.png"),
                       const SizedBox(width: 5,),
                       Text(
                        task.deadline!,
                         style: robotoBold.copyWith(fontSize: 15 ,color:AppColors.secondaryTxt),
                       )
                     ],
                   ),
                   TaskStatusCard(taskStatusModel: TaskStatusModel.type(task.status!))
                 ],
               ) ,
               Row(
                 children: [
                   const ImagePlaceHolder(
                           radius: 10, imageUrl: Constants.userProfileImageUrl),
                       const SizedBox(
                         width: 5,
                       ),
                       Text(task.assignedUser!.fullName,style:  robotoBold.copyWith(fontSize: 15 ,color:AppColors.secondaryTxt),)
                 ],
               )

             ],
           ) ,

         ]
       ) ,
    ) ;
  }
}
