import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_app/application/helpers/get_storage.dart';
import 'package:project_management_app/data/network/requests/auth_requests.dart';
import 'package:project_management_app/domain/usecases/auth/signin_usecase.dart';

import 'package:project_management_app/presentation/base/base_view_model.dart';
import 'package:project_management_app/presentation/stateRender/state_render.dart';
import 'package:project_management_app/presentation/stateRender/state_render_impl.dart';

import '../../../../application/navigation/routes_constants.dart';
import '../../../../application/helpers/token_mamanger.dart';

class SignInViewModel extends BaseViewModel {
  final SignInUseCase _signInUseCase;
  final LocalStorage _localStorage;

  SignInViewModel(this._signInUseCase, this._localStorage,super.tokenManager,{super.startTokenMonitoringOnInit =false}  )  ;

  @override
  void start() {
    updateState(ContentState());
    super.start();
  }

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool _isPasswordHidden = false;
  bool get isPasswordHidden => _isPasswordHidden;

  GlobalKey<FormState> get formkey => _formkey;

  void signIn() async {
 if (formkey.currentState!.validate()) {
      updateState(LoadingState(stateRendererType: StateRendererType.overlayLoadingState));

      (await _signInUseCase.signIn(SignInRequest(
        email: email.text.trim(),
        password: password.text.trim(),
      ))).fold(
        (failure) {
          updateState(
            ErrorState(StateRendererType.snackbarState, failure.message),
          );
        },
        (data) {
           _localStorage.saveUserDetail(data);
            Get.offAllNamed(AppRoutes.home) ;
        },
      );
    }
  }

  void hideOrShowPassword() {
    _isPasswordHidden = !_isPasswordHidden;
    notifyListeners();
  }
}
