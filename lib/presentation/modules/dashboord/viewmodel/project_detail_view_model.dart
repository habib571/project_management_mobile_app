import 'package:project_management_app/domain/models/project_member.dart';
import 'package:project_management_app/domain/usecases/project/get_members.dart';
import 'package:project_management_app/presentation/base/base_view_model.dart';
import '../../../../application/dependencyInjection/dependency_injection.dart';
import '../../../../domain/models/project.dart';
import '../../../stateRender/state_render.dart';
import '../../../stateRender/state_render_impl.dart';
import 'dashboard_view_model.dart';

class ProjectDetailViewModel extends BaseViewModel {
  final GetMembersUseCase _useCase ;
  ProjectDetailViewModel(super.tokenManager, this._useCase);

  @override
  void start() {
    super.start();
    getProjectMembers();
  }

  final Project project= instance<DashBoardViewModel>().project ;

  List<ProjectMember> _projectMember  = [];
  List<ProjectMember> get projectMember => _projectMember ;
  getProjectMembers() async {
    updateState(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));

    (await _useCase.getProjectMembers(project.id!)).fold(
        (failure) {
          updateState(ErrorState(StateRendererType.fullScreenErrorState, failure.message));
        },
        (data) {
          _projectMember = data ;
          updateState(ContentState()) ;
        }
    ) ;

  }
}