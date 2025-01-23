import 'package:flutter/material.dart';
import 'package:project_management_app/presentation/base/base_view_model.dart';

import '../../../utils/colors.dart';
import '../view/widgets/assigned_memberchip.dart';

class ReportIssueViewModel extends BaseViewModel{
  ReportIssueViewModel(super.tokenManager);

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController issueTitle = TextEditingController();
  TextEditingController issueDescription = TextEditingController();


  GlobalKey<FormState> get formkey => _formkey;

}