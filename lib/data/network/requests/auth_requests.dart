class RegisterRequest {
  String fullName;
  String email;
  String password;

  RegisterRequest({
    required this.email,
    required this.fullName,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'password': password,
    };
  }
}

class SignInRequest {

  String email;
  String password;

  SignInRequest({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}

