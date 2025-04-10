import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_app/domain/models/project_member.dart';
import 'package:project_management_app/presentation/base/base_view_model.dart';
import 'package:project_management_app/presentation/modules/dashboord/view/screens/project_details/projet_detail_screen.dart';
import '../../../../data/network/requests/add_member_request.dart';
import '../../../../domain/usecases/project/manage_members_use_case.dart';
import '../../../stateRender/state_render.dart';
import '../../../stateRender/state_render_impl.dart';
import '../../dashboord/viewmodel/dashboard_view_model.dart';
import '../../dashboord/viewmodel/project_details_view_models/project_detail_view_model.dart';
import 'member_managment_viewmodel_interface.dart';


class ManageMembersViewModel extends BaseViewModel {
  final ManageMembersUseCase _manageMembersUseCase;
  final ProjectDetailViewModel _projectDetailViewModel;

  ManageMembersViewModel(super.tokenManager, this._manageMembersUseCase,
      this._projectDetailViewModel, this.toEdit,);

  final bool toEdit ;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  GlobalKey<FormState> get formkey => _formkey;

  final TextEditingController _role = TextEditingController();

  TextEditingController get role => _role;


  addMember(int? memberId, int projectId) async {
    if (_formkey.currentState!.validate()) {
      updateState(LoadingState(
          stateRendererType: StateRendererType.overlayLoadingState));
      print("---- ${role.text.trim()}");
      (await _manageMembersUseCase
          .addMember(
          ProjectMember.request(memberId, role.text.trim(), projectId) //userID
      ))
          .fold(
            (failure) {
          updateState(
            ErrorState(StateRendererType.snackbarState, failure.message),
          );
        },
            (data) {
          updateState(ContentState());
          Get.to(ProjectDetailScreen());
        },
      );
    }
  }

  Future<void> updateMemberRole(int? memberId, int projectId) async {
    if (_formkey.currentState!.validate()) {
      updateState(LoadingState(
          stateRendererType: StateRendererType.overlayLoadingState));
          print(_role.text.trim());
      (await _manageMembersUseCase.updateMemberRole(
          ProjectMember.updateRoleRequest(projectId, _role.text.trim())))
          .fold(
            (failure) {
          updateState(
            ErrorState(StateRendererType.snackbarState, failure.message),
          );
        },
            (data) {
          print("------$memberId");
          ProjectMember updatedMember = _projectDetailViewModel.projectMember
              .firstWhere((m) => m.id == memberId).copyWith(
              role: _role.text.trim()
          );
          //To Update the internal state
          _projectDetailViewModel.updatedMember(updatedMember);
          updateState(ContentState());
        },
      );
    }
  }
}

/*
class AddMemberViewModel extends BaseViewModel {
  final AddMemberUseCase _addMemberUseCase;
  final DashBoardViewModel _dashBoardViewModel; // No need we can get it from the argument
  AddMemberViewModel(
      super.tokenManager, this._addMemberUseCase, this._dashBoardViewModel);

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  GlobalKey<FormState> get formkey => _formkey;
  TextEditingController role = TextEditingController();

  void addMember(int memberId) async {
    if (_formkey.currentState!.validate()) {
      updateState(LoadingState(
          stateRendererType: StateRendererType.overlayLoadingState));

      (await _addMemberUseCase.addMember( // To refactor by using ProjectMember.request
          AddMemberRequest(
              memberId: memberId,
              projectId: _dashBoardViewModel.project.id!,
              role: role.text.trim())
      ))
          .fold(
        (failure) {
          updateState(
            ErrorState(StateRendererType.snackbarState, failure.message),
          );
        },
        (data) {
          updateState(ContentState());
          Get.to(const ProjectDetailScreen());
        },
      );
    }
  }
}


*/