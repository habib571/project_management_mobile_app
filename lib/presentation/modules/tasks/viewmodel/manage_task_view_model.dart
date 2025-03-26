import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_app/domain/models/project_member.dart';
import 'package:project_management_app/domain/usecases/task/add_task_user_case.dart';
import 'package:project_management_app/presentation/base/base_view_model.dart';
import 'package:project_management_app/presentation/modules/dashboord/viewmodel/project_details_view_models/project_detail_view_model.dart';
import 'package:project_management_app/presentation/modules/tasks/view/screens/task_detail_screen.dart';
import 'package:project_management_app/presentation/modules/tasks/viewmodel/prject_tasks_view_model.dart';
import 'package:project_management_app/presentation/stateRender/state_render.dart';
import 'package:provider/provider.dart';
import '../../../../application/constants/constants.dart';
import '../../../../domain/models/Task/task.dart';

import '../../../../domain/models/user.dart';
import '../../../stateRender/state_render_impl.dart';
import '../view/widget/task priority/task_priority_chip.dart';
import '../view/widget/task status/task_status_chip.dart';

class ManageTaskViewModel extends BaseViewModel{
  final ProjectTasksViewModel _projectTasksViewModel ;
  ProjectTasksViewModel get projectTaskViewModel => _projectTasksViewModel;

  final ProjectDetailViewModel _projectDetailViewModel ;
  ProjectDetailViewModel get projectViewModel => _projectDetailViewModel ;

  final AddTaskUseCase _addTaskUseCase ;
  ManageTaskViewModel(super.tokenManager, this._projectDetailViewModel, this._addTaskUseCase, this.toEdit , this._projectTasksViewModel);

  @override
  void start() {
    updateState(ContentState()) ;
    _initControllers();
    super.start();
  }


   bool toEdit = false ;
  void _initControllers() {
    _projectTasksViewModel.selectedTask?.name != null ?  print("----YES")  : print("--- null") ;
    if (toEdit == true && _projectTasksViewModel.selectedTask != null ) {
      taskName.text = _projectTasksViewModel.selectedTask!.name!;
      taskDescription.text = _projectTasksViewModel.selectedTask!.description!;
      taskDeadline.text = _projectTasksViewModel.selectedTask!.deadline!;
      _selectedPriorityIndex = priorityChipTexts.indexOf(_projectTasksViewModel.selectedTask!.priority!);
      _selectedStatusIndex = statusChipTexts.indexOf(_projectTasksViewModel.selectedTask!.status!);
      print("+++++ ${_projectTasksViewModel.selectedTask!.name!}  / ${_projectTasksViewModel.selectedTask!.status!}");
      _isUserAdded = true ;
      _projectMember  = ProjectMember.taskAsseignedMember(_projectTasksViewModel.selectedTask!.assignedUser) ;

    }else {
      taskName.clear();
      taskDescription.clear();
      taskDeadline.clear();
      _selectedPriorityIndex = -1 ;
      _selectedStatusIndex = -1 ;
      _isUserAdded = false ;
      //_projectMember = null ;
    }
  }


  ProjectMember? _projectMember ;
  ProjectMember get projectMember => _projectMember! ;

  void setProjectMember(ProjectMember projectMember) {
     _projectMember = projectMember ;
      //log(projectMember.user!.fullName) ;
      print("Selected Project Member -- ${projectMember.user!.fullName}");
      notifyListeners() ;
  }
  TaskModel? _task ;
  TaskModel? get task => _task ;
   setTask(TaskModel task) {
      _task = task ;
   }

  bool _isUserAdded =false;
  bool get isUserAdded => _isUserAdded ;

  void toggleIsUserAdded() {
    _isUserAdded = !_isUserAdded;
    notifyListeners();
  }
  int _selectedPriorityIndex = -1;
  int get selectedPriorityIndex => _selectedPriorityIndex;
  set selectedPriorityIndex(int index){
    _selectedPriorityIndex = index ;
  }

  int _selectedStatusIndex = -1;
  int get selectedStatusIndex => _selectedStatusIndex;
  set selectedStatusIndex(int index){
    _selectedStatusIndex = index ;
  }

  void selectPriorityChip(int index) {
    if (_selectedPriorityIndex == index) {
      _selectedPriorityIndex = -1;
    } else {
      _selectedPriorityIndex = index;
    }
    notifyListeners();
  }

  void selectStatusChip(int index) {
    if (_selectedStatusIndex == index) {
      _selectedStatusIndex = -1;
    } else {
      _selectedStatusIndex = index;
      print(_projectTasksViewModel.tasks.firstWhere((t)=> t.id == _projectTasksViewModel.selectedTask!.id ).name);
      _projectTasksViewModel.tasks.firstWhere((t)=> t.id == _projectTasksViewModel.selectedTask!.id ).status = statusChipTexts[_selectedStatusIndex];
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
    TaskModel taskRequest = TaskModel.request(
        taskName.text,
        taskDescription.text,
        taskDeadline.text,
        priorityChipTexts[_selectedPriorityIndex] ,
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
            //Get.back();
            Get.to(()=>const TaskDetailScreen() , arguments:  _task ) ;
         }
     ) ;
   }



  void updateTask() {
    print("------- task Updated ------ $_selectedStatusIndex ");
    print("--- ${projectTaskViewModel.selectedTask!.name}");
    final newStatus = statusChipTexts[_selectedStatusIndex];
    final updatedTask = projectTaskViewModel.selectedTask!.copyWith(
        name: taskName.text.trim(),
        deadline: taskDeadline.text.trim(),
        assignedUser: _projectMember!.user,
        status: newStatus,
    );
    int index = projectTaskViewModel.tasks.indexWhere((e) => e.id == updatedTask.id);
    if (index != -1) {
      projectTaskViewModel.tasks[index] = updatedTask;
      projectTaskViewModel.notifyListeners();
    }
    projectTaskViewModel.selectedTask = updatedTask;
    //projectTaskViewModel.notifyListeners();
  }

  void updateTaskStatus({required TaskModel task, required String newStatus}) {
    final index = projectTaskViewModel.tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      final updatedTask = task.copyWith(
          name: taskName.text.isNotEmpty ? taskName.text.trim() : null ,
          deadline: taskDeadline.text.isNotEmpty ? taskDeadline.text.trim() : null ,
          assignedUser: _projectMember?.user,
          status: newStatus
      );
      projectTaskViewModel.tasks[index] = updatedTask;
      projectTaskViewModel.selectedTask = updatedTask;
      //projectTaskViewModel.notifyListeners();
      // CALL THE API
    }
  }


}