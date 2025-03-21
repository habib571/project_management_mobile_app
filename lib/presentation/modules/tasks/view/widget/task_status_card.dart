

import 'package:flutter/material.dart';
import 'package:project_management_app/presentation/modules/tasks/view/widget/task%20status/task_status_chip.dart';
import 'package:project_management_app/presentation/utils/colors.dart';
import 'package:project_management_app/presentation/utils/styles.dart';



/*
class TaskStatusCard extends StatelessWidget {
  const TaskStatusCard({super.key, required this.taskStatusModel});
final TaskStatusModel taskStatusModel ;
  @override
  Widget build(BuildContext context) {
     return Container(
       decoration: BoxDecoration(
           color: taskStatusModel.backgroundColor ,
          borderRadius: BorderRadius.circular(20)
       ),
       child: Padding(
           padding: const EdgeInsets.symmetric(horizontal: 9 ,vertical: 5),
          child: Text(
             taskStatusModel.statusName ,
             style: robotoMedium.copyWith(color: taskStatusModel.textColor ,fontSize: 12) ,
          ),
       ),
     ) ;
  }
}*/

//***************************




class TaskStatusCard extends StatefulWidget {
  const TaskStatusCard({
    super.key,
    required this.taskStatusModel,
    this.isAssignedToMe,
  });

  final TaskStatusModel taskStatusModel;
  final bool? isAssignedToMe;

  @override
  _TaskStatusCardState createState() => _TaskStatusCardState();
}

class _TaskStatusCardState extends State<TaskStatusCard> {
  late TaskStatusModel selectedStatus;

  @override
  void initState() {
    super.initState();
    selectedStatus = widget.taskStatusModel;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.isAssignedToMe! ? () => _showDropdownMenu(context) : null,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: selectedStatus.backgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.isAssignedToMe!)
              const Icon(Icons.arrow_drop_down, color: Colors.black),
            if (widget.isAssignedToMe!) const SizedBox(width: 5),
            Text(
              selectedStatus.statusName,
              style: TextStyle(
                color: selectedStatus.textColor,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDropdownMenu(BuildContext context) async {
    //if (!widget.isAssignedToMe!) return; // Empêche l'ouverture si false

    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    final newStatus = await showMenu<String>(
      color: Colors.white,
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx, offset.dy + renderBox.size.height,
        offset.dx + renderBox.size.width, offset.dy + renderBox.size.height + 100,
      ),
      items: List.generate(statusChipTexts.length, (i) {
        return PopupMenuItem(
          value: statusChipTexts[i],
          child: Row(
            children: [
              Icon(Icons.circle, color: statusTextColors[i], size: 12),
              const SizedBox(width: 8),
              Text(statusChipTexts[i], style: TextStyle(color: statusTextColors[i])),
            ],
          ),
        );
      }),
    );

    if (newStatus != null) {
      setState(() {
        int index = statusChipTexts.indexOf(newStatus);
        selectedStatus = TaskStatusModel(
          statusTextColors[index],
          statusBackgroundColor[index],
          statusChipTexts[index],
        );
      });
    }
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
        return TaskStatusModel(statusTextColors[0], statusBackgroundColor[0], statusChipTexts[0]) ;
      case "In progress" :
        return TaskStatusModel(statusTextColors[1], statusBackgroundColor[1], statusChipTexts[1]) ;
      default :
        return TaskStatusModel(statusTextColors[2], statusBackgroundColor[2], statusChipTexts[2]) ;
    }

  }
 }


