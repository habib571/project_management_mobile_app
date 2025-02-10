import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_management_app/presentation/sharedwidgets/custom_button.dart';

import '../../../../../../application/dependencyInjection/dependency_injection.dart';
import '../../../viewmodel/project_details_view_models/edit_project_details_view_model.dart';

class EditProjectDetails extends StatelessWidget{
  @override

  final EditProjectDetailsViewModel _viewModel = instance<EditProjectDetailsViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child:
        CustomButton(
         text: "Edit",
          onPressed: (){
           _viewModel.editDetails("new Title");
          }
      ),)
    );
  }
}