import 'package:dartz/dartz.dart';
import 'package:project_management_app/data/network/failure.dart';
import 'package:project_management_app/domain/models/project.dart';
import 'package:project_management_app/domain/repository/project_repo.dart';

class AddProjectUseCase {
  final ProjectRepository _projectRepository ;

  AddProjectUseCase(this._projectRepository);

  Future<Either<Failure,Project>> addProject (Project request) async {
    return await _projectRepository.addProject(request);
  }
}

