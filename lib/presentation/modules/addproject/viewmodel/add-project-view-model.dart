import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_management_app/domain/models/project.dart';
import 'package:project_management_app/presentation/base/base_view_model.dart';

import '../../../../domain/usecases/project/addproject-use-case.dart';

class AddProjectViewModel extends BaseViewModel{
  final AddProjectUseCase _addProjectUseCase ;


  AddProjectViewModel(super.tokenManager, this._addProjectUseCase);

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController projectName = TextEditingController();
  TextEditingController projectDescription = TextEditingController();
  TextEditingController projectEndDate = TextEditingController();

  String? selectedDate;

  pickProjectEndDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      selectedDate = pickedDate.toString() ;
      projectEndDate.text = "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year}";
    }
  }
  void addProject(){
    if (formkey.currentState!.validate()) {
       _addProjectUseCase.addProject(Project.request(
          projectName.text, projectDescription.text, projectEndDate.text));
    }
  }
}