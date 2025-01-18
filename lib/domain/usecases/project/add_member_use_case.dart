
import 'package:dartz/dartz.dart';

import '../../../data/network/failure.dart';
import '../../../data/network/requests/add_member_request.dart';
import '../../models/project_member.dart';
import '../../repository/project_repo.dart';

class AddMemberUseCase {
  final ProjectRepository _projectRepository ;

  AddMemberUseCase(this._projectRepository);

  Future<Either<Failure, ProjectMember>> addMember (AddMemberRequest addMemberRequest) async {
    return await _projectRepository.addMember(addMemberRequest);
  }

}

