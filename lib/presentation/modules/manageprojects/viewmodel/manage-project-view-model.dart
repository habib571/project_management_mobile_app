import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:project_management_app/domain/models/project.dart';
import 'package:project_management_app/presentation/base/base_view_model.dart';
import 'package:project_management_app/presentation/stateRender/state_render.dart';
import 'package:project_management_app/presentation/stateRender/state_render_impl.dart';
import '../../../../domain/usecases/project/manageproject-use-case.dart';
import '../../dashboord/viewmodel/dashboard_view_model.dart';

class ManageProjectViewModel extends BaseViewModel {
  final ManageProjectUseCase _manageProjectUseCase;
  final DashBoardViewModel dashBoardViewModel;

  ManageProjectViewModel(super.tokenManager, this._manageProjectUseCase,
      this.dashBoardViewModel, this.toEdit) {
    _initControllers();
    print("ManageProjectViewModel CONSTRUCTOR CALLED! ${this.hashCode} ");
  }

  @override
  void start() {
    updateState(ContentState());
    super.start();
  }

  void _initControllers() {
    if (toEdit == true) {
      _projectName.text = dashBoardViewModel.project!.name!;
      _projectDescription.text = dashBoardViewModel.project!.description!;
      _projectEndDate.text = dashBoardViewModel.project!.endDate!;
    } else {
      _projectName.clear();
      _projectDescription.clear();
      _projectEndDate.clear();
    }
  }

  final bool toEdit;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  GlobalKey<FormState> get formkey => _formkey;

  final TextEditingController _projectName = TextEditingController();
  TextEditingController get projectName => _projectName;

  final TextEditingController _projectDescription = TextEditingController();
  TextEditingController get projectDescription => _projectDescription;

  final TextEditingController _projectEndDate = TextEditingController();
  TextEditingController get projectEndDate => _projectEndDate;

  String? selectedDate;

  pickProjectEndDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      selectedDate = pickedDate.toString();
      _projectEndDate.text =
          "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year}";
    }
  }

  addProject() async {
    if (formkey.currentState!.validate()) {
      updateState(LoadingState(
          stateRendererType: StateRendererType.fullScreenLoadingState));
      (await _manageProjectUseCase.addProject(Project.request(
              _projectName.text.trim(),
              _projectDescription.text.trim(),
              _projectEndDate.text.trim())))
          .fold((failure) {
        updateState(
            ErrorState(StateRendererType.snackbarState, failure.message));
      }, (success) {
        dashBoardViewModel.getMyProjects();
        updateState(ContentState());
        Get.back();
      });
    }
  }

  editProjectDetails() async {
    if (_formkey.currentState!.validate()) {
      updateState(LoadingState(
          stateRendererType: StateRendererType.fullScreenLoadingState));

      (await _manageProjectUseCase.updateProject(Project.updateProjectRequest(
              dashBoardViewModel.project!.id,
              _projectName.text.trim(),
              _projectDescription.text.trim(),
              _projectEndDate.text.trim())))
          .fold((failure) {
        updateState(
            ErrorState(StateRendererType.snackbarState, failure.message));
      }, (success) {
        Project updatedProject = dashBoardViewModel.project!.copyWith(
            name: _projectName.text.trim(),
            description: _projectDescription.text.trim(),
            endDate: _projectEndDate.text.trim());
        dashBoardViewModel.setProject(updatedProject);
        log(dashBoardViewModel.project!.name!);
        log(dashBoardViewModel.project!.description!);
        notifyListeners();
        updateState(ContentState());
        Get.back();
      });
    }
  }

  @override
  void dispose() {
    print("VM DISPOSED: $hashCode");
    super.dispose();
  }
}
