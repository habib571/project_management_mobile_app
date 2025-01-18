import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';
import 'package:project_management_app/application/extensions/string_extension.dart';
import 'package:project_management_app/application/navigation/routes_constants.dart';
import 'package:project_management_app/presentation/modules/auth/viewmodel/signup_view_model.dart';
import 'package:project_management_app/presentation/sharedwidgets/custom_button.dart';
import 'package:project_management_app/presentation/sharedwidgets/input_text.dart';
import 'package:project_management_app/presentation/stateRender/state_render_impl.dart';
import 'package:provider/provider.dart';
import '../../../../../application/dependencyInjection/dependency_injection.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/styles.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final SignupViewModel _viewModel = instance<SignupViewModel>();
  @override
  void initState() {
    _viewModel.start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      body: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data?.getScreenWidget(context, _showBody(), () {
                  _viewModel.start();
                }) ??
                _showBody();
          }),
    );
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
              padding:  EdgeInsets.symmetric(horizontal: 25.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 180.h,
                  ),
                  _showWelcomeSection(),
                  SizedBox(
                    height: 50.h,
                  ),
                  _showNameSection(),
                  const SizedBox(
                    height: 20,
                  ),
                  _showEmailSection(),
                  const SizedBox(
                    height: 20,
                  ),
                  _showPasswordSection(),
                  SizedBox(
                    height: 100.h,
                  ),
                  _showButton(),
                  const SizedBox(
                    height: 20,
                  ),
                  _showSignInText()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _showWelcomeSection() {
    return Column(
      children: [
        Text('Welcome! Let’s get you started',
            style: robotoBold.copyWith(fontSize: 18)),
        Text('Let DO Pro be your daily assistant to help you achieve more',
            style: robotoBold.copyWith(
                fontSize: 13, color: AppColors.secondaryTxt)),
      ],
    );
  }

  Widget _showNameSection() {
    return InputText(
      validator: (val) => val.isEmptyInput(),
      controller: _viewModel.name,
      hintText: "Enter your full name",
    );
  }

  Widget _showEmailSection() {
    return InputText(
      validator: (val) => val.isValidEmail(),
      controller: _viewModel.email,
      hintText: "Enter your email",
    );
  }

  Widget _showPasswordSection() {
    return Consumer<SignupViewModel>(
      builder: (context, data, child) {
        return InputText(
          validator: (val) => val.isStrongPassword(),
          controller: _viewModel.password,
          hintText: "Enter your password",
          obscureText: data.isPasswordHidden,
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

  Widget _showButton() {
    return CustomButton(
        onPressed: () {
          _viewModel.signup();
        },
        text: 'Signup');
  }

  Widget _showSignInText() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        'Already have an account?',
        style: robotoMedium.copyWith(fontSize: 14),
      ),
      GestureDetector(
        onTap: () => Get.toNamed(AppRoutes.login),
        child: Text(
          'SignIn',
          style: robotoMedium.copyWith(color: AppColors.primary),
        ),
      )
    ]);
  }
}
