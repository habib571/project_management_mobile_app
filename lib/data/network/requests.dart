class RegisterRequest {
  String? fullName;
  String email;
  String password;

  RegisterRequest({
    required this.email,
    this.fullName,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    if (fullName!= null && fullName!.isNotEmpty){
      return {
        'fullName': fullName,
        'email': email,
        'password': password,
      };
    }

    return  {
      'email': email,
      'password': password,
    };

  }
}
