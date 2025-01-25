import 'package:flutter/material.dart';
import 'package:project_management_app/domain/models/task.dart';
import 'package:project_management_app/domain/models/user.dart';
import 'package:project_management_app/presentation/base/base_view_model.dart';

import '../../../../domain/models/project_member.dart';
import '../../../utils/colors.dart';
import '../view/widgets/custom_chips/assigned_memberchip.dart';

class ReportIssueViewModel extends BaseViewModel{
  ReportIssueViewModel(super.tokenManager);

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController issueTitle = TextEditingController();
  TextEditingController issueDescription = TextEditingController();

  GlobalKey<FormState> get formkey => _formkey;

  User? _taggedMember ;
  User? get taggedMember => _taggedMember ;

  bool _isUserAdded = false;
  bool get isUserAdded => _isUserAdded ;

  bool _isTaskAdded = false;
  bool get isTaskAdded => _isTaskAdded ;

  TaskModel? _taggedTask ;
  TaskModel? get taggedTask => _taggedTask ;

  void toggleIsUserAdded() {
    _isUserAdded = !_isUserAdded;
    notifyListeners();
  }

  void updatetaggedMember(User member) {
    _taggedMember = member;
    toggleIsUserAdded();
    notifyListeners();
  }

  void toggleIsTaskAdded() {
    _isTaskAdded = !_isTaskAdded;
    notifyListeners();
  }

  void updatetaggedTask(TaskModel task) {
    _taggedTask = task;
    toggleIsTaskAdded();
    notifyListeners();
  }


}