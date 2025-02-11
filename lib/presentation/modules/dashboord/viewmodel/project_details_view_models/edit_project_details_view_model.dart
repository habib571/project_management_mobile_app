import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project_management_app/domain/models/project.dart';
import 'package:project_management_app/presentation/base/base_view_model.dart';
import 'package:project_management_app/presentation/modules/dashboord/viewmodel/dashboard_view_model.dart';
import 'package:project_management_app/presentation/modules/dashboord/viewmodel/project_details_view_models/project_detail_view_model.dart';

import '../../../../stateRender/state_render.dart';
import '../../../../stateRender/state_render_impl.dart';

class EditProjectDetailsViewModel extends BaseViewModel{

  EditProjectDetailsViewModel(super.tokenManager, this.dashBoardViewModel){
    _projectTitle.text = dashBoardViewModel.project.name! ;
    _projectDescription.text = dashBoardViewModel.project.description! ;
    _projectEndDate.text = dashBoardViewModel.project.endDate! ;
  }

  @override
  void start() {
    updateState(ContentState());
    super.start();
  }

  final DashBoardViewModel dashBoardViewModel ;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  GlobalKey<FormState> get formkey => _formkey;

  final TextEditingController _projectTitle = TextEditingController() ;
  TextEditingController get projectTitle => _projectTitle;

  final TextEditingController _projectDescription = TextEditingController();
  TextEditingController get projectDescription => _projectDescription;

  final TextEditingController _projectEndDate = TextEditingController();
  TextEditingController get projectEndDate => _projectEndDate;

  String? _selectedDate;

  pickProjectEndDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      _selectedDate = pickedDate.toString() ;
      projectEndDate.text = "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year}";
    }
  }


  editDetails(String projectTitle){
    if(_formkey.currentState!.validate()){
      (dashBoardViewModel.setProject ( dashBoardViewModel.project.copyWith(
          name: _projectTitle.text.trim(),
          description: _projectDescription.text.trim()
      ))).fold(
      (failure) {
        updateState(ErrorState(StateRendererType.snackbarState, failure.message)) ;
      },
      (success) {
        log(dashBoardViewModel.project.name! );
        notifyListeners();
         }
        );
      }
    }
  }



/*
  editDetails(String projectTitle){
    //dashBoardViewModel.project.name = projectTitle ;
    dashBoardViewModel.setProject ( Project(
        dashBoardViewModel.project.id,
        dashBoardViewModel.project.name,
        dashBoardViewModel.project.description,
        dashBoardViewModel.project.startDate,
        dashBoardViewModel.project.endDate,
        dashBoardViewModel.project.progress,
        dashBoardViewModel.project.createdBy
    ));
    log(dashBoardViewModel.project.name = projectTitle);
    notifyListeners();
  }
 */