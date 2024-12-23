import 'package:dartz/dartz.dart';
import 'package:project_management_app/domain/repository/auth_repo.dart';

import '../../data/network/failure.dart';
import '../../data/network/requests/auth_requests.dart';
import '../../data/responses/auth_response.dart';

class SignupUseCase {
  final AuthRepository _repository;
  SignupUseCase(this._repository);
  Future<Either<Failure, AuthResponse>> signup(RegisterRequest request) async =>
      await _repository.signup(request);
}
