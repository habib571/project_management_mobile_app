import 'package:dartz/dartz.dart';
import 'package:project_management_app/domain/models/project_member.dart';

import '../../../data/network/failure.dart';
import '../../repository/project_repo.dart';

class GetMembersUseCase {
  final ProjectRepository _projectRepository ;

  GetMembersUseCase(this._projectRepository);

  Future<Either<Failure,List<ProjectMember>>> getMyProjects(int projectId) async {
    return await _projectRepository.getProjectMembers(projectId) ;
  }
}