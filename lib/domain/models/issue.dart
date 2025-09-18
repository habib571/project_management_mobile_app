import 'package:project_management_app/domain/models/Task/task.dart';
import 'package:project_management_app/domain/models/user.dart';

class Issue {
  final int issueId;
  final String issueTitle;
  final String issueDescription;
  final User? taggedUser;
  final TaskModel? taggedTask;
  bool isSolved;

  Issue({
    required this.issueId,
    required this.issueTitle,
    required this.issueDescription,
    this.taggedUser,
    this.taggedTask,
    required this.isSolved,
  });

  factory Issue.fromJson(Map<String, dynamic> json) {
    return Issue(
      issueId: json["id"] ,
      issueTitle: json["name"] ,
      issueDescription: json["description"] ,
      taggedUser: json["tagedUserDto"] != null ? User.taggedUserFromJson(json["tagedUserDto"]) : null,
      taggedTask: json["tagedTaskDto"] != null ? TaskModel.fromJson(json["tagedTaskDto"]) : null,
      isSolved: json["solved"] as bool,
    );
  }

  Issue copyWith({
    int? issueId,
    String? issueTitle,
    String? issueDescription,
    User? taggedUser,
    TaskModel? taggedTask,
    bool? isSolved,
    // ... other properties
  }) {
    return Issue(
      issueId: issueId ?? this.issueId,
      issueTitle: issueTitle ?? this.issueTitle,
      issueDescription: issueDescription ?? this.issueDescription,
      taggedUser : taggedUser ?? this.taggedUser,
      taggedTask : taggedTask ?? this.taggedTask,
      isSolved: isSolved ?? this.isSolved,
      // ... copy other properties
    );
  }

}
