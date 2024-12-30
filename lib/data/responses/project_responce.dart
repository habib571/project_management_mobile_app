import '../../domain/models/project.dart';

class ProjectResponse {
  List<Project> projects;

  ProjectResponse(this.projects);

  factory ProjectResponse.fromJson(Map<String, dynamic> json) {
    return ProjectResponse(
      (json['data'] as List<dynamic>)  // Assuming 'data' is the key in your response that contains the list
          .map((projectJson) => Project.fromJson(projectJson as Map<String, dynamic>))
          .toList(),
    );
  }
}