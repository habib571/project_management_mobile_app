

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../data/network/requests/add_member_request.dart';
import '../../../../domain/usecases/project/add_member_use_case.dart';
import '../../../base/base_view_model.dart';
import '../../../stateRender/state_render.dart';
import '../../../stateRender/state_render_impl.dart';
import '../../dashboord/view/screens/project_details/projet_detail_screen.dart';
import '../../dashboord/viewmodel/dashboard_view_model.dart';
import 'add_member_viewmodel.dart';
import 'member_managment_viewmodel_interface.dart';

class UpdateRoleViewModel extends BaseViewModel implements MemberManagementInterface {
  final AddMemberUseCase _addMemberUseCase;
  final DashBoardViewModel _dashBoardViewModel;
  UpdateRoleViewModel(super.tokenManager, this._addMemberUseCase, this._dashBoardViewModel);

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  GlobalKey<FormState> get formkey => _formkey;

  final TextEditingController _role = TextEditingController();
  @override
  TextEditingController get role => _role;

  @override
  Future<void> manageMember(int memberId,int projectId) async {
    if (_formkey.currentState!.validate()) {
      return Future.delayed(const Duration(seconds: 1000), () {
      });
    }
  }

}
