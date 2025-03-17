import 'package:project_management_app/domain/models/task.dart';
import 'package:project_management_app/presentation/base/base_view_model.dart';
import 'package:project_management_app/presentation/modules/tasks/viewmodel/manage_task_view_model.dart';
import 'package:project_management_app/presentation/stateRender/state_render.dart';

import '../../../stateRender/state_render_impl.dart';

class TaskDetailsViewModel extends BaseViewModel {
  TaskDetailsViewModel(super.tokenManager, this._addTaskViewModel);
  final ManageTaskViewModel _addTaskViewModel ;

  TaskModel? _task ;
  TaskModel get task => _task! ;
  setTask(TaskModel task) {
    _task = task ;
  }
  @override
  void start() {
    updateState(LoadingState(stateRendererType: StateRendererType.overlayLoadingState)) ;
    getTaskDetail() ;
    super.start();
  }
  void getTaskDetail() {
    updateState(LoadingState(stateRendererType: StateRendererType.overlayLoadingState)) ;
    setTask(_addTaskViewModel.task) ;

    if(_task !=null) {
       updateState(ContentState());
    }
  }



}