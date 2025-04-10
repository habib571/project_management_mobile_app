
import 'package:dartz/dartz.dart';

import '../../../data/network/failure.dart';
import '../../../data/network/requests/add_member_request.dart';
import '../../models/project_member.dart';
import '../../repository/project_repo.dart';

class ManageMembersUseCase {
  final ProjectRepository _projectRepository ;

  ManageMembersUseCase(this._projectRepository);

  Future<Either<Failure, ProjectMember>> addMember (ProjectMember addMemberRequest) async {
    return await _projectRepository.addMember(addMemberRequest);
  }

  Future<Either<Failure, ProjectMember>> updateMemberRole (ProjectMember updateMemberRoleRequest) async {
    return await _projectRepository.updateMemberRole(updateMemberRoleRequest);
  }

}

