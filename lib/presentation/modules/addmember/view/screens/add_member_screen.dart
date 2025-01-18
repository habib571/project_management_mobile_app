import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';
import 'package:project_management_app/application/extensions/string_extension.dart';
import 'package:project_management_app/presentation/sharedwidgets/custom_listtile.dart';

import '../../../../../application/dependencyInjection/dependency_injection.dart';
import '../../../../../domain/models/user.dart';
import '../../../../sharedwidgets/custom_button.dart';
import '../../../../sharedwidgets/image_widget.dart';
import '../../../../sharedwidgets/input_text.dart';
import '../../../../stateRender/state_render_impl.dart';
import '../../../../utils/colors.dart';
import '../../viewmodel/add_member_viewmodel.dart';

class AddMemberScreen extends StatefulWidget {
  final User user;

   const AddMemberScreen({super.key, required this.user});

  @override
  State<AddMemberScreen> createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {

  final AddMemberViewModel _viewModel = instance<AddMemberViewModel>();

  @override
  void initState() {
    super.initState();
  }

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
        )
    );
  }

  Widget _showBody() {
    return Form(
      key: _viewModel.formkey ,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
            SizedBox(
              height: 50.h,
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
        ),
      ),
    );
  }

  Widget _showMemberSection() {
    return Card(
      color: Colors.white,
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 0),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 70.w,
              height: 70.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primary,
                  width: 2.w,
                ),
              ),
              child: ClipOval(
                child: ImagePlaceHolder(
                  radius: 35.w,
                  imageUrl: widget.user.imageUrl,
                ),
              ),
            ),
            SizedBox(width: 20.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.person, color: AppColors.primary, size: 18.w),
                      SizedBox(width: 8.w),
                      Text(
                        widget.user.fullName,
                        style:const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      Icon(Icons.email, color: AppColors.primary, size: 18.w),
                      SizedBox(width: 8.w),
                      Text(
                        widget.user.email,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _addMemberRoleSection() {
    return InputText(
      validator: (val) => val.isEmptyInput(),
      controller: _viewModel.role ,
      prefixIcon: Padding(
        padding:  EdgeInsetsDirectional.only(end: 12.w),
        child: const Icon(Icons.badge)
      ),
      hintText: "Add member role",
    );
  }

  Widget _addMemberButtonSuction() {
    return CustomButton(
        onPressed: () {
          _viewModel.addMember( widget.user.id  );
        },
        text: 'Add member');
  }
}
