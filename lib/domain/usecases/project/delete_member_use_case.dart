import 'package:dartz/dartz.dart';
import 'package:project_management_app/data/network/failure.dart';
import 'package:project_management_app/domain/repository/project_repo.dart';

class DeleteMemberUseCase {
  final ProjectRepository _projectRepository;
  DeleteMemberUseCase(this._projectRepository);
  Future<Either<Failure,String>> deleteMemberUseCase(int memberId) async {
    return await _projectRepository.deleteMember(memberId);
  }
}