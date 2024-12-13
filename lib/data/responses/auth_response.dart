import 'package:project_management_app/domain/models/user.dart';

class AuthResponse {
  String token;
  int expiresIn;
  User user;
  AuthResponse(this.token, this.expiresIn ,this.user,);
  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      json['token'] as String,
      json['expiresIn'],
      User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
}