import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project_management_app/data/network/requests/filter_task_request.dart';
import 'package:project_management_app/domain/usecases/task/filter_tasks_use_case.dart';
import 'package:project_management_app/domain/usecases/task/search_task_use_case.dart';
import 'package:project_management_app/presentation/base/base_view_model.dart';
import 'package:project_management_app/presentation/modules/tasks/viewmodel/prject_tasks_view_model.dart';

import '../../../../data/network/requests/pagination.dart';
import '../../../../domain/models/Task/task.dart';
import '../../../stateRender/state_render.dart';
import '../../../stateRender/state_render_impl.dart';

class AllTasksViewModel extends BaseViewModel {
  AllTasksViewModel(
      super.tokenManager, this._searchTaskUseCase, this._filterTaskUseCase, this.projectTasksViewModel);

  final SearchTaskUseCase _searchTaskUseCase;
  final FilterTaskUseCase _filterTaskUseCase;
  final ProjectTasksViewModel projectTasksViewModel;

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

  void selectStatus(int index, String value) {
    if (_selectedStatusIndex == index) {
      _selectedStatusIndex = -1;
    } else {
      _selectedStatusIndex = index;
    }
    status = value;
    notifyListeners();
  }

  void selectPriority(int index, String value) {
    if (_selectedPriorityIndex == index) {
      _selectedPriorityIndex = -1;
    } else {
      _selectedPriorityIndex = index;
    }
    priority = value;
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
      selectedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
      taskDeadline.text = selectedDate!;
      deadline = selectedDate;

      print(deadline);
    }
  }

  String? status;
  String? priority;
  String? deadline;
  FilterTaskRequest? _filterTaskRequest;
  FilterTaskRequest get filterTaskRequest => _filterTaskRequest!;

  setFilterTaskRequest(FilterTaskRequest filterTaskRequest) {
    _filterTaskRequest = filterTaskRequest;
  }

  final List<TaskModel> _tasks = [];
  List<TaskModel> get tasks => _tasks;

  int _currentPage = 0;
  int get currentPage => _currentPage;

  bool isLoading = false;

  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;

  bool hasMore = true;
  final int _pageSize = 4;
  String _searchQuery = "";
  String get searchQuery => _searchQuery;

  setSearchQuery(String searchQuery) {
    _searchQuery = searchQuery;
  }

  final ValueNotifier<FlowState> _stateNotifier = ValueNotifier(ContentState());
  ValueNotifier<FlowState> get stateNotifier => _stateNotifier;

  final TextEditingController searchController = TextEditingController();
  searchTasks() async {
    print("-------1------- ${_tasks.length} ----------");
    _stateNotifier.value = LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState);
    //   if (_isLoadingMore || !hasMore) return;
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
      _stateNotifier.value = ErrorState(StateRendererType.fullScreenErrorState, failure.message);
    }, (data) {
      _stateNotifier.value = ContentState();
      _tasks.addAll(data);
      print("-------2------- ${_tasks.length} ----------");

      // _currentPage++;
      _isLoadingMore = false;
      if (data.length < _pageSize) {
        hasMore = false;
      }
      if (_searchQuery.isEmpty) {
        _tasks.clear();
      }
    });
    _isLoadingMore = false;
  }

  Future<void> filterTasks() async {
    // For first page load, clear current tasks and reset pagination.
    if (_currentPage == 0) {
      _tasks.clear();
      _currentPage = 0;
      hasMore = true;
      _stateNotifier.value = ContentState();
    }
    _isLoadingMore = true;


    final result = await _filterTaskUseCase.filterTasks(
      FilterTaskRequest(false, status, priority, deadline),
      Pagination(_currentPage, _pageSize),
    );

    result.fold(
      (failure) {
        _stateNotifier.value =
            ErrorState(StateRendererType.fullScreenErrorState, failure.message);
      },
      (data) {
        _tasks.addAll(data);
        log(data.toString());
        notifyListeners();
        _currentPage++;
        if (data.length < _pageSize) {
          hasMore = false;
        }
      },
    );

    _isLoadingMore = false;
    // Update state to reflect new content
    _stateNotifier.value = ContentState();
  }
}
