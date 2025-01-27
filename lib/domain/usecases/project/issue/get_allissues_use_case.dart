import 'package:dartz/dartz.dart';

import '../../../../data/network/failure.dart';
import '../../../models/issue.dart';
import '../../../repository/project_repo.dart';

class GetAllIssuesUseCase {
  final ProjectRepository _projectRepository ;
  GetAllIssuesUseCase(this._projectRepository);

  Future<Either<Failure, List<Issue>>> getAllIssues (int projectId) async {
    return await _projectRepository.getAllIssues(projectId);
  }
}