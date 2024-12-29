
import 'package:dartz/dartz.dart';

import 'package:project_management_app/data/network/failure.dart';

import 'package:project_management_app/data/responses/project_responce.dart';

import '../../domain/repository/project_repo.dart';
import '../network/internet_checker.dart';

class ProjectRepositoryImpl implements ProjectRepository{
  final NetworkInfo _networkInfo;

  ProjectRepositoryImpl(this._networkInfo)

  @override
  Future<Either<Failure, ProjectResponce>> addProject(ProjectRepository projectRequest) async {
    if (await _networkInfo.isConnected) {}


  }

}