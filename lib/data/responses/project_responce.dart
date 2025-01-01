import '../../domain/models/project.dart';

class ProjectResponse {
  List<Project> projects;

  ProjectResponse(this.projects);

  factory ProjectResponse.fromJson(List<dynamic> json) {
    return ProjectResponse(
      json.map((projectJson) => Project.fromJson(projectJson as Map<String, dynamic>)).toList(),
    );
  }
}