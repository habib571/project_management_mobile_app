import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:project_management_app/application/dependencyInjection/dependency_injection.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';
import 'package:project_management_app/application/extensions/string_extension.dart';
import 'package:project_management_app/presentation/modules/auth/viewmodel/signin-view_model.dart';
import 'package:project_management_app/presentation/sharedwidgets/custom_button.dart';
import 'package:project_management_app/presentation/sharedwidgets/input_text.dart';
import 'package:project_management_app/presentation/stateRender/state_render_impl.dart';
import 'package:project_management_app/presentation/utils/colors.dart';
import 'package:project_management_app/presentation/utils/styles.dart';
import 'package:provider/provider.dart';

import '../../../../../application/navigation/routes_constants.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({super.key});

  final SignInViewModel _viewModel = instance<SignInViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.scaffold,
        body: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data
                    ?.getScreenWidget(context, _showBody(), () {}) ??
                _showBody();
          },
        ));
  }

  Widget _showBody() {
    return Form( 
      key: _viewModel.formkey,
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: SvgPicture.asset('assets/Shape.svg')),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  SizedBox(height: 180.h,) ,
                  _showWelcomebackSection(),
                  SizedBox(height: 20.h),
                  SvgPicture.asset(
                    'assets/signin-image.svg',
                    height: 167,
                  ),
                  SizedBox(height: 90.h),
                  _showEmailSection(),
                  SizedBox(
                    height: 20.h,
                  ),
                  _showPasswordSection(),
                  SizedBox(
                    height: 40.h,
                  ),
                  _showForgetPasswordSection(),
                  SizedBox(
                    height: 40.h,
                  ),
                  _showButton() ,
                  SizedBox(height: 20,) ,
                  _showSignupText()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _showPasswordSection() {
    return Consumer<SignInViewModel>(
      builder: (context, data, child) {
        return InputText(
          validator: (val) => val.isStrongPassword(),
          controller:_viewModel.password,
          hintText: "Enter your password",
          obscureText:data.isPasswordHidden,
          suffixIcon: Padding(
            padding: const EdgeInsetsDirectional.only(end: 12.0),
            child: InkWell(
              child: data.isPasswordHidden
                  ? const Icon(Icons.visibility_off_outlined)
                  : const Icon(Icons.visibility_outlined),
              onTap: () {
                data.hideorshowpassword();
              },
            ),
          ),
        );
      },
    );
  }

  Widget _showWelcomebackSection() {
    return Text(
      "Welcome back!",
      style: robotoBold.copyWith(fontSize: 18),
    );
  }

  Widget _showEmailSection() {
    return InputText(
      validator: (val) => val.isValidEmail(),
      controller: _viewModel.email,
      hintText: "Enter your email",
    );
  }

  Widget _showButton() {
    return CustomButton(
        onPressed: () {
          _viewModel.signIn();
        },
        text: 'Log in');
  }

  Widget _showForgetPasswordSection() {
    return InkWell(
      child: Text(
        "Forgot password?",
        style: robotoRegular.copyWith(fontSize: 13, color: AppColors.primary),
      ),
      onTap: () {},
    );
  }
  Widget _showSignupText() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Already have an account?' ,
            style: robotoMedium.copyWith(fontSize: 14 ),
          ) ,
          GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.signup) ,
            child: Text('Register' ,style: robotoMedium.copyWith(color: AppColors.primary),
            ) ,

          )]

    ) ;
  }
}
