import 'package:flutter/material.dart';
import 'package:project_management_app/presentation/utils/styles.dart';

class TaskPriorityChip extends StatelessWidget {
  const TaskPriorityChip(
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
List<Color> chipColors = [
  const Color(0xffd4eacc),
  const Color(0xfff9e6d0),
  const Color(0xffffccd2),
  const Color(0xffd4d4d5)
];
List<Color> textColors = [
  const Color(0xff279600),
  const Color(0xffdf8412),
  const Color(0xffff001f),
  const Color(0xff292a2d)
];
List<String> chipTexts = ["Low", "Medium", "High", "Urgent"];

class ChipModel {
  String text;
  bool isSelected;
  Color textColor;
  Color chipColor;
  ChipModel(this.text, this.isSelected, this.textColor, this.chipColor);
}
