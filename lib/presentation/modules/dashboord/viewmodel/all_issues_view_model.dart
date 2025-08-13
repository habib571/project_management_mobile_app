import 'package:dartz/dartz.dart';
import 'package:project_management_app/domain/models/issue.dart';
import 'package:project_management_app/domain/usecases/project/issue/get_allissues_use_case.dart';
import '../../../base/base_view_model.dart';
import '../../../stateRender/state_render.dart';
import '../../../stateRender/state_render_impl.dart';
import 'dashboard_view_model.dart';

class GetAllIssuesViewModel extends BaseViewModel{
  final GetAllIssuesUseCase _useCase ;
  final DashBoardViewModel dashBoardViewModel;

  GetAllIssuesViewModel(super.tokenManager, this._useCase, this.dashBoardViewModel){
      print("CONSTRUCTOR CALLED! ${this.hashCode} issuesList length: ${issuesList.length}");
  }


  @override
  void start() async {
    super.start();
    await getAllProjectIssues();
  }

  List<Issue> issuesList = [];

  getAllProjectIssues() async {
    updateState(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));

    (await _useCase.getAllIssues(dashBoardViewModel.project!.id!)).fold(
            (failure) {
          updateState(ErrorState(StateRendererType.fullScreenErrorState, failure.message));
        },
            (data) {
          //issuesList.clear();
          issuesList.addAll(data) ;
          updateState(ContentState());
        }
    );
  }

  updateIssueStatus(int issueId) async {
    updateState(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));

    (await _useCase.updateIssueStatus(issueId)).fold(
            (failure) {
          updateState(ErrorState(StateRendererType.fullScreenErrorState, failure.message));
        },
            (data) {
              Issue issue = issuesList.firstWhere((element) => element.issueId == issueId);
              issue.isSolved = !issue.isSolved;
              notifyListeners();
              updateState(ContentState());
        }
    );
  }

  @override
  void dispose() {
    issuesList = []; // Clear issues list
    print("VM DISPOSED: ${this.hashCode}");
  }


}