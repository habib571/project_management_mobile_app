import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:project_management_app/data/dataSource/remoteDataSource/auth_remote_data_source.dart';
import 'package:project_management_app/data/network/error_handler.dart';

import 'package:project_management_app/data/network/failure.dart';

import 'package:project_management_app/data/network/requests/auth_requests.dart';
import 'package:project_management_app/data/responses/api_response.dart';

import 'package:project_management_app/data/responses/auth_response.dart';
import 'package:project_management_app/domain/models/user.dart';

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
        log(error.toString()) ;
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
  }

  @override
  Future<Either<Failure, AuthResponse>> signIn( SignInRequest signInRequest) async{
    if (await _networkInfo.isConnected) {
      try {
        final response = await _authRemoteDataSource.sigIn(signInRequest) ;
        if (response.statusCode == 200) {
          return Right(AuthResponse.fromJson(response.data));
        } else {
          return Left(Failure.fromJson(response.data));
        }
      } catch (error) {
        log(error.toString()) ;
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
  }

  @override
  Future<Either<Failure,User>> getCurrentUserInfo()async{
    if(await _networkInfo.isConnected){
      try{
        final response = await _authRemoteDataSource.getCurrentUserInfo();
        if(response.statusCode == 200){
          return Right(User.fromJson(response.data));
        }
        else {
          return Left(Failure.fromJson(response.data));
        }
      }
      catch (error){
        log(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
  }

  @override
  Future<Either<Failure, bool>> logOut() async{
    if (await _networkInfo.isConnected) {
      try {
        final response = await _authRemoteDataSource.logOut() ;
        print("LOGOUT ${response.statusCode}");
        if (response.statusCode == 200) {
          return const Right(true);
        } else {

          return Left(Failure.fromJson(response.data));
        }
      } catch (error) {
        log(error.toString()) ;
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
  }

}
