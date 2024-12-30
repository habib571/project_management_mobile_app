import 'package:dartz/dartz.dart';
import 'package:project_management_app/data/responses/project_responce.dart';
import '../../data/network/failure.dart';
import '../models/project.dart';

abstract class ProjectRepository {
  Future<Either<Failure, Project>> addProject(Project projectRequest);
  Future<Either<Failure, ProjectResponse>> getMyProjects();
}