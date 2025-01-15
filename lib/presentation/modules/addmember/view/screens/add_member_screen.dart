import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';
import 'package:project_management_app/presentation/sharedwidgets/custum_listtile.dart';

import '../../../../../domain/models/user.dart';
import '../../../../sharedwidgets/custom_button.dart';
import '../../../../sharedwidgets/image_widget.dart';
import '../../../../sharedwidgets/input_text.dart';
import '../../../../utils/colors.dart';

class AddMemberScreen extends StatelessWidget {
  final User user;

  const AddMemberScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.scaffold,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: _showBody(),
        )
    );
  }

  Widget _showBody() {
    return SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
        SizedBox(
          height: 30.h,
        ),
        _showMemberSection(),
        SizedBox(
          height: 30.h,
        ),
        _addMemberRoleSection(),
        SizedBox(
          height: 40.h,
        ),
        _addMemberButtonSuction(),
      ]),
    );
  }

  Widget _showMemberSection() {
    return CustumListTitle(
        leading: ImagePlaceHolder(radius: 25.w, imageUrl: user.imageUrl),
        subtitle: Text(user.email),
        title: user.fullName,
        onTap: () {}
    );
  }

  Widget _addMemberRoleSection() {
    return InputText(
      //validator: (val) => val.isEmptyInput(),
      prefixIcon: Padding(
        padding:  EdgeInsetsDirectional.only(end: 12.w),
        child: const Icon(Icons.badge)
      ),
      hintText: "Add member role",
    );
  }

  Widget _addMemberButtonSuction() {
    return CustomButton(
        onPressed: () {},
        text: 'Add member');
  }
}
