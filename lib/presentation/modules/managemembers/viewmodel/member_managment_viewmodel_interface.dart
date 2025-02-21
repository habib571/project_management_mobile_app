import 'package:flutter/material.dart';

import '../../../base/base_view_model.dart';

abstract class MemberManagementInterface extends BaseViewModel  {

  MemberManagementInterface(super.tokenManager);

  GlobalKey<FormState> get formkey;
  TextEditingController get role;

  Future<void> manageMember(int memberId,{int? projectId});
}