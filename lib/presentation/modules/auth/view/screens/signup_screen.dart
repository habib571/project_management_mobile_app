import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';
import 'package:project_management_app/data/dataSource/remoteDataSource/auth_remote_data_source.dart';
import 'package:project_management_app/data/network/requests.dart';
import 'package:project_management_app/data/repositoryImp/auth_repo_impl.dart';
import 'package:project_management_app/presentation/sharedwidgets/custom_button.dart';
import 'package:project_management_app/presentation/sharedwidgets/input_text.dart';

import '../../../../../data/network/internet_checker.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/styles.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      body: SingleChildScrollView(
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
    return const InputText(
      hintText: "Enter your full name",
    );
  }

  Widget _showEmailSection() {
    return const InputText(
      hintText: "Enter your email",
    );
  }

  Widget _showPasswordSection() {
    return const InputText(
      hintText: "Enter your password",
    );
  }

  Widget _showButton() {
    return CustomButton(onPressed: () {}, text: 'Signup');
  }
}
