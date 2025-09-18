import 'package:project_management_app/domain/models/project_member.dart';

class Meeting {
  int? id ;
  String? title ;
  MeetingType? type ;
  MeetingStatus? status ;
  String? startDateTime ;
  List<ProjectMember>? participants ;
  Meeting({
    this.id,
    this.title,
    this.type,
    this.status,
    this.startDateTime,
    this.participants,
  });

  factory Meeting.fromJson(Map<String, dynamic> json) {
    return Meeting(
      id: json['id'] ,
      title: json['title'] ,
      type: json['type'] != null
          ? MeetingType.values.firstWhere(
            (e) => e.toString().split('.').last == json['type'],
        orElse: () => MeetingType.values.first,
      )
          : null,
      status: json['status'] != null
          ? MeetingStatus.values.firstWhere(
            (e) => e.toString().split('.').last == json['status'],
        orElse: () => MeetingStatus.values.first,
      )
          : null,
      startDateTime: json['startDateTime'],
      participants: (json['participants'] as List<dynamic>?)
          ?.map((e) => ProjectMember.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
enum MeetingType {
  INSTANT,
  SCHEDULED,
  RECURRING
}
enum MeetingStatus {
  CREATED,
  ONGOING,
  ENDED
}