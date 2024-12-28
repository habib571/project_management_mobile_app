
import 'package:flutter/material.dart';
import 'package:project_management_app/application/extensions/string_extension.dart';

import '../../sharedwidgets/input_text.dart';
import '../../stateRender/state_render_impl.dart';
import '../../utils/colors.dart';

class AddProjectScreen extends StatelessWidget {
  const AddProjectScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.scaffold,
        body:_showBody(context)
    );
  }


  Widget _showBody(BuildContext context) {
    return Column(
      children: [
        _addProjectNameSection(),
        _addProjectDesrciprionSection(),
      ],
    );
  }

  Widget _addProjectNameSection(){
    return InputText(
      validator: (val) => val.isEmptyInput() ,
      //controller: _viewModel.email,
      hintText: "Enter The project name",
    );
  }

  Widget _addProjectDesrciprionSection(){
    return InputText(
      validator: (val) => val.isEmptyInput() ,
      //controller: _viewModel.email,
      hintText: "Enter The project description",
    );
  }



}




