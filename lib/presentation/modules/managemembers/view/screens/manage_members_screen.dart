import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_app/application/dependencyInjection/dependency_injection.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';
import 'package:project_management_app/application/extensions/string_extension.dart';
import 'package:project_management_app/domain/models/project_member.dart';
import 'package:project_management_app/presentation/sharedwidgets/custom_appbar.dart';
import '../../../../sharedwidgets/custom_button.dart';
import '../../../../sharedwidgets/image_widget.dart';
import '../../../../sharedwidgets/input_text.dart';
import '../../../../stateRender/state_render_impl.dart';
import '../../../../utils/colors.dart';
import '../../viewmodel/manage_members_viewmodel.dart';

/*
    - Screen used to Add a new member or to Update a specific member Role depends on arguments
*/

class ManageMembersScreen extends StatefulWidget {

   const ManageMembersScreen({super.key,}) ;

  @override
  State<ManageMembersScreen> createState() => _ManageMembersScreenState();
}

class _ManageMembersScreenState extends State<ManageMembersScreen> {

  ProjectMember member = Get.arguments?["member"] ;
  final ManageMembersViewModel _viewModel = instance<ManageMembersViewModel>(param1: Get.arguments?["toEdit"] );

  @override
  void initState() {
    super.initState();
    if (member.role != null && member.role!.isNotEmpty) {
      _viewModel.role.text = member.role!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.scaffold,
        body: StreamBuilder<FlowState>(
          stream:  _viewModel.outputState,
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
      child: Column(
        children: [
          SizedBox(
            height: 25.h,
          ),
          CustomAppBar(title: _viewModel.toEdit  ? 'Update Role'  : 'Add Member'),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
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
                const Spacer(),
                _addMemberButtonSuction(),
                SizedBox(height: 35.h,),
              ]),
            ),
          ),
        ],
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
              imageUrl: member.user!.imageUrl ,
              fullName: member.user!.fullName,
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
                        member.user!.fullName,
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
                        member.user!.email,
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
      controller:  _viewModel.role ,
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
          _viewModel.toEdit ? _viewModel.updateMemberRole(member.id , member.projectId!) : _viewModel.addMember(member.user?.id , member.projectId!) ;
        },
        text:_viewModel.toEdit  ? 'Update Role' : 'Add Member'  ,
    );
  }
}

