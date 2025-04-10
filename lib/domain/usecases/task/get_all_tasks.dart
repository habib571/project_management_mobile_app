import 'package:dartz/dartz.dart';
import 'package:project_management_app/data/dataSource/remoteDataSource/task_remote_data_source.dart';
import 'package:project_management_app/domain/repository/task_repo.dart';

import '../../../data/network/failure.dart';
import '../../../data/network/requests/pagination.dart';
import '../../models/Task/task.dart';

class GetProjectTasksUseCase {
  final TaskRepository _taskRepository;

  GetProjectTasksUseCase(this._taskRepository);

  Future<Either<Failure, List<TaskModel>>> getProjectTasks(
          int projectId, Pagination pagination) async =>
      await _taskRepository.getProjectTasks(projectId, pagination);
}
