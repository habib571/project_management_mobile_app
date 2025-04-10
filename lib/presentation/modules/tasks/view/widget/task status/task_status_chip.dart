
import 'dart:ui';

import 'package:flutter/material.dart';
import '../../../../../../domain/models/Task/task_chip.dart';
import '../../../../../utils/styles.dart';

class TaskStatusChip extends StatelessWidget {
  const TaskStatusChip(
      {super.key, required this.chipModel, required this.onSelect});
  final ChipModel chipModel;
  final Function(bool val) onSelect;
  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18), // Adjust border radius here
      ),
      showCheckmark: true,
      side: chipModel.isSelected
          ? BorderSide(color: chipModel.textColor)
          : BorderSide.none,
      onSelected: (val) {
        onSelect(val); // Notify parent widget of selection
      },
      backgroundColor: chipModel.chipColor,
      label: Text(
        chipModel.text,
        style: robotoRegular.copyWith(
          color: chipModel.textColor,
          fontSize: 14,
        ),
      ),
      selected: chipModel.isSelected,
      selectedColor: chipModel.chipColor,
    );
  }
}


List<Color> statusTextColors = const [Color(0xff0087ff),Color(0xffff7d53) ,Color(0xff5f33e1)] ;
List<Color> statusBackgroundColor = const [Color(0xffe3f2ff) ,Color(0xffffe9e1) ,Color(0xffede8ff)] ;
List<String> statusChipTexts =["To-Do" ,"In progress" ,"Done"] ;

