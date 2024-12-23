

//on doit exploiter les recources fournis par repository et returner un authobject en succes or a failure

import 'package:dartz/dartz.dart';
import 'package:project_management_app/data/network/failure.dart';
import 'package:project_management_app/data/network/requests.dart';
import 'package:project_management_app/data/responses/auth_response.dart';
import 'package:project_management_app/domain/repository/auth_repo.dart';

class SignInUseCase {
  final AuthRepository _repository;

  SignInUseCase(this._repository);

  Future<Either<Failure,AuthResponse>> SignIn(RegisterRequest request)async {
    return await _repository.signin(request);
  }
}