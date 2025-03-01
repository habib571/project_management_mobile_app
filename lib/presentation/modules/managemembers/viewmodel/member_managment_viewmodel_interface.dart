import 'package:flutter/material.dart';

import '../../../base/base_view_model.dart';

abstract class MemberManagementInterface   {

  GlobalKey<FormState> get formkey;
  TextEditingController get role;

  Future<void> manageMember(int memberId,int projectId);
}