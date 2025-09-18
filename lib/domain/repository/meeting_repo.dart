import 'package:dartz/dartz.dart';
import 'package:project_management_app/domain/models/meeting.dart';
import '../../data/network/failure.dart';
import '../../data/network/requests/add_meeting_request.dart';
abstract class MeetingRepository {
  Future<Either<Failure, Meeting>> addMeeting(AddMeetingRequest request);
  Future<Either<Failure, List<Meeting>>> getMeetings(int projectId);
  Future<Either<Failure, Meeting>> updateMeetingStatus(int meetingId , MeetingStatus status);

}