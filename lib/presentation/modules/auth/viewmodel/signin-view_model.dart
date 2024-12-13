import 'package:flutter/material.dart';
import 'package:project_management_app/data/network/requests.dart';
import 'package:project_management_app/domain/usecases/signin_usecase.dart';

import 'package:project_management_app/presentation/base/base_view_model.dart';
import 'package:project_management_app/presentation/stateRender/state_render.dart';
import 'package:project_management_app/presentation/stateRender/state_render_impl.dart';

import '../../../../data/services/token_mamanger.dart';

class SignInViewModel extends BaseViewModel {
  SignInUseCase _useCase;
  //TokenManager _tokenManager;

  //SignInViewModel(this._useCase,this._tokenManager)   ;

  SignInViewModel(this._useCase /*, TokenManager tokenManager*/);


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
      updateState(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
      (await _useCase.SignIn(RegisterRequest(email: email.text.trim(), password: password.text.trim())))
          .fold(
        (failure) {
          print("---Failure---");
          updateState(ErrorState(StateRendererType.snackbarState, failure.message),);
          },
        (success) {
          print("Succes");
          updateState(ContentState());
        },
      );
      print("--state changet--");
    }
  }

  void hideorshowpassword() {
    _isPasswordHidden = !_isPasswordHidden;
    print(_isPasswordHidden);
    notifyListeners();
  }
}
