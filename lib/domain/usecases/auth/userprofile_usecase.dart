
import 'package:dartz/dartz.dart';
import 'package:project_management_app/data/network/failure.dart';
import 'package:project_management_app/domain/models/user.dart';

import '../../repository/auth_repo.dart';

class UserProfileUseCase {
  final AuthRepository _repository;
  UserProfileUseCase(this._repository);

  Future<Either<Failure,User>> getCurrentUserInfo() async {
    return await _repository.getCurrentUserInfo();
  }
}

