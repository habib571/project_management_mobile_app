import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project_management_app/domain/models/project.dart';
import 'package:project_management_app/presentation/base/base_view_model.dart';
import 'package:project_management_app/presentation/stateRender/state_render.dart';
import 'package:project_management_app/presentation/stateRender/state_render_impl.dart';

import '../../../../domain/usecases/project/addproject-use-case.dart';

class AddProjectViewModel extends BaseViewModel{

  final AddProjectUseCase _addProjectUseCase ;
  AddProjectViewModel(super.tokenManager, this._addProjectUseCase);

  @override
  void start() {
    updateState(ContentState()) ;
    super.start();
  }
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
   addProject() async{
    if (formkey.currentState!.validate()) {
      (await _addProjectUseCase.addProject(Project.request(projectName.text, projectDescription.text, projectEndDate.text)))
          .fold((failure) {
             updateState(ErrorState(StateRendererType.snackbarState, failure.message)) ;
      }, (success) {
            Get.back( );
      }
      ) ;

    }
  }
}