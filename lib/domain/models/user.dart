class User {
  int id;
  String fullName;
  String email;
  DateTime createdAt;

  User(this.id, this.fullName, this.email, this.createdAt);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['id'] as int,
      json['fullName'] as String,
      json['email'] as String,
      DateTime.parse(json['createdAt'])
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
