import '../../domain/models/project.dart';

class ProjectResponse{
  Project project ;

  ProjectResponse(this.project);

  factory ProjectResponse.fromJson(Map<String, dynamic> json) {
    return ProjectResponse(
      Project.fromJson(json['project'] as Map<String, dynamic>),
    );
  }
}