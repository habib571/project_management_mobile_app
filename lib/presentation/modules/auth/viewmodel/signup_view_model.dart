import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_app/data/network/requests/auth_requests.dart';
import 'package:project_management_app/domain/usecases/signup_usecase.dart';
import 'package:project_management_app/presentation/base/base_view_model.dart';
import 'package:project_management_app/presentation/stateRender/state_render.dart';
import 'package:project_management_app/presentation/stateRender/state_render_impl.dart';

import '../../../../application/helpers/get_storage.dart';
import '../../../../application/navigation/routes_constants.dart';

class SignupViewModel extends BaseViewModel {
  final SignupUseCase _useCase;
  final LocalStorage _localStorage ;
  SignupViewModel(this._useCase, this._localStorage, );

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  GlobalKey<FormState> get formkey => _formkey;

  bool _isPasswordHidden = false;
  bool get isPasswordHidden => _isPasswordHidden;

  @override
  void start() {
    updateState(ContentState());
  }

  void signup() async {
    if(formkey.currentState!.validate()) {
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
      (data) {
      _localStorage.saveAuthToken(data.token);
         Get.offAllNamed(AppRoutes.home) ;
      },
    );
  } }
  void hideorshowpassword() {
    _isPasswordHidden = !_isPasswordHidden;
    notifyListeners();
  }
}
