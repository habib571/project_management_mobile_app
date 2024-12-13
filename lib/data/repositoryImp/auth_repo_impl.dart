import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:project_management_app/data/dataSource/localDataSource/auth_local_data_source.dart';
import 'package:project_management_app/data/dataSource/remoteDataSource/auth_remote_data_source.dart';
import 'package:project_management_app/data/network/error_handler.dart';

import 'package:project_management_app/data/network/failure.dart';

import 'package:project_management_app/data/network/requests.dart';
import 'package:project_management_app/data/responses/auth_response.dart';

import '../../domain/repository/auth_repo.dart';
import '../network/internet_checker.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;
  final NetworkInfo _networkInfo;

  AuthRepositoryImpl(this._authRemoteDataSource,this._authLocalDataSource, this._networkInfo);

  @override
  //on doit verifier la connexion + get the data from remotedatatsourceimpl and convert it to an object Authresponce
  Future<Either<Failure,AuthResponse>> signin(RegisterRequest registerRequest)async{
    if(await _networkInfo.isConnected){
      try{
        final responce = await _authRemoteDataSource.signin(registerRequest);
        if(responce.statusCode == 200){
          final AuthResponse _authResponce = AuthResponse.fromJson(responce.data);
          await _authLocalDataSource.saveAuthToken(_authResponce.token , _authResponce.user.createdAt ,_authResponce.expiresIn);
          var x =_authLocalDataSource.getAuthToken();
          return Right(_authResponce) ;
        }
        else {
          return left(Failure.fromJson(responce.data));
        }
      }
      catch(error){
        log(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
}
  
  
  
  Future<Either<Failure, AuthResponse>> signup(
      RegisterRequest registerRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _authRemoteDataSource.signup(registerRequest);
        if (response.statusCode == 200) {
          return Right(AuthResponse.fromJson(response.data));
        } else {
          log(response.data) ;
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
