import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:project_management_app/data/dataSource/remoteDataSource/meeting_remote_data_source.dart';

import 'package:project_management_app/data/network/failure.dart';

import 'package:project_management_app/data/network/requests/add_meeting_request.dart';

import 'package:project_management_app/domain/models/meeting.dart';

import '../../domain/repository/meeting_repo.dart';
import '../network/error_handler.dart';
import '../network/internet_checker.dart';

class MeetingRepoImpl implements MeetingRepository {
  final MeetingRemoteDataSource _meetingRemoteDataSource;
  final NetworkInfo _networkInfo;

  MeetingRepoImpl(this._meetingRemoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, Meeting>> addMeeting(AddMeetingRequest request) async{
    if (await _networkInfo.isConnected) {
      try {
        final response = await _meetingRemoteDataSource.addMeeting(request);
        if (response.statusCode == 200) {
          return Right(Meeting.fromJson(response.data));
        } else {

          return Left(Failure.fromJson(response.data));
        }
      }
      catch (error) {
        log(error.toString()) ;
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
  }

  @override
  Future<Either<Failure, List<Meeting>>> getMeetings(int projectId) async{
    if (await _networkInfo.isConnected) {
      try {
        final response = await _meetingRemoteDataSource.getMeetings(projectId);

        if (response.statusCode == 200) {
          final List<Map<String, dynamic>> responseData = List<Map<String, dynamic>>.from(response.data);
          final tasks = responseData.map((memberJson) => Meeting.fromJson(memberJson)).toList();
          return Right(tasks);
        } else {
          return Left(Failure.fromJson(response.data));
        }
      }
      catch (error) {
        log(error.toString()) ;
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.NO_INTERNET_CONNECTION.getFailure()) ;
  }

  @override
  Future<Either<Failure, Meeting>> updateMeetingStatus(int meetingId, MeetingStatus status) async{
    if (await _networkInfo.isConnected) {
      try {
        final response = await _meetingRemoteDataSource.updateMeetingStatus(meetingId, status);
        if (response.statusCode == 200) {
          return Right(Meeting.fromJson(response.data));
        } else {

          return Left(Failure.fromJson(response.data));
        }
      }
      catch (error) {
        log(error.toString()) ;
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
  }

}