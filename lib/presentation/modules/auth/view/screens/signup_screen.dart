import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';
import 'package:project_management_app/application/extensions/string_extension.dart';
import 'package:project_management_app/presentation/modules/auth/viewmodel/signup_view_model.dart';
import 'package:project_management_app/presentation/sharedwidgets/custom_button.dart';
import 'package:project_management_app/presentation/sharedwidgets/input_text.dart';
import 'package:project_management_app/presentation/stateRender/state_render_impl.dart';
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
   _viewModel.start() ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      body: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
           return
              snapshot.data?.getScreenWidget(context, _showBody(), () {
                _viewModel.start();
              }) ?? _showBody() ;
          }),
    );
  }

  Widget _showBody() {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: SvgPicture.asset('assets/Shape.svg')),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
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
                _showButton()
              ],
            ),
          ),
        ],
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
    return  InputText(
       validator: (val)=> val.isEmptyInput() ,
      controller: _viewModel.name,
      hintText: "Enter your full name",
    );
  }

  Widget _showEmailSection() {
    return  InputText(
      validator: (val)=> val.isValidEmail() ,
      controller: _viewModel.email,
      hintText: "Enter your email",
    );
  }

  Widget _showPasswordSection() {
    return  InputText(
      validator: (val)=> val.isStrongPassword() ,
      controller: _viewModel.password,
      hintText: "Enter your password",
    );
  }

  Widget _showButton() {
    return CustomButton(
        onPressed: () {
          _viewModel.signup();
        },
        text: 'Signup');
  }
}
