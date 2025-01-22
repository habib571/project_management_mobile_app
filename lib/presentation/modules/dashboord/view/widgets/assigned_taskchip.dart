import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/styles.dart';

class AssignedTaskChip extends StatelessWidget {
  const AssignedTaskChip({super.key, required this.taskName, required this.onDeleted});
  final String taskName ;
  final Function onDeleted ;
  @override
  Widget build(BuildContext context) {
    return InputChip(
      label: Text(
        taskName ,
        style: robotoBold.copyWith(fontSize: 12),
      ),
      backgroundColor:  AppColors.orangeAccent,
      avatar: const Icon(Icons.task_outlined) ,
      shape:RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18), // Adjust border radius here
      ),
      onDeleted: () => onDeleted(),
    ) ;
  }
}