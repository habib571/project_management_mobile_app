import 'package:dartz/dartz.dart';
import 'package:project_management_app/domain/models/task.dart';
import 'package:project_management_app/domain/repository/task_repo.dart';

import '../../../data/network/failure.dart';

class AddTaskUseCase {
  final TaskRepository _taskRepository ;
  AddTaskUseCase(this._taskRepository);
  Future<Either<Failure,TaskModel>> addTask(TaskModel request , int projectId) async  => _taskRepository.addTask(request ,projectId) ;

}