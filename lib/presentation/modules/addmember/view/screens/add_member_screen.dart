import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';
import 'package:project_management_app/application/extensions/string_extension.dart';
import 'package:project_management_app/presentation/sharedwidgets/custom_appbar.dart';
import '../../../../../application/dependencyInjection/dependency_injection.dart';
import '../../../../../domain/models/user.dart';
import '../../../../sharedwidgets/custom_button.dart';
import '../../../../sharedwidgets/image_widget.dart';
import '../../../../sharedwidgets/input_text.dart';
import '../../../../stateRender/state_render_impl.dart';
import '../../../../utils/colors.dart';
import '../../viewmodel/add_member_viewmodel.dart';

class AddMemberScreen extends StatefulWidget {

   const AddMemberScreen({super.key,});

  @override
  State<AddMemberScreen> createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {

  final AddMemberViewModel _viewModel = instance<AddMemberViewModel>();
  final User user = Get.arguments;

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
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
             SizedBox(
                 height: 25.h,
             ),
             const CustomAppBar(title: "Add Member"),
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
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImagePlaceHolder(
              imgBorder: true,
              radius: 35,
              imageUrl: user.imageUrl ,
            ),
            const SizedBox(width: 20),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.person, color: AppColors.primary, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        user.fullName,
                        style:const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.email, color: AppColors.primary, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        user.email,
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
      prefixIcon: const Padding(
        padding:  EdgeInsetsDirectional.only(end: 12),
        child: Icon(Icons.badge)
      ),
      hintText: "Add member role",
    );
  }

  Widget _addMemberButtonSuction() {
    return CustomButton(
        onPressed: () {
          _viewModel.addMember( user.id  );
        },
        text: 'Add member');
  }
}
