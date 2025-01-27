import 'package:dartz/dartz.dart';
import 'package:project_management_app/domain/models/issue.dart';
import 'package:project_management_app/domain/usecases/project/issue/get_allissues_use_case.dart';

import '../../../../domain/usecases/project/issue/report_issue_use_case.dart';
import '../../../base/base_view_model.dart';
import '../../../stateRender/state_render.dart';
import '../../../stateRender/state_render_impl.dart';

class GetAllIssuesViewModel extends BaseViewModel{
  final GetAllIssuesUseCase _useCase ;

  GetAllIssuesViewModel(super.tokenManager, this._useCase);

  @override
  void start() {
    super.start();
    getAllProjectIssues();
  }

  List<Issue> issuesList = [];

  getAllProjectIssues() async {
    updateState(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));

    (await _useCase.getAllIssues(64)).fold(
            (failure) {
          updateState(ErrorState(StateRendererType.fullScreenErrorState, failure.message));
        },
            (data) {
          issuesList.addAll(data) ;
          updateState(ContentState());
        }
    );
  }

}