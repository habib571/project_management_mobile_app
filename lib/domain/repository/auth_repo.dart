
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/network/failure.dart';
import '../../data/network/requests/auth_requests.dart';
import '../../data/responses/auth_response.dart';
import '../models/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthResponse>> signup(RegisterRequest loginRequest);
  Future<Either<Failure, AuthResponse>> signIn(SignInRequest loginRequest);
  Future<Either<Failure, User>> getCurrentUserInfo();
  Future<Either<Failure, bool>> logOut();
  Future<Either<Failure,User>> updateProfileImage(XFile image);

}