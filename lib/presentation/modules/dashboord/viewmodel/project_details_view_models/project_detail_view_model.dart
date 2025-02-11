
import 'package:project_management_app/application/helpers/get_storage.dart';
import 'package:project_management_app/domain/models/project_member.dart';
import 'package:project_management_app/domain/models/user.dart';
import 'package:project_management_app/domain/usecases/project/get_members.dart';
import 'package:project_management_app/presentation/base/base_view_model.dart';
import '../../../../../application/dependencyInjection/dependency_injection.dart';
import '../../../../../domain/models/project.dart';
import '../../../../stateRender/state_render.dart';
import '../../../../stateRender/state_render_impl.dart';
import '../dashboard_view_model.dart';
import 'edit_project_details_view_model.dart';

class ProjectDetailViewModel extends BaseViewModel {

  final EditProjectDetailsViewModel editProjectDetailsViewModel ;
 final DashBoardViewModel dashBoardViewModel ;
  final GetMembersUseCase _useCase ;
  final LocalStorage _localStorage ;
  ProjectDetailViewModel(super.tokenManager, this._useCase, this._localStorage, this.dashBoardViewModel, this.editProjectDetailsViewModel){
    dashBoardViewModel.addListener((){
      notifyListeners();
      print("----- ProjectDetailViewModel Notified");
    });
  }


  @override
  void start() {
    super.start();
    getProjectMembers();
  }

  List<ProjectMember> _projectMember = [];
  List<ProjectMember> get projectMember => _projectMember;


  getProjectMembers() async {
    updateState(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));

    (await _useCase.getProjectMembers(dashBoardViewModel.project.id!)).fold(
        (failure) {
          updateState(ErrorState(StateRendererType.fullScreenErrorState, failure.message));

        },
            (data) {
              _projectMember = data ;
              updateState(ContentState());
        }

    ) ;
  }

  bool isManger() =>dashBoardViewModel.project.createdBy!.id == _localStorage.getUser().id ;



}

