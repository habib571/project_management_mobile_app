import 'package:dartz/dartz.dart';

import '../../../data/network/failure.dart';
import '../../../data/network/requests/pagination.dart';
import '../../models/Task/task.dart';
import '../../repository/task_repo.dart';

class SearchTaskUseCase {
  final TaskRepository _taskRepository;

  SearchTaskUseCase(this._taskRepository);

  Future<Either<Failure, List<TaskModel>>> searchTasks(
      String taskName, Pagination pagination) async =>
      await _taskRepository.searchTasks(taskName, pagination);
}
