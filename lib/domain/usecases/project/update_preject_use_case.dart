import 'package:dartz/dartz.dart';
import 'package:project_management_app/domain/models/project.dart';

import '../../../data/network/failure.dart';
import '../../repository/project_repo.dart';

class UpdateProjectUseCase {
  final ProjectRepository _projectRepository ;

  UpdateProjectUseCase(this._projectRepository);

  Future<Either<Failure, Project>> updateProject (Project projectRequest) async {
    return await _projectRepository.updateProject(projectRequest)   ;
  }

}