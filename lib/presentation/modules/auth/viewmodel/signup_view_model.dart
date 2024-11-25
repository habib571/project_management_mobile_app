import 'package:flutter/material.dart';
import 'package:project_management_app/data/network/requests.dart';
import 'package:project_management_app/domain/usecases/signup_usecase.dart';
import 'package:project_management_app/presentation/base/base_view_model.dart';
import 'package:project_management_app/presentation/stateRender/state_render.dart';
import 'package:project_management_app/presentation/stateRender/state_render_impl.dart';

class SignupViewModel extends BaseViewModel {
  @override
  void start() {
    inputState.add(ContentState());
  }

  final SignupUseCase _useCase;
  SignupViewModel(this._useCase);
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  void signup() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));

    (await _useCase.signup(RegisterRequest(
            email: email.text.trim(),
            fullName: name.text.trim(),
            password: password.text.trim())))
        .fold(
            (failure) => inputState.add(
                ErrorState(StateRendererType.snackBarState, failure.message)),
            (success) {
      inputState.add(ContentState());
    });
  }
}
