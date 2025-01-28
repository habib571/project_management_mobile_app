import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:project_management_app/data/dataSource/remoteDataSource/task_remote_data_source.dart';
import 'package:project_management_app/data/network/failure.dart';
import 'package:project_management_app/domain/models/task.dart';
import 'package:project_management_app/domain/repository/task_repo.dart';

import '../network/error_handler.dart';
import '../network/internet_checker.dart';

class TaskRepositoryImpl implements TaskRepository {
  final NetworkInfo _networkInfo;
   final TaskRemoteDataSource _taskRemoteDataSource ;

  TaskRepositoryImpl(this._networkInfo, this._taskRemoteDataSource);

  @override
  Future<Either<Failure, TaskModel>> addTask(TaskModel request , int projectId) async{
    if (await _networkInfo.isConnected) {
      try {
        final response = await _taskRemoteDataSource.addTask(request ,projectId) ;
        if (response.statusCode == 200) {
          return Right(TaskModel.fromJson(response.data)) ;
        } else {
          return Left(Failure.fromJson(response.data));
        }
      }
      catch (error) {
        log(error.toString()) ;
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
  }
}