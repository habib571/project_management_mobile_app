

import 'package:dartz/dartz.dart';
import 'package:project_management_app/data/network/requests/pagination.dart';
import 'package:project_management_app/domain/models/task.dart';

import '../../data/network/failure.dart';

abstract class TaskRepository {
  Future<Either<Failure ,TaskModel>> addTask(TaskModel request , int projectId) ;
  Future<Either<Failure ,List<TaskModel>>> getProjectTasks(int projectId , Pagination pagination) ;
  Future<Either<Failure ,List<TaskModel>>> searchTasks(String taskName , Pagination pagination) ;

}