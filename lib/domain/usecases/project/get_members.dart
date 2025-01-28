import 'package:dartz/dartz.dart';
import 'package:project_management_app/domain/models/project_member.dart';

import '../../../data/network/failure.dart';
import '../../models/user.dart';
import '../../repository/project_repo.dart';

class GetMembersUseCase {
  final ProjectRepository _projectRepository ;

  GetMembersUseCase(this._projectRepository);

  Future<Either<Failure,List<ProjectMember>>> getProjectMembers(int projectId) async {
    return await _projectRepository.getProjectMembers(projectId) ;
  }
  Future<Either<Failure, List<User>>> getMemberByName(String name, int page, int size) async {
    return await _projectRepository.getMemberByName(name,page,size) ;
  }
}