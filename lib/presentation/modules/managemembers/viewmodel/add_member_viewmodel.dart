import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_app/domain/models/project_member.dart';
import 'package:project_management_app/presentation/base/base_view_model.dart';
import 'package:project_management_app/presentation/modules/dashboord/view/screens/project_details/projet_detail_screen.dart';
import '../../../../data/network/requests/add_member_request.dart';
import '../../../../domain/usecases/project/add_member_use_case.dart';
import '../../../stateRender/state_render.dart';
import '../../../stateRender/state_render_impl.dart';
import '../../dashboord/viewmodel/dashboard_view_model.dart';

abstract class MemberManagementInterface extends BaseViewModel  {

  MemberManagementInterface(super.tokenManager);

  GlobalKey<FormState> get formkey;
  TextEditingController get role;

  Future<void> manageMember(int memberId,{int? projectId});
}








class AddMemberViewModel extends BaseViewModel implements MemberManagementInterface {
  final AddMemberUseCase _addMemberUseCase;
  //final DashBoardViewModel _dashBoardViewModel;
  AddMemberViewModel(super.tokenManager, this._addMemberUseCase,);

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  GlobalKey<FormState> get formkey => _formkey;

  @override
  TextEditingController role = TextEditingController();

  @override
  Future<void> manageMember(int memberId,{int? projectId}) async {
    if (_formkey.currentState!.validate()) {
      updateState(LoadingState(
          stateRendererType: StateRendererType.overlayLoadingState));

      (await _addMemberUseCase.addMember(
          ProjectMember.request( memberId,role.text.trim(),2/*ProjectId*/)
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