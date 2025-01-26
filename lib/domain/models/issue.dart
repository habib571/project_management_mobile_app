import 'package:project_management_app/domain/models/task.dart';
import 'package:project_management_app/domain/models/user.dart';

class Issue {
  final int issueId;
  final String issueTitle;
  final String issueDescription;
  final TagedUser? taggedUser;
  final TaskModel? taggedTask;
  final bool isSolved;

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
      taggedUser: json["tagedUserDto"] != null ? TagedUser.fromJson(json["tagedUserDto"]) : null,
      taggedTask: json["tagedTaskDto"] != null ? TaskModel.fromJson(json["tagedTaskDto"]) : null,
      isSolved: json["solved"] as bool,
    );
  }
}




class TagedUser {
  final int userId;
  final String? name;
  final String? imageUrl;

  TagedUser({
    required this.userId,
    this.name,
    this.imageUrl,
  });

  factory TagedUser.fromJson(Map<String, dynamic> json) {
    return TagedUser(
      userId: json['user_id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'name': name,
      'imageUrl': imageUrl,
    };
  }
}
