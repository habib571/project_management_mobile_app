import 'package:project_management_app/domain/models/project.dart';
import 'package:project_management_app/domain/models/user.dart';

class ProjectMember {
  int? id;
  Project? project;
  User? user;
  String? role;
  int? projectId;
  int? userId;

  ProjectMember(this.id, this.project, this.user, this.role);
  ProjectMember.request(this.userId, String this.role, this.projectId);

  factory ProjectMember.fromJson(Map<String, dynamic> json) {
    return ProjectMember(
      json['id'],
      Project.fromJson(json['project']),
      User.fromJson(json['user']),
      json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'project_id': projectId,
      'member_id': userId,
      'role': role,
    };
  }
}
