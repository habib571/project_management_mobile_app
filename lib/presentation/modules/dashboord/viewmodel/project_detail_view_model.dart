


import 'package:flutter/material.dart';
import 'package:project_management_app/domain/models/project_member.dart';
import 'package:project_management_app/domain/models/user.dart';
import 'package:project_management_app/domain/usecases/project/get_members.dart';
import 'package:project_management_app/presentation/base/base_view_model.dart';
import '../../../../application/dependencyInjection/dependency_injection.dart';
import '../../../../domain/models/project.dart';
import '../../../stateRender/state_render.dart';
import '../../../stateRender/state_render_impl.dart';
import 'dashboard_view_model.dart';

class ProjectDetailViewModel extends BaseViewModel {
  final GetMembersUseCase _useCase;

  ProjectDetailViewModel(super.tokenManager, this._useCase);

  @override
  void start() {
    super.start();
    getProjectMembers();
  }

  final Project project = instance<DashBoardViewModel>().project;

   List<ProjectMember> _projectMember = [];
  List<ProjectMember> get projectMember => _projectMember;

  final List<User> _memberToAdd = [];
  List<User> get memberToAdd => _memberToAdd;

  int _currentPage = 0;
  int get currentPage => _currentPage;

  bool isLoading =false;

  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;

  bool hasMore = true;
  final int _pageSize = 9;

  final ValueNotifier<FlowState> _stateNotifier = ValueNotifier(ContentState());
  ValueNotifier<FlowState> get stateNotifier => _stateNotifier;

  getProjectMembers() async {
    updateState(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));

    (await _useCase.getProjectMembers(project.id!)).fold(
            (failure) {
          updateState(ErrorState(
              StateRendererType.fullScreenErrorState, failure.message));
        },
            (data) {
              _projectMember = data ;
          updateState(ContentState());
        }
    );
  }

  /*Future<void> getMemberByName(String name, {int page = 0}) async {
    if (_isLoadingMore || !hasMore) return;

    if (page == 0) {
      _memberToAdd.clear();
      _currentPage = 0;
      hasMore = true;
      _stateNotifier.value = ContentState();
    }

    _isLoadingMore = true;

    (await _useCase.getMemberByName(name, page, _pageSize)).fold(
          (failure) {
        _stateNotifier.value =ErrorState(StateRendererType.fullScreenErrorState, failure.message);
      },
          (data) {
        _isLoadingMore = false;
        if (data.length < _pageSize) {
          hasMore = false;
        }

        _memberToAdd.addAll(data);
        _currentPage = page + 1;
        _stateNotifier.value = ContentState();
      },
    );

    _isLoadingMore = false;
  }*/
}
