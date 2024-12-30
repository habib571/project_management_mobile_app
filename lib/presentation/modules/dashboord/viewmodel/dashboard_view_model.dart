import 'package:project_management_app/presentation/base/base_view_model.dart';

class DashBoardViewModel extends BaseViewModel {
  int _currentProject = 0;

  int get currentProject => _currentProject;

  set currentProject(int value) {
    _currentProject = value;
    notifyListeners() ;
  }

  int _currentTask = 0;

  int get currentTask => _currentTask;

  set currentTask(int value) {
    _currentTask = value;
    notifyListeners() ;
  }
}