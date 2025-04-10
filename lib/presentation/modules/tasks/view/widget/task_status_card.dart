

import 'package:flutter/material.dart';
import 'package:project_management_app/domain/models/Task/task.dart';
import 'package:project_management_app/presentation/modules/tasks/view/widget/task%20status/task_status_chip.dart';
import 'package:project_management_app/presentation/modules/tasks/viewmodel/manage_task_view_model.dart';
import 'package:provider/provider.dart';


class TaskStatusCard extends StatefulWidget {
    TaskStatusCard({
    super.key,
    required this.taskStatusModel, this.task,  this.isAssignedToMe = false,
  });

  TaskStatusModel taskStatusModel;
  final TaskModel? task ;
  bool isAssignedToMe  ;


  @override
  _TaskStatusCardState createState() => _TaskStatusCardState();
}

class _TaskStatusCardState extends State<TaskStatusCard> {

  late ManageTaskViewModel _manageTaskViewModel;

  @override
  void initState() {
    super.initState();
    _manageTaskViewModel = context.read<ManageTaskViewModel>();
  }


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.isAssignedToMe  ? () => _showDropdownMenu(context) : null,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: widget.taskStatusModel.backgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.taskStatusModel.statusName,
              style: TextStyle(
                color: widget.taskStatusModel.textColor,
                fontSize: 12,
              ),
            ),
            widget.isAssignedToMe ? const Icon(Icons.arrow_drop_down, color: Colors.black) : const SizedBox(width: 5),
          ],
        ),
      ),
    );
  }

  void _showDropdownMenu(BuildContext context) async {
    //if (!widget.isAssignedToMe!) return;

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
      _manageTaskViewModel.selectedStatusIndex = statusChipTexts.indexOf(newStatus);

      if(_manageTaskViewModel.projectTaskViewModel.selectedTask != null){
        _manageTaskViewModel.projectTaskViewModel.selectedTask!.status = newStatus ;
      }
      else {
        _manageTaskViewModel.projectTaskViewModel.selectedTask = _manageTaskViewModel.projectTaskViewModel.tasks.firstWhere((e) => e.id == widget.task!.id) ;
      }

      _manageTaskViewModel.updateTask();

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


List<Color> statusTextColors = const [Color(0xff0087ff),Color(0xffff7d53) ,Color(0xff5f33e1)] ;
List<Color> statusBackgroundColor = const [Color(0xffe3f2ff) ,Color(0xffffe9e1) ,Color(0xffede8ff)] ;
List<String> statusTypes =["To-Do" ,"In progress" ,"Done"] ;


