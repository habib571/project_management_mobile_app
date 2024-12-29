import 'package:dartz/dartz.dart';
import '../../data/network/failure.dart';
import '../../data/responses/project_responce.dart';

abstract class ProjectRepository {
  Future<Either<Failure, ProjectResponce>> addProject(ProjectRepository projectRequest);
}