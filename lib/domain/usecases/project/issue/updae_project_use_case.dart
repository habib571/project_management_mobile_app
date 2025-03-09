import 'package:dartz/dartz.dart';

import '../../../../data/network/failure.dart';
import '../../../models/project.dart';
import '../../../repository/project_repo.dart';

class UpdateProjectUseCase {
final ProjectRepository _projectRepository ;

UpdateProjectUseCase(this._projectRepository);

Future<Either<Failure,Project>> updateProject (Project request) async {
  return await _projectRepository.updateProject(request);
  }
}

