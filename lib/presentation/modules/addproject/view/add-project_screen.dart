
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';
import 'package:project_management_app/application/extensions/string_extension.dart';
import 'package:project_management_app/presentation/modules/home/home_screen.dart';

import '../../../../application/dependencyInjection/dependency_injection.dart';
import '../../../sharedwidgets/custom_appbar.dart';
import '../../../sharedwidgets/custom_button.dart';
import '../../../sharedwidgets/input_text.dart';
import '../../../stateRender/state_render_impl.dart';
import '../../../utils/colors.dart';
import '../viewmodel/add-project-view-model.dart';

class AddProjectScreen extends StatelessWidget {
   AddProjectScreen({super.key});

   final AddProjectViewModel _viewModel = instance<AddProjectViewModel>();

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
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 25.h,),
            const CustomAppBar(title: "Add Project"),
            SizedBox(
              height: 80.h,
            ),
            Padding(
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
                  SizedBox(
                    height: 60.h,
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

  Widget _addProjectNameSection(){
    return InputText(
      validator: (val) => val.isEmptyInput() ,
      controller: _viewModel.projectName,
      hintText: "Enter The project name",
      borderSide: const BorderSide(color: Colors.black),
    );
  }

  Widget _addProjectDesrciptionSection(){
    return InputText(
      validator: (val) => val.isEmptyInput() ,
      controller: _viewModel.projectDescription,
      hintText: "Enter The project description",
      borderSide: const BorderSide(color: Colors.black),
      maxLines: 3,
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
           _viewModel.addProject();
         },
         text: 'Add the project'
     );
   }
}







