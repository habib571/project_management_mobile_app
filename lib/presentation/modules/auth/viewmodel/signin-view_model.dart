import 'package:flutter/material.dart';
import 'package:project_management_app/data/network/requests/auth_requests.dart';
import 'package:project_management_app/domain/usecases/signin_usecase.dart';

import 'package:project_management_app/presentation/base/base_view_model.dart';
import 'package:project_management_app/presentation/stateRender/state_render.dart';
import 'package:project_management_app/presentation/stateRender/state_render_impl.dart';

import '../../../../data/services/token_mamanger.dart';

class SignInViewModel extends BaseViewModel {
  final SignInUseCase _signInUseCase;

  SignInViewModel(this._signInUseCase);

  @override
  void start() {
    updateState(ContentState());
    super.start();
  }

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool _isPasswordHidden = false;
  bool get isPasswordHidden => _isPasswordHidden;

  GlobalKey<FormState> get formkey => _formkey;

  void signin() async {
    if (formkey.currentState!.validate()) {
      updateState(LoadingState(
          stateRendererType: StateRendererType.fullScreenLoadingState));
      (await _signInUseCase.SignIn(RegisterRequest(
        email: email.text.trim(),
        fullName: "",
        password: password.text.trim(),
      )))
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

  void hideorshowpassword() {
    _isPasswordHidden = !_isPasswordHidden;
    print(_isPasswordHidden);
    notifyListeners();
  }
}
