
class AddMemberRequest {

  int memberId;
  int projectId;
  String role ;

  AddMemberRequest({required this.memberId,required this.projectId,required this.role});

  Map<String, dynamic> toJson() {
    return {
      'member_id': memberId,
      'project_id': projectId,
      'role': role
    };
  }
}
