import 'package:flutter/material.dart';
import 'package:project_management_app/presentation/base/base_view_model.dart';

import '../../../../application/dependencyInjection/dependency_injection.dart';
import '../../../../data/network/requests/add_member_request.dart';
import '../../../../domain/models/project.dart';
import '../../../../domain/usecases/project/add_member_use_case.dart';
import '../../../../domain/usecases/project/get_members.dart';
import '../../../stateRender/state_render.dart';
import '../../../stateRender/state_render_impl.dart';
import '../../dashboord/viewmodel/dashboard_view_model.dart';

class AddMemberViewModel extends BaseViewModel{

  final AddMemberUseCase _addMemberUseCase;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  GlobalKey<FormState> get formkey => _formkey;
  TextEditingController role = TextEditingController();
  
  AddMemberViewModel(super.tokenManager, this._addMemberUseCase);

  final Project project = instance<DashBoardViewModel>().project; // To Modify

  void addMember(int memberId  ) async {
    if (_formkey.currentState!.validate()) {
      updateState(LoadingState(stateRendererType: StateRendererType.overlayLoadingState));

      (await _addMemberUseCase.addMember(
          AddMemberRequest(memberId: memberId, projectId: project.id! , role: role.text.trim()
        ))).fold(
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