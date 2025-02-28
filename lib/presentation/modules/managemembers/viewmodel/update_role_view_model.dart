

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project_management_app/data/network/failure.dart';
import 'package:project_management_app/domain/models/project_member.dart';

import '../../../../data/network/requests/add_member_request.dart';
import '../../../../domain/usecases/project/add_member_use_case.dart';
import '../../../../domain/usecases/project/update_member_role_use_case.dart';
import '../../../base/base_view_model.dart';
import '../../../stateRender/state_render.dart';
import '../../../stateRender/state_render_impl.dart';
import '../../dashboord/view/screens/project_details/projet_detail_screen.dart';
import '../../dashboord/viewmodel/dashboard_view_model.dart';
import 'add_member_viewmodel.dart';
import 'member_managment_viewmodel_interface.dart';

class UpdateRoleViewModel extends BaseViewModel implements MemberManagementInterface {
  final UpdateMemberRoleUseCase updateMemberRoleUseCase ;
  //final DashBoardViewModel _dashBoardViewModel;
  UpdateRoleViewModel(super.tokenManager, this.updateMemberRoleUseCase);

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  GlobalKey<FormState> get formkey => _formkey;

  final TextEditingController _role = TextEditingController();
  @override
  TextEditingController get role => _role;


  @override
  Future<void> manageMember(int memberId,int projectId) async {
    if (_formkey.currentState!.validate()) {
      updateState(LoadingState(
          stateRendererType: StateRendererType.overlayLoadingState));

      (await updateMemberRoleUseCase.updateMemberRole(ProjectMember.updateRoleRequest(projectId, _role.text.trim())))
          .fold(
            (failure) {
          updateState(
            ErrorState(StateRendererType.snackbarState, failure.message),
          );
        },
            (data) {
          updateState(ContentState());
        },
      );
    }
  }

}
