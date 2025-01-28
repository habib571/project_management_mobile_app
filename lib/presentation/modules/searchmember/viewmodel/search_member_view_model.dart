import 'package:flutter/material.dart';
import 'package:project_management_app/presentation/base/base_view_model.dart';

import '../../../../domain/models/user.dart';
import '../../../../domain/usecases/project/get_members.dart';
import '../../../stateRender/state_render.dart';
import '../../../stateRender/state_render_impl.dart';

class SearchViewModel extends BaseViewModel{
  SearchViewModel(super.tokenManager, this._useCase);

  final GetMembersUseCase _useCase;

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



  Future<void> getMemberByName(String name, {int page = 0}) async {
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
  }

}