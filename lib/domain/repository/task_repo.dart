

import 'package:dartz/dartz.dart';
import 'package:project_management_app/domain/models/task.dart';

import '../../data/network/failure.dart';

abstract class TaskRepository {
  Future<Either<Failure ,Task>> addTask(Task request) ;

}