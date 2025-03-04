

import 'package:flutter/material.dart';
import 'package:project_management_app/domain/models/project_member.dart';
import 'package:project_management_app/presentation/modules/dashboord/viewmodel/project_details_view_models/project_detail_view_model.dart';
import '../../../../domain/usecases/project/update_member_role_use_case.dart';
import '../../../base/base_view_model.dart';
import '../../../stateRender/state_render.dart';
import '../../../stateRender/state_render_impl.dart';
import 'member_managment_viewmodel_interface.dart';

class UpdateRoleViewModel extends BaseViewModel implements MemberManagementInterface {
  final UpdateMemberRoleUseCase updateMemberRoleUseCase ;
  final ProjectDetailViewModel _projectDetailViewModel;

  UpdateRoleViewModel(super.tokenManager, this.updateMemberRoleUseCase, this._projectDetailViewModel);

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  GlobalKey<FormState> get formkey => _formkey;

  final TextEditingController _role = TextEditingController();
  @override
  TextEditingController get role => _role;


  @override
  Future<void> manageMember(int? memberId,int projectId) async {
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
              print("------$memberId");
              ProjectMember updatedMember = _projectDetailViewModel.projectMember.firstWhere((m)=> m.id == memberId).copyWith(
                role: _role.text.trim()
              );
          _projectDetailViewModel.updatedMember(updatedMember);
          updateState(ContentState());
        },
      );
    }
  }

}
