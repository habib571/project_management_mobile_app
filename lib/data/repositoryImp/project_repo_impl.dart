
import 'dart:developer';

import 'package:dartz/dartz.dart';

import 'package:project_management_app/data/network/failure.dart';
import 'package:project_management_app/data/responses/project_responce.dart';
import 'package:project_management_app/domain/models/project_member.dart';
import 'package:project_management_app/domain/models/user.dart';
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

  @override
  Future<Either<Failure, ProjectResponse>> getMyProjects() async{

    if (await _networkInfo.isConnected) {
      try {
        final response = await _projectDataSource.getProjects() ;
        if (response.statusCode == 200) {
          return Right(ProjectResponse.fromJson(response.data));
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

  @override
  Future<Either<Failure, List<ProjectMember>>> getProjectMembers(int projectId) async{
    if (await _networkInfo.isConnected) {
      try {

        final response = await _projectDataSource.getProjectMember(projectId) ;
        if (response.statusCode == 200) {
          final List<Map<String, dynamic>> responseData = List<Map<String, dynamic>>.from(response.data);
          final members = responseData.map((projectJson) => ProjectMember.fromJson(projectJson)).toList();
          return Right(members) ;
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

  @override
  Future<Either<Failure, List<User>>> getMemberByName(String name, int page, int size) async{
    if (await _networkInfo.isConnected) {
      try {

        final response = await _projectDataSource.getMemberByName(name,page,size) ;

        if (response.statusCode == 200) {
          print("-------------20000");
          final List<Map<String, dynamic>> responseData = List<Map<String, dynamic>>.from(response.data);
          final members = responseData.map((memberJson) => User.fromJson(memberJson)).toList();
          print(members[0].fullName);
          return Right(members);
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