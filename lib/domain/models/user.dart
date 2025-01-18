import 'package:project_management_app/application/constants/constants.dart';

class User {
  int id;
  String fullName;
  String email;
  String imageUrl;

  User(this.id, this.fullName, this.email,this.imageUrl);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['id'] as int,
      json['fullName'] as String,
      json['email'] as String,
      Constants.userProfileImageUrl
      //json['imageUrl'] as String  ,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'imageUrl': imageUrl,
    };
  }
}
