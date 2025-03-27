
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_app/domain/models/project_member.dart';
import 'package:project_management_app/domain/usecases/task/manage_task_user_case.dart';
import 'package:project_management_app/presentation/base/base_view_model.dart';
import 'package:project_management_app/presentation/modules/dashboord/viewmodel/project_details_view_models/project_detail_view_model.dart';
import 'package:project_management_app/presentation/modules/tasks/view/screens/task_detail_screen.dart';
import 'package:project_management_app/presentation/modules/tasks/viewmodel/prject_tasks_view_model.dart';
import 'package:project_management_app/presentation/stateRender/state_render.dart';

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

  final ManageTaskUseCase _addTaskUseCase ;
  ManageTaskViewModel(super.tokenManager, this._projectDetailViewModel, this._addTaskUseCase, this.toEdit , this._projectTasksViewModel);

  @override
  void start() {
    updateState(ContentState()) ;
    initControllers();
    super.start();
  }


   bool toEdit = false ;
  void initControllers() {
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

  void initData() {
    taskName.clear();
    taskDescription.clear();
    taskDeadline.clear();
    _selectedPriorityIndex = _selectedStatusIndex = -1;
    _isUserAdded = false;
    _projectMember = null;
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
  bool addUserPermission () {
     if(toEdit){
       int taskCreatorId = _projectTasksViewModel.selectedTask!.project!.createdBy!.id ;
       int currentUserId = _projectTasksViewModel.localStorage.getUser().id ;
       print("$taskCreatorId / $currentUserId");
       return taskCreatorId == currentUserId ;
     }
     return true ;
  }
  bool _isUserAdded =false;
  bool get isUserAdded => _isUserAdded ;
  void toggleIsUserAdded() {
    _isUserAdded = !_isUserAdded;
    notifyListeners();
  }


  int _selectedPriorityIndex = -1;
  int get selectedPriorityIndex => _selectedPriorityIndex;
  set selectedPriorityIndex (int index){
    _selectedPriorityIndex = index ;
  }
  set selectPriorityChip(int index) {
    if (_selectedPriorityIndex == index) {
      _selectedPriorityIndex = -1;
    } else {
      _selectedPriorityIndex = index;
    }
    notifyListeners();
  }

  int _selectedStatusIndex = -1;
  int get selectedStatusIndex => _selectedStatusIndex;
  set selectedStatusIndex (int index){
    _selectedStatusIndex = index ;
  }
  set selectStatusChip(int index) {
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


  // --------------- ADD Task -------------------

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



  // --------------- Update Task -------------------


  void updateTask() {
    print("------- task Updated ------ $_selectedStatusIndex ");

    /*final task = projectTaskViewModel.selectedTask!;
    final newStatus = _selectedStatusIndex != -1 ? statusChipTexts[_selectedStatusIndex] : task.status  ;
    final newPriority =  _selectedPriorityIndex != -1 ? priorityChipTexts[_selectedPriorityIndex] : task.priority  ;

    final updatedTask = task.copyWith(
      name: /*taskName.text.trim().isNotEmpty ? taskName.text.trim() :*/ task.name,
      deadline: taskDeadline.text.trim().isNotEmpty ? taskDeadline.text.trim() : task.deadline,
      assignedUser: _projectMember?.user ?? task.assignedUser,
      status: newStatus ,
      priority: newPriority,
    );*/


    final task = projectTaskViewModel.selectedTask! ;
    final newStatus = _selectedStatusIndex != -1 ? statusChipTexts[_selectedStatusIndex] : task.status  ;
    final newPriority = _selectedPriorityIndex != -1 ? priorityChipTexts[_selectedPriorityIndex] : task.priority  ;

    final updatedTask = task.copyWith(
      name: taskName.text.trim().isNotEmpty ? taskName.text.trim() : task.name,
      description : taskDescription.text.trim().isNotEmpty ? taskDescription.text.trim() : task.description,
      deadline: taskDeadline.text.trim().isNotEmpty ? taskDeadline.text.trim() : task.deadline,
      assignedUser: _projectMember?.user ?? task.assignedUser,
      status: newStatus ,
      priority: newPriority,
    );

  /*  final TaskModel? updatedTask ;
    if(projectTaskViewModel.selectedTask != null){
      updatedTask = projectTaskViewModel.selectedTask!.copyWith(
        name: taskName.text.trim(),
        assignedUser : _projectMember?.user,
        status: statusChipTexts[_selectedStatusIndex] ,
        priority: priorityChipTexts[_selectedPriorityIndex] ,
      );
    }
    else{
      updatedTask = _task !;
    }*/


    int index = projectTaskViewModel.tasks.indexWhere((e) => e.id == updatedTask!.id);
    if (index != -1) {
      projectTaskViewModel.tasks[index] = updatedTask;
      //_task = updatedTask ;
      //projectTaskViewModel.selectedTask = _task ;
      projectTaskViewModel.notifyListeners();
      print('Task Updated -> Name: ${updatedTask.name}, '
          'Description: ${updatedTask.description}, '
          'Deadline: ${updatedTask.deadline}, '
          'Assigned User: ${updatedTask.assignedUser?.fullName ?? "Unassigned"}, '
          'Status: ${updatedTask.status}, '
          'Priority: ${updatedTask.priority}');
    }


    //projectTaskViewModel.selectedTask = null;

    //projectTaskViewModel.selectedTask = updatedTask;
  }
  /*
    void updateTask() {
    print("------- task Updated ------ $_selectedStatusIndex ");
    print("--- ${projectTaskViewModel.selectedTask!.name}");
    final newStatus = statusChipTexts[_selectedStatusIndex];
    final newPriority = priorityChipTexts[_selectedPriorityIndex];
    final updatedTask = projectTaskViewModel.selectedTask!.copyWith(
      name: taskName.text.trim(),
      deadline: taskDeadline.text.trim(),
      assignedUser: _projectMember!.user,
      status: newStatus,
      priority: newPriority,
    );
    int index = projectTaskViewModel.tasks.indexWhere((e) => e.id == updatedTask.id);
    if (index != -1) {
      projectTaskViewModel.tasks[index] = updatedTask;
      projectTaskViewModel.notifyListeners();
    }
    projectTaskViewModel.selectedTask = updatedTask;
    //projectTaskViewModel.notifyListeners();
  }
   */

  /*void updateTaskStatus({required TaskModel task, required String newStatus}) {
    final index = projectTaskViewModel.tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      final updatedTask = task.copyWith(
          name: taskName.text.isNotEmpty ? taskName.text.trim() : null ,
          deadline: taskDeadline.text.isNotEmpty ? taskDeadline.text.trim() : null ,
          assignedUser: _projectMember?.user,
          status: newStatus,
      );
      projectTaskViewModel.tasks[index] = updatedTask;
      projectTaskViewModel.selectedTask = updatedTask;
      //projectTaskViewModel.notifyListeners();
      // CALL THE API
    }
  }

  void updateTaskPriority({required TaskModel task, required String newPriority}) {
    final index = projectTaskViewModel.tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      final updatedTask = task.copyWith(
          name: taskName.text.isNotEmpty ? taskName.text.trim() : null ,
          deadline: taskDeadline.text.isNotEmpty ? taskDeadline.text.trim() : null ,
          assignedUser: _projectMember?.user,
          priority: newPriority
      );
      projectTaskViewModel.tasks[index] = updatedTask;
      projectTaskViewModel.selectedTask = updatedTask;
      //projectTaskViewModel.notifyListeners();
      // CALL THE API
    }
  }*/


}