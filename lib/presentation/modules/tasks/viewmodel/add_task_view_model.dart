import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_app/domain/models/project_member.dart';
import 'package:project_management_app/domain/usecases/task/add_task_user_case.dart';
import 'package:project_management_app/presentation/base/base_view_model.dart';
import 'package:project_management_app/presentation/modules/dashboord/viewmodel/project_details_view_models/project_detail_view_model.dart';
import 'package:project_management_app/presentation/modules/tasks/view/screens/task_detail_screen.dart';
import 'package:project_management_app/presentation/modules/tasks/view/widget/task_priority_chip.dart';
import 'package:project_management_app/presentation/stateRender/state_render.dart';
import '../../../../domain/models/task.dart';
import '../../../stateRender/state_render_impl.dart';

class AddTaskViewModel extends BaseViewModel{
  final ProjectDetailViewModel _projectDetailViewModel ;
  ProjectDetailViewModel get projectViewModel => _projectDetailViewModel ;

  final AddTaskUseCase _addTaskUseCase ;
  AddTaskViewModel(super.tokenManager, this._projectDetailViewModel, this._addTaskUseCase);

  @override
  void start() {
    updateState(ContentState()) ;
    super.start();
  }
  ProjectMember? _projectMember ;
  ProjectMember get projectMember => _projectMember! ;
  void setProjectMember(ProjectMember projectMember) {
     _projectMember = projectMember ;
      log(projectMember.user!.fullName) ;
      notifyListeners() ;
  }
  TaskModel? _task ;
  TaskModel get task => _task! ;
   setTask(TaskModel task) {
      _task = task ;
   }

  bool _isUserAdded =false;
  bool get isUserAdded => _isUserAdded ;

  void toggleIsUserAdded() {
    _isUserAdded = !_isUserAdded;
    notifyListeners();
  }
  int _selectedIndex = -1;
  int get selectedIndex => _selectedIndex;

  void selectChip(int index) {
    if (_selectedIndex == index) {
      _selectedIndex = -1;
    } else {
      _selectedIndex = index;
    }
    notifyListeners();
  }

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController taskName = TextEditingController();
  TextEditingController taskDescription = TextEditingController();
  TextEditingController taskDeadline = TextEditingController();

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
      taskDeadline.text = "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year}";
    }
  }
   addTask() async { 
    updateState(LoadingState(stateRendererType: StateRendererType.overlayLoadingState)) ;
    TaskModel taskRequest =
    TaskModel.request(
        taskName.text,
        taskDescription.text,
        taskDeadline.text, 
        chipTexts[_selectedIndex] ,
        projectMember.user!.id
    ) ;
    (await _addTaskUseCase.addTask(taskRequest ,projectMember.project!.id! )).fold(
         (failure) {
           updateState(ErrorState(StateRendererType.snackbarState, failure.message)) ;
         },
         (data)
        async {
           updateState(ContentState()) ;
            setTask(data) ;
            Get.to(()=>const TaskDetailScreen()) ;
         }
     ) ;
   }

}