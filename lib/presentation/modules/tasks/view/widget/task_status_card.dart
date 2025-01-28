

import 'package:flutter/material.dart';
import 'package:project_management_app/presentation/utils/styles.dart';

class TaskStatusCard extends StatelessWidget {
  const TaskStatusCard({super.key, required this.taskStatusModel});
final TaskStatusModel taskStatusModel ;
  @override
  Widget build(BuildContext context) {
     return Card(
       color: taskStatusModel.backgroundColor ,
       child: Padding(
           padding: const EdgeInsets.symmetric(horizontal: 12 ,vertical: 7),
          child: Text(
             taskStatusModel.statusName ,
             style: robotoMedium.copyWith(color: taskStatusModel.textColor) ,
          ),
       ),
     ) ;
  }
}
 class TaskStatusModel {
  final Color textColor ;
  final Color backgroundColor ;
  final String statusName ;
  TaskStatusModel(this.textColor, this.backgroundColor, this.statusName);
  factory TaskStatusModel.type( String statusName) {
    switch(statusName) {
      case "To-Do" :
        return TaskStatusModel(statusTextColors[0], statusBackgroundColor[0], statusTypes[0]) ;
      case "In progress" :
        return TaskStatusModel(statusTextColors[1], statusBackgroundColor[1], statusTypes[1]) ;
      default :
        return TaskStatusModel(statusTextColors[2], statusBackgroundColor[2], statusTypes[2]) ;
    }

  }
 }

List<Color> statusTextColors = const [Color(0xff0087ff),Color(0xffff7d53) ,Color(0xff5f33e1)] ;
List<Color> statusBackgroundColor = const [Color(0xffe3f2ff) ,Color(0xffffe9e1) ,Color(0xffede8ff)] ;
List<String> statusTypes =["To-do" ,"In progress" ,"Done"] ;


