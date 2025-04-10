import 'package:flutter/material.dart';
import 'package:project_management_app/presentation/modules/tasks/view/widget/task%20priority/task_priority_chip.dart';
import 'package:provider/provider.dart';

import '../../../../../../domain/models/Task/task.dart';
import '../../../../../utils/styles.dart';
import '../../../viewmodel/manage_task_view_model.dart';

class TaskPriorityCard extends StatefulWidget {
   TaskPriorityCard({super.key, required this.taskPriorityModel, this.task ,this.isAssignedToMe = false});

 final TaskPriorityModel taskPriorityModel ;
 final TaskModel? task ;
 bool isAssignedToMe  ;

  @override
  State<TaskPriorityCard> createState() => _TaskPriorityCardState();
}

class _TaskPriorityCardState extends State<TaskPriorityCard> {

  late ManageTaskViewModel _manageTaskViewModel;

  @override
  void initState() {
    super.initState();
    _manageTaskViewModel = context.read<ManageTaskViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: widget.isAssignedToMe  ? () => _showDropdownMenu(context) : null,
      child: Container(
        decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(20) ,
          color: widget.taskPriorityModel.backgroundColor ,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9 ,vertical: 5),
          child: Row(
            children: [
              Icon(Icons.outlined_flag_rounded ,color:widget.taskPriorityModel.textColor ,size: 15,) ,
              Text(
                widget.taskPriorityModel.text ,
                style: robotoMedium.copyWith(color: widget.taskPriorityModel.textColor ,fontSize: 12) ,
              ),
              widget.isAssignedToMe ? const Icon(Icons.arrow_drop_down, color: Colors.black) : const SizedBox(width: 5),
            ],
          ),
        ),
      ),
    ) ;
  }

  void _showDropdownMenu(BuildContext context) async {
    //if (!widget.isAssignedToMe!) return;

    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    final newPriority = await showMenu<String>(
      color: Colors.white,
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx, offset.dy + renderBox.size.height,
        offset.dx + renderBox.size.width, offset.dy + renderBox.size.height + 100,
      ),
      items: List.generate(priorityChipTexts.length, (i) {
        return PopupMenuItem(
          value: priorityChipTexts[i],
          child: Row(
            children: [
              Icon(Icons.circle, color: priorityTextColors[i], size: 12),
              const SizedBox(width: 8),
              Text(priorityChipTexts[i], style: TextStyle(color: priorityTextColors[i])),
            ],
          ),
        );
      }),
    );

    if (newPriority != null) {
      _manageTaskViewModel.selectedPriorityIndex = priorityChipTexts.indexOf(newPriority);

      if(_manageTaskViewModel.projectTaskViewModel.selectedTask != null){
        _manageTaskViewModel.projectTaskViewModel.selectedTask!.priority = newPriority ;
      }
      else {
        _manageTaskViewModel.projectTaskViewModel.selectedTask = _manageTaskViewModel.projectTaskViewModel.tasks.firstWhere((e) => e.id ==  widget.task!.id) ;

      }

      _manageTaskViewModel.updateTask();

    }

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
           return TaskPriorityModel(priorityChipTexts[0], priorityChipColors[0], priorityTextColors[0]) ;
        case "Medium" :
             return TaskPriorityModel(priorityChipTexts[1], priorityChipColors[1], priorityTextColors[1]) ;
        case "High" :
          return TaskPriorityModel(priorityChipTexts[2], priorityChipColors[2], priorityTextColors[2]) ;
        default :
          return TaskPriorityModel(priorityChipTexts[3], priorityChipColors[3], priorityTextColors[3]) ;


      }
  }

 }

