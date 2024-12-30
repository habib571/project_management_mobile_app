import 'package:project_management_app/domain/models/user.dart';

class AuthResponse {
  String token;
  User user;
  AuthResponse(this.token, this.user);
  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      json['token'] as String,
      User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
}