import 'package:flutter/material.dart';
import 'package:project_management_app/domain/usecases/task/search_task_use_case.dart';
import 'package:project_management_app/presentation/base/base_view_model.dart';

import '../../../../data/network/requests/pagination.dart';
import '../../../../domain/models/task.dart';
import '../../../stateRender/state_render.dart';
import '../../../stateRender/state_render_impl.dart';

class AllTasksViewModel extends BaseViewModel {
  AllTasksViewModel(super.tokenManager, this._searchTaskUseCase);

  final SearchTaskUseCase _searchTaskUseCase;

  int _selectedStatusIndex = -1;
  int get selectedStatusIndex => _selectedStatusIndex;

  int _selectedPriorityIndex = -1;
  int get selectedPriorityIndex => _selectedPriorityIndex;

  TextEditingController taskDeadline = TextEditingController();
  String? selectedDate;
  bool _isChecked = false;
  bool get isChecked => _isChecked;

  void setChecked(bool value) {
    _isChecked = value;
    notifyListeners();
  }

  void selectStatus(int index) {
    if (_selectedStatusIndex == index) {
      _selectedStatusIndex = -1;
    } else {
      _selectedStatusIndex = index;
    }
    notifyListeners();
  }

  void selectPriority(int index) {
    if (_selectedPriorityIndex == index) {
      _selectedPriorityIndex = -1;
    } else {
      _selectedPriorityIndex = index;
    }
    notifyListeners();
  }

  pickProjectEndDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      selectedDate = pickedDate.toString();
      taskDeadline.text =
          "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year}";
    }
  }

  final List<TaskModel> _tasks = [];
  List<TaskModel> get tasks => _tasks;

  int _currentPage = 0;
  int get currentPage => _currentPage;

  bool isLoading = false;

  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;

  bool hasMore = true;
  final int _pageSize = 5;
  String _searchQuery = "" ;
  String get searchQuery => _searchQuery ;
   setSearchQuery(String searchQuery ) {
     _searchQuery =searchQuery ;
   }

  final ValueNotifier<FlowState> _stateNotifier = ValueNotifier(ContentState());
  ValueNotifier<FlowState> get stateNotifier => _stateNotifier;

  final TextEditingController searchController = TextEditingController();
  searchTasks() async {
    _stateNotifier.value = LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState);
    //  if (_isLoadingMore || !hasMore) return;
    if (_currentPage == 0) {
      _tasks.clear();
      _currentPage = 0;
      hasMore = true;
      _stateNotifier.value = ContentState();
    }

    _isLoadingMore = true;

    (await _searchTaskUseCase.searchTasks(
            _searchQuery, Pagination(_currentPage, _pageSize)))
        .fold((failure) {
      _stateNotifier.value =
          ErrorState(StateRendererType.fullScreenErrorState, failure.message);
    }, (data) {
      _stateNotifier.value = ContentState();
      _tasks.addAll(data);
      _currentPage++;
      _isLoadingMore = false;
      if (data.length < _pageSize) {
        hasMore = false;
      }
    });
    _isLoadingMore = false;
  }
}
