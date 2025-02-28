
import 'package:dartz/dartz.dart';

import '../../../data/network/failure.dart';
import '../../models/project_member.dart';
import '../../repository/project_repo.dart';

class UpdateMemberRoleUseCase {
  final ProjectRepository _projectRepository ;

  UpdateMemberRoleUseCase(this._projectRepository);

  Future<Either<Failure, ProjectMember>> updateMemberRole (ProjectMember updateMemberRoleRequest) async {
    return await _projectRepository.updateMemberRole(updateMemberRoleRequest);
  }

}

