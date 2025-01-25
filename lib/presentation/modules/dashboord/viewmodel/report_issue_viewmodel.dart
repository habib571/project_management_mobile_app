import 'package:flutter/material.dart';
import 'package:project_management_app/domain/models/user.dart';
import 'package:project_management_app/presentation/base/base_view_model.dart';

import '../../../../domain/models/project_member.dart';
import '../../../utils/colors.dart';
import '../view/widgets/assigned_memberchip.dart';

class ReportIssueViewModel extends BaseViewModel{
  ReportIssueViewModel(super.tokenManager);

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController issueTitle = TextEditingController();
  TextEditingController issueDescription = TextEditingController();

  GlobalKey<FormState> get formkey => _formkey;

  User? taggedMember ;//= User(22, "Ahmed", "ahmed@gmail.com", "https://images.unsplash.com/photo-1567784177951-6fa58317e16b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80" );
  //User? get taggedMember => _taggedMember ;

  bool _isUserAdded = false;
  bool get isUserAdded => _isUserAdded ;

  void toggleIsUserAdded() {
    print(_isUserAdded);
    _isUserAdded = !_isUserAdded;
    notifyListeners();
  }

  /*void updatetaggedMember(User newuser) {
    print(_isUserAdded);
    taggedMember = newuser ;
    notifyListeners();
  }*/

  void updatetaggedMember(User newuser) {
    taggedMember = newuser;
    _isUserAdded = true; // Mettez à jour cette variable
    notifyListeners();
  }


}