import 'dart:developer';

import 'package:project_management_app/domain/models/project.dart';
import 'package:project_management_app/domain/usecases/project/myprojects_usecase.dart';
import 'package:project_management_app/presentation/base/base_view_model.dart';

import '../../../stateRender/state_render.dart';
import '../../../stateRender/state_render_impl.dart';

class DashBoardViewModel extends BaseViewModel {
  final GetMyProjectsUseCase _getMyProjectsUseCase;
  DashBoardViewModel(super.tokenManager, this._getMyProjectsUseCase);


  @override
  void start() {
    getMyProjects();
    super.start();
  }


  int _currentProject = 0;
  int get currentProject => _currentProject;

  Project? _project;
  Project get project => _project!;

  setProject(Project project) {
    _project = project;
    log(_project!.endDate.toString()) ;
    int index = _projectList.indexWhere((p)=> p.id == project.id);
    _projectList[index] = project;
    // to update listners (ProjectDetailViewModel + selector in the view)
    notifyListeners();
  }

  setCurrentProject(int value) {
    _currentProject = value;
    notifyListeners();
  }

  int _currentTask = 0;
  int get currentTask => _currentTask;

  setCurrentTask(int value) {
    _currentTask = value;
    notifyListeners();
  }

  List<Project> _projectList = [];

  List<Project> get projectList => _projectList;

  setProjectList(List<Project> value) {
    _projectList = value;
  }


  getMyProjects() async {
    updateState(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _getMyProjectsUseCase.getMyProjects()).fold((failure) {
      updateState(ErrorState(StateRendererType.snackbarState, failure.message));
    }, (data) {
      _projectList = data.projects;
      notifyListeners();
      log(_projectList.toString());
      updateState(ContentState());
    });
  }
}
