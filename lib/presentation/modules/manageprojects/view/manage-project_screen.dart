
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_it/get_it.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';
import 'package:project_management_app/application/extensions/string_extension.dart';
import 'package:project_management_app/presentation/modules/home/home_screen.dart';

import '../../../../application/dependencyInjection/dependency_injection.dart';
import '../../../sharedwidgets/custom_appbar.dart';
import '../../../sharedwidgets/custom_button.dart';
import '../../../sharedwidgets/input_text.dart';
import '../../../stateRender/state_render_impl.dart';
import '../../../utils/colors.dart';
import '../viewmodel/manage-project-view-model.dart';

/*
    - Screen used to Add a new project or to Update project details depends on arguments
 */


class ManageProjectScreen extends StatelessWidget {

  ManageProjectScreen({super.key}) ;

  final ManageProjectViewModel  _viewModel = instance<ManageProjectViewModel>(param1: Get.arguments?["toEdit"] ?? false);

   @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.scaffold,
        body:StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data
                ?.getScreenWidget(context, _showBody(context), () {}) ??
                _showBody(context);
          },
        ));
  }

  Widget _showBody(BuildContext context) {
    return Form(
      key: _viewModel.formkey ,
      child: Column(
        children: [
          SizedBox(height: 25.h,),
          _viewModel.toEdit == true ? const CustomAppBar(title: 'Edit Project'):const SizedBox.shrink(),
          SizedBox(
            height: 80.h,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  _addProjectNameSection(),
                  SizedBox(
                    height: 40.h,
                  ),
                  _addProjectDesrciptionSection(),
                  SizedBox(
                    height: 40.h,
                  ),
                  _addProjectEndDateSection(context),
                  const Spacer(),
                  _showButton(),
                  _viewModel.toEdit == true ? SizedBox(height: 35.h,) : SizedBox(height: 95.h,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _addProjectNameSection(){
    return InputText(
      validator: (val) => val.isEmptyInput() ,
      controller:   _viewModel.projectName,
      hintText: "Enter The project name",
      borderSide: const BorderSide(color: Colors.black),
    );
  }

  Widget _addProjectDesrciptionSection(){
    return InputText(
      validator: (val) => val.isEmptyInput() ,
      controller: _viewModel.projectDescription,
      hintText: "Enter The project description",
      maxLines: 3,
      borderRadius: 20,
      borderSide: const BorderSide(color: Colors.black),
    );
  }


  Widget _addProjectEndDateSection(BuildContext context){
    return InputText(
      readOnly: true,
      validator: (val) => val.isEmptyInput() ,
      controller: _viewModel.projectEndDate,
      hintText: "Enter The project end date",
      suffixIcon:const  Icon(Icons.calendar_month_outlined),
      borderSide: const BorderSide(color: Colors.black),
      onTap: () async {
        await _viewModel.pickProjectEndDate(context);
      },
    );
  }

   Widget _showButton() {
     return CustomButton(
         onPressed: () {
           _viewModel.toEdit == true ? _viewModel.editProjectDetails() : _viewModel.addProject();
         },
         text: _viewModel.toEdit == true ? 'Edit' : "Add Project"
     );
   }
}







