
import 'package:project_management_app/application/helpers/get_storage.dart';
import 'package:project_management_app/domain/models/project_member.dart';
import 'package:project_management_app/domain/models/user.dart';
import 'package:project_management_app/domain/usecases/project/delete_member_use_case.dart';
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
  final GetMembersUseCase _getMembersUseCase ;
  final DeleteMemberUseCase _deleteMemberUseCase ;
  final LocalStorage _localStorage ;
  ProjectDetailViewModel(super.tokenManager, this._getMembersUseCase, this._localStorage, this.dashBoardViewModel, this.editProjectDetailsViewModel, this._deleteMemberUseCase){
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

  // Function called by UpdateRoleViewModel to change the internal state when a member role is updated
  void updatedMember(ProjectMember member){
    int index = _projectMember.indexWhere((m)=> m.id == member.id);
    List<ProjectMember> updatedList = List.from(_projectMember);
    updatedList[index] = member;
    _projectMember = updatedList;
    notifyListeners();
  }

  void deleteMember(int memberId)async {
    updateState(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));

    (await _deleteMemberUseCase.deleteMemberUseCase(memberId)).fold(
            (failure) {
          updateState(ErrorState(StateRendererType.fullScreenErrorState, failure.message));
        },
            (data) {
          int index = _projectMember.indexWhere((m)=> m.id == memberId);
          List<ProjectMember> updatedList = List.from(_projectMember);
          updatedList.removeAt(index);
          _projectMember = updatedList;
          notifyListeners();
          updateState(ContentState());
        }

    ) ;
  }


  getProjectMembers() async {
    updateState(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));

    (await _getMembersUseCase.getProjectMembers(dashBoardViewModel.project.id!)).fold(
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

