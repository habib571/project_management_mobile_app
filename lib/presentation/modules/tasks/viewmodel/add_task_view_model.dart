import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project_management_app/domain/models/project_member.dart';
import 'package:project_management_app/presentation/base/base_view_model.dart';
import 'package:project_management_app/presentation/modules/dashboord/viewmodel/project_detail_view_model.dart';

class AddTaskViewModel extends BaseViewModel{
  final ProjectDetailViewModel _projectDetailViewModel ;
  ProjectDetailViewModel get projectViewModel => _projectDetailViewModel ;

  AddTaskViewModel(super.tokenManager, this._projectDetailViewModel);

  ProjectMember? _projectMember ;
  ProjectMember get projectMember => _projectMember! ;
  void setProjectMember(ProjectMember projectMember) {
     _projectMember = projectMember ;
      log(projectMember.user!.fullName) ;
      notifyListeners() ;
  }
  bool _isUserAdded =false;
  bool get isUserAdded => _isUserAdded ;

  void toggleIsUserAdded() {
    _isUserAdded = !_isUserAdded;
    notifyListeners();
  }
  int _selectedIndex = -1;
  int get selectedIndex => _selectedIndex;
  void selectChip(int index) {
    if (_selectedIndex == index) {
      _selectedIndex = -1;
    } else {
      _selectedIndex = index;
    }
    notifyListeners();
  }
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController taskName = TextEditingController();
  TextEditingController taskDescription = TextEditingController();
  TextEditingController taskDeadline = TextEditingController();

  String? selectedDate;

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