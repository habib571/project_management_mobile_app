import '../../../domain/models/meeting.dart';
import '../../../domain/models/project_member.dart';

class AddMeetingRequest {
 final String title ;
 final MeetingType? type ;
 final int projectId ;
 final String? startDateTime ;
 final List<int> participantsIds ;

  AddMeetingRequest( {
    required this.title,
    this.type,
    required this.projectId,
    this.startDateTime,
    required this.participantsIds,
  });
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'type': type?.toString().split('.').last,
       "projectId" :projectId ,
      'startDateTime': startDateTime,
      'participantIds': participantsIds,
    };
  }
}