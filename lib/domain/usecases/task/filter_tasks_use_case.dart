import 'package:dartz/dartz.dart';
import 'package:project_management_app/data/network/requests/filter_task_request.dart';

import '../../../data/network/failure.dart';
import '../../../data/network/requests/pagination.dart';
import '../../models/task.dart';
import '../../repository/task_repo.dart';

class FilterTaskUseCase {
  final TaskRepository _taskRepository;

  FilterTaskUseCase(this._taskRepository);

  Future<Either<Failure, List<TaskModel>>> filterTasks(
      FilterTaskRequest filterTaskRequest, Pagination pagination) async =>
      await _taskRepository.filterTasks(filterTaskRequest, pagination);
}