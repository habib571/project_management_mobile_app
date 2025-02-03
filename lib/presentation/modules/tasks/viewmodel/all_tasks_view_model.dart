import 'package:flutter/material.dart';
import 'package:project_management_app/presentation/base/base_view_model.dart';

class AllTasksViewModel extends BaseViewModel {
  AllTasksViewModel(super.tokenManager);

  int _selectedStatusIndex = -1;
  int get selectedStatusIndex => _selectedStatusIndex;

  int _selectedPriorityIndex = -1;
  int get selectedPriorityIndex => _selectedPriorityIndex;

  TextEditingController taskDeadline = TextEditingController();
  String? selectedDate;
  bool _isChecked = false ;
  bool get isChecked => _isChecked ;

  void setChecked(bool value) {
    _isChecked = value ;
    notifyListeners() ;
  }
  void selectStatus(int index) {
    if (_selectedStatusIndex == index) {
      _selectedStatusIndex = -1;
    } else {
      _selectedStatusIndex = index;
    }
    notifyListeners();
  }


 void selectPriority(int index) {
   if (_selectedPriorityIndex == index) {
     _selectedPriorityIndex = -1;
   } else {
     _selectedPriorityIndex = index;
   }
   notifyListeners();

 }

  pickProjectEndDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      selectedDate = pickedDate.toString() ;
      taskDeadline.text = "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year}";
    }
  }
}