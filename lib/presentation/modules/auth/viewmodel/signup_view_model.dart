import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project_management_app/data/network/requests.dart';
import 'package:project_management_app/domain/usecases/signup_usecase.dart';
import 'package:project_management_app/presentation/base/base_view_model.dart';
import 'package:project_management_app/presentation/stateRender/state_render.dart';
import 'package:project_management_app/presentation/stateRender/state_render_impl.dart';

class SignupViewModel extends BaseViewModel {
  final SignupUseCase _useCase;

  SignupViewModel(this._useCase);

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void start() {
    updateState(ContentState());
  }

  void signup() async {
    stateController.add(LoadingState(
      stateRendererType: StateRendererType.fullScreenLoadingState,
    ));

    (await _useCase.signup(RegisterRequest(
      email: email.text.trim(),
      fullName: name.text.trim(),
      password: password.text.trim(),
    )))
        .fold(
      (failure) => updateState(
        ErrorState(StateRendererType.snackbarState, failure.message),
      ),
      (success) {
        updateState(ContentState());
      },
    );
  }
}
