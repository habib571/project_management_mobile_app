import 'package:flutter/material.dart';
import 'package:project_management_app/presentation/modules/tasks/view/widget/task_priority_chip.dart';

import '../../../../utils/styles.dart';

class TaskPriorityCard extends StatelessWidget {
  const TaskPriorityCard({super.key, required this.taskPriorityModel});
 final TaskPriorityModel taskPriorityModel ;
  @override
  Widget build(BuildContext context) {
    return  Card(
      color: taskPriorityModel.backgroundColor ,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9 ,vertical: 5),
        child: Row(
          children: [
            Icon(Icons.outlined_flag_rounded ,color:taskPriorityModel.textColor ,size: 15,) ,
            Text(
              taskPriorityModel.text ,
              style: robotoMedium.copyWith(color: taskPriorityModel.textColor ,fontSize: 12) ,
            ),
          ],
        ),
      ),
    ) ;
  }
}
 class TaskPriorityModel {
  String text ;
  Color backgroundColor ;
  Color textColor ;
  TaskPriorityModel(this.text, this.backgroundColor, this.textColor);
  factory TaskPriorityModel.type(String priority) {
      switch(priority) {
        case "Low" :
           return TaskPriorityModel(chipTexts[0], chipColors[0], textColors[0]) ;
        case "Medium" :
             return TaskPriorityModel(chipTexts[1], chipColors[1], textColors[1]) ;
        case "High" :
          return TaskPriorityModel(chipTexts[2], chipColors[2], textColors[2]) ;
        default :
          return TaskPriorityModel(chipTexts[3], chipColors[3], textColors[3]) ;


      }
  }

 }

