import 'package:dartz/dartz.dart';
import 'package:project_management_app/data/responses/project_responce.dart';
import 'package:project_management_app/domain/models/project_member.dart';
import '../../data/network/failure.dart';
import '../models/project.dart';
import '../models/user.dart';

abstract class ProjectRepository {
  Future<Either<Failure, Project>> addProject(Project projectRequest);
  Future<Either<Failure, ProjectResponse>> getMyProjects();
  Future<Either<Failure, List<ProjectMember>>> getProjectMembers(int projectId) ;
  Future<Either<Failure, List<User>>> getMemberByName(String name ,int page , int size) ;
}