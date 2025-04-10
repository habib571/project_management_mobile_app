import 'package:dartz/dartz.dart';
import 'package:project_management_app/data/network/failure.dart';
import 'package:project_management_app/domain/models/project.dart';
import 'package:project_management_app/domain/repository/project_repo.dart';

class ManageProjectUseCase {
  final ProjectRepository _projectRepository ;

  ManageProjectUseCase(this._projectRepository);

  Future<Either<Failure,Project>> addProject (Project request) async {
    return await _projectRepository.addProject(request);
  }

  Future<Either<Failure, Project>> updateProject (Project projectRequest) async {
    return await _projectRepository.updateProject(projectRequest)   ;
  }

}

