import 'dart:developer';

import 'package:project_management_app/domain/models/project.dart';
import 'package:project_management_app/presentation/base/base_view_model.dart';
import 'package:project_management_app/presentation/modules/dashboord/viewmodel/dashboard_view_model.dart';
import 'package:project_management_app/presentation/modules/dashboord/viewmodel/project_details_view_models/project_detail_view_model.dart';

class EditProjectDetailsViewModel extends BaseViewModel{
  EditProjectDetailsViewModel(super.tokenManager, this.dashBoardViewModel);

  //final ProjectDetailViewModel projectDetailViewModel ;
  final DashBoardViewModel dashBoardViewModel ;

  //To refactor With Tojson
  editDetails(String projectTitle){
    //dashBoardViewModel.project.name = projectTitle ;
    dashBoardViewModel.project = Project(
        dashBoardViewModel.project.id,
        dashBoardViewModel.project.name,
        dashBoardViewModel.project.description,
        dashBoardViewModel.project.startDate,
        dashBoardViewModel.project.endDate,
        dashBoardViewModel.project.progress,
        dashBoardViewModel.project.createdBy
    );
    log(dashBoardViewModel.project.name = projectTitle);
    notifyListeners();
  }
}