
import 'dart:developer';

import 'package:dartz/dartz.dart';

import 'package:project_management_app/data/network/failure.dart';
import '../../domain/models/project.dart';
import '../../domain/repository/project_repo.dart';
import '../dataSource/remoteDataSource/project_data_source.dart';
import '../network/error_handler.dart';
import '../network/internet_checker.dart';

class ProjectRepositoryImpl implements ProjectRepository{
  final NetworkInfo _networkInfo;
  final ProjectDataSource _projectDataSource ;

  ProjectRepositoryImpl(this._networkInfo,this._projectDataSource);

  @override
  Future<Either<Failure, Project>> addProject (Project projectRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _projectDataSource.addProject(projectRequest) ;
        if (response.statusCode == 200) {
          return Right(Project.fromJson(response.data));
        } else {
          log(response.data) ;
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