import 'package:flutter/material.dart';
import 'package:project_management_app/data/network/requests/report_issue_request.dart';
import 'package:project_management_app/domain/models/Task/task.dart';
import 'package:project_management_app/domain/models/user.dart';
import 'package:project_management_app/presentation/base/base_view_model.dart';
import 'package:project_management_app/presentation/stateRender/state_render.dart';
import 'package:project_management_app/presentation/stateRender/state_render_impl.dart';

import '../../../../domain/models/project_member.dart';
import '../../../../domain/usecases/project/issue/report_issue_use_case.dart';
import '../../../utils/colors.dart';
import '../view/widgets/custom_chips/assigned_memberchip.dart';

class ReportIssueViewModel extends BaseViewModel{

  @override
  void start() {
    updateState(ContentState());
    super.start();
  }

  final ReportIssueUseCase _useCase ;
  ReportIssueViewModel(super.tokenManager, this._useCase);

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  GlobalKey<FormState> get formkey => _formkey;

  final TextEditingController _issueTitle = TextEditingController();
  TextEditingController get issueTitle => _issueTitle;

  final TextEditingController _issueDescription = TextEditingController();
  TextEditingController get issueDescription => _issueDescription;


  User? _taggedMember ;
  User? get taggedMember => _taggedMember ;

  bool _isUserAdded = false;
  bool get isUserAdded => _isUserAdded ;

  bool _isTaskAdded = false;
  bool get isTaskAdded => _isTaskAdded ;

  TaskModel? _taggedTask ;
  TaskModel? get taggedTask => _taggedTask ;

  void toggleIsUserAdded() {
    _isUserAdded = !_isUserAdded;
    notifyListeners();
  }

  void updatetaggedMember(User member) {
    _taggedMember = member;
  }

  void toggleIsTaskAdded() {
    _isTaskAdded = !_isTaskAdded;
    notifyListeners();
  }

  void updatetaggedTask(TaskModel task) {
    _taggedTask = task;
  }


  reportIssue()async {
    if (formkey.currentState!.validate()) {
      updateState(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
      (await _useCase.reportIssue(
          ReportIssueRequest(
              title: _issueTitle.text.trim(),
              description: _issueDescription.text.trim(),
              memberId: taggedMember?.id ??333  ,
              taskId:_taggedTask?.id,
              projectId: 64
          )
      )).fold((failure) {
        updateState(ErrorState(
            StateRendererType.fullScreenErrorState, failure.message));
      }, (data) {
        updateState(ContentState());
      });
    }
  }

}