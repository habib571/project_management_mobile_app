import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../../data/network/requests/auth_requests.dart';
import '../../data/responses/auth_response.dart';
import '../models/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthResponse>> signup(RegisterRequest loginRequest);
  Future<Either<Failure, AuthResponse>> signIn(SignInRequest loginRequest);
  Future<Either<Failure, User>> getCurrentUserInfo();

}