import 'package:dartz/dartz.dart';
import 'package:project_management_app/data/responses/project_responce.dart';

import '../../../data/network/failure.dart';
import '../../repository/project_repo.dart';

class GetMyProjectsUseCase {
  final ProjectRepository _projectRepository ;

  GetMyProjectsUseCase(this._projectRepository);

  Future<Either<Failure,ProjectResponse>> getMyProjects() async {
    return await _projectRepository.getMyProjects() ;
  }
}