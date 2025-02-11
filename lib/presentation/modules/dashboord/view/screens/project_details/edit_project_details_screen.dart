import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';
import 'package:project_management_app/presentation/sharedwidgets/custom_button.dart';

import '../../../../../../application/dependencyInjection/dependency_injection.dart';
import '../../../../../sharedwidgets/custom_appbar.dart';
import '../../../../../sharedwidgets/input_text.dart';
import '../../../../../stateRender/state_render_impl.dart';
import '../../../../../utils/colors.dart';
import '../../../viewmodel/project_details_view_models/edit_project_details_view_model.dart';
import 'package:project_management_app/application/extensions/string_extension.dart';


class EditProjectDetails extends StatelessWidget {
  @override
  final EditProjectDetailsViewModel _viewModel = instance<EditProjectDetailsViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.scaffold,
        body: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data
                ?.getScreenWidget(context, _showBody(context), () {}) ??
                _showBody(context);
          },
        )
    );
  }


  Widget _showBody(BuildContext context) {
    return Form(
        key: _viewModel.formkey,
        child: Column(
          children: [
            SizedBox(height: 25.h,),
            const CustomAppBar(title: "Edit Project Details"),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 35.h,),
                    _projectTitleTextSection(),
                    SizedBox(height: 35.h,),
                    _projectDescriptionInputTextSection(),
                    SizedBox(height: 35.h,),
                    _editProjectEndDateSection(context),
                    const Spacer(),
                    _editButton(),
                    SizedBox(height: 35.h,),
              
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Widget _projectTitleTextSection() {
    return InputText(
      validator: (val) => val.isEmptyInput(),
      controller: _viewModel.projectTitle,
      //To modify
      prefixIcon: const Icon(Icons.folder_outlined),
      borderSide: const BorderSide(color: Colors.black),

    );
  }
  Widget _projectDescriptionInputTextSection(){
    return InputText(
      validator: (val) => val.isEmptyInput() ,
      controller: _viewModel.projectDescription,
      maxLines: 3,
      prefixIcon: const Icon(Icons.description_outlined),
      borderRadius: 20,
      borderSide: const BorderSide(color: Colors.black),
    );
  }

  Widget _editProjectEndDateSection(BuildContext context){
    return InputText(
      readOnly: true,
      validator: (val) => val.isEmptyInput() ,
      controller: _viewModel.projectEndDate,
      prefixIcon:const  Icon(Icons.calendar_month_outlined),
      onTap: () async {
        await _viewModel.pickProjectEndDate(context);
      },
    );
  }

  Widget _editButton() {
    return CustomButton(
        text: "Edit",
        onPressed: (){
          _viewModel.editDetails("new Title");
        }
    );
  }
}

