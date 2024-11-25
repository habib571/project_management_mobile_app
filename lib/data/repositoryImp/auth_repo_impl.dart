import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:project_management_app/data/dataSource/remoteDataSource/auth_remote_data_source.dart';
import 'package:project_management_app/data/network/error_handler.dart';

import 'package:project_management_app/data/network/failure.dart';

import 'package:project_management_app/data/network/requests.dart';
import 'package:project_management_app/data/responses/api_response.dart';

import 'package:project_management_app/data/responses/auth_response.dart';

import '../../domain/repository/auth_repo.dart';
import '../network/internet_checker.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final NetworkInfo _networkInfo;

  AuthRepositoryImpl(this._authRemoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, AuthResponse>> signup(
      RegisterRequest registerRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _authRemoteDataSource.signup(registerRequest);
        if (response.statusCode == 200) {
          return Right(AuthResponse.fromJson(response.data));
        } else {
          return Left(Failure.fromJson(response.data));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
  }
}
