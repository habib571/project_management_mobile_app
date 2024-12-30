import 'package:dartz/dartz.dart';
import '../../data/network/failure.dart';
import '../models/project.dart';

abstract class ProjectRepository {
  Future<Either<Failure, Project>> addProject(Project projectRequest);
}