class User {
  int id;
  String fullName;
  String email;

  User(this.id, this.fullName, this.email);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['id'] as int,
      json['fullName'] as String,
      json['email'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
    };
  }
}
