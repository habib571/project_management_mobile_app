import 'package:dartz/dartz.dart';
import 'package:project_management_app/domain/models/Task/task.dart';
import 'package:project_management_app/domain/repository/task_repo.dart';

import '../../../data/network/failure.dart';

class ManageTaskUseCase {
  final TaskRepository _taskRepository ;
  ManageTaskUseCase(this._taskRepository);
  Future<Either<Failure,TaskModel>> addTask(TaskModel request , int projectId) async  => _taskRepository.addTask(request ,projectId) ;
  Future<Either<Failure,TaskModel>> updateTask(TaskModel request , int taskId) async  => _taskRepository.updateTask(request ,taskId) ;

}