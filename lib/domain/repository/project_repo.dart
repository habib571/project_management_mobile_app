import 'package:dartz/dartz.dart';
import '../../data/network/failure.dart';
import '../../data/responses/project_responce.dart';
import '../models/project.dart';

abstract class ProjectRepository {
  Future<Either<Failure, ProjectResponse>> addProject(Project projectRequest);
}