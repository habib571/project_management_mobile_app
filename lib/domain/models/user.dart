import 'package:project_management_app/application/constants/constants.dart';

class User {
  int id;
  String fullName;
  String email;
  String imageUrl;

  User(this.id, this.fullName, this.email,this.imageUrl);
  User.taggedUser(this.id, this.fullName, this.imageUrl):email="";

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['id'] as int,
      json['fullName'] as String,
      json['email'] as String, json['imageUrl']  ?? Constants.userProfileImageUrl
      //json['imageUrl']   ,
    );
  }

  factory User.taggedUserFromJson(Map<String, dynamic> json){
    return User.taggedUser(
      json['user_id'] ,
      json['name'] ,
      json['imageUrl']  ?? Constants.userProfileImageUrl,
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
