import '../../../application/functions/cruds_functions.dart';
import '../../../application/helpers/get_storage.dart';
import '../../../domain/models/meeting.dart';
import '../../network/requests/add_meeting_request.dart';
import '../../responses/api_response.dart';

abstract class MeetingRemoteDataSource {
  Future<ApiResponse> addMeeting(AddMeetingRequest request) ;
  Future<ApiResponse> getMeetings(int projectId) ;
  Future<ApiResponse> updateMeetingStatus(int meetingId , MeetingStatus status) ;

}
class MeetingRemoteDataSourceImpl implements MeetingRemoteDataSource{
  final LocalStorage _localStorage ;
  MeetingRemoteDataSourceImpl(this._localStorage);
  @override
  Future<ApiResponse> addMeeting(AddMeetingRequest request) async{
    return await executePostRequest(
        apiUrl: "/meeting/",
        bearerToken: _localStorage.getAuthToken() ,
        body: request.toJson(),
        onRequestResponse: (response, statusCode) {
          return ApiResponse(response, statusCode);
        });
  }
  @override
  Future<ApiResponse> getMeetings(int projectId) async{
    return await executeGetRequest(
        apiUrl: "/meeting/all/$projectId",
        bearerToken:  _localStorage.getAuthToken() ,
        onRequestResponse: (response, statusCode) {
          return ApiResponse(response ,statusCode);
        });

  }
  @override
  Future<ApiResponse> updateMeetingStatus(int meetingId , MeetingStatus status)async {
    return await executePatchRequest(
        apiUrl: "/meeting/update-status/$meetingId",
        body: {
          "status" : status.toString() ,
        },
        bearerToken: _localStorage.getAuthToken(),
        onRequestResponse: (response, statusCode) {
          return ApiResponse(response, statusCode);
        });

  }

}