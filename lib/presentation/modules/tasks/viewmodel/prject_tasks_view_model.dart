import 'package:flutter/material.dart';
import 'package:project_management_app/data/network/requests/pagination.dart';
import 'package:project_management_app/domain/models/Task/task.dart';
import 'package:project_management_app/domain/usecases/task/get_all_tasks.dart';
import 'package:project_management_app/presentation/base/base_view_model.dart';
import 'package:project_management_app/presentation/modules/dashboord/viewmodel/project_details_view_models/project_detail_view_model.dart';
import 'package:project_management_app/presentation/modules/tasks/viewmodel/manage_task_view_model.dart';
import 'package:project_management_app/presentation/stateRender/state_render.dart';

import '../../../../application/helpers/get_storage.dart';
import '../../../stateRender/state_render_impl.dart';

class ProjectTasksViewModel extends BaseViewModel {

  final GetProjectTasksUseCase _getProjectTasksUseCase ;
  final ProjectDetailViewModel _projectDetailViewModel ;
  final LocalStorage localStorage ;

  ProjectTasksViewModel(super.tokenManager, this._getProjectTasksUseCase, this._projectDetailViewModel, this.localStorage,);
  @override
  void start() {
    getProjectTasks() ;
    super.start();
  }

  bool isTaskEditable(TaskModel task){
    bool toMe = localStorage.getUser().id == task.assignedUser!.id ;
    bool createdByMe = localStorage.getUser().id == task.project!.createdBy!.id ;
    return toMe || createdByMe ;
  }

  final List<TaskModel> _tasks =[] ;
  List<TaskModel> get tasks => _tasks ;

  TaskModel? _selectedTask ; // Task that will be updated
  TaskModel? get selectedTask => _selectedTask ;
  set selectedTask(TaskModel? value) {
      _selectedTask = value;
      notifyListeners();
  }

  int _currentPage = 0;
  int get currentPage => _currentPage;

  bool isLoading =false;

  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;

  bool hasMore = true;
  final int _pageSize = 5;

  final ValueNotifier<FlowState> _stateNotifier = ValueNotifier(ContentState());
  ValueNotifier<FlowState> get stateNotifier => _stateNotifier;

  getProjectTasks() async{
    _stateNotifier.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState) ;
  //  if (_isLoadingMore || !hasMore) return;
    if (_currentPage == 0) {
      _tasks.clear();
      _currentPage = 0;
      hasMore = true;
      _stateNotifier.value = ContentState();
    }

    _isLoadingMore = true;

    (await _getProjectTasksUseCase.getProjectTasks(
        _projectDetailViewModel.dashBoardViewModel.project!.id!,
        Pagination(_currentPage ,_pageSize))
    ).fold((failure) { 
    _stateNotifier.value =ErrorState(StateRendererType.fullScreenErrorState, failure.message);
    } ,
        (data) {
         _stateNotifier.value = ContentState() ;
           _tasks.addAll(data) ;
         _currentPage++ ;
         _isLoadingMore = false;
         if (data.length < _pageSize) {
           hasMore = false;
         }
        }
    ) ;
    _isLoadingMore = false;
    
  }




}