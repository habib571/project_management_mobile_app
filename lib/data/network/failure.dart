class Failure {
  int code;
  String message;
  Failure(this.code, this.message);

  factory Failure.fromJson(Map<String, dynamic> json) {
    return Failure(
      json['code'] as int,
      json['message'] as String,
    );
  }
}
