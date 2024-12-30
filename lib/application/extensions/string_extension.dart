extension StringExtensions on String? {
  bool isNullOrEmpty() {
    return this == null || this!.isEmpty;
  }

  String? isEmptyInput() {
    if (isNullOrEmpty()) return "cannot be empty";
    return null;
  }

  String? isValidEmail() {
    final expression = RegExp(
      r"""^((?:[A-Za-z0-9!#$%&\'*+\-\/=?^_`{|}~]|(?<=^|\.)"|"(?=$|\.|@)|(?<=".*)[ .](?=.*")|(?<!\.)\.){1,64})(@)((?:[A-Za-z0-9.\-])*(?:[A-Za-z0-9])\.(?:[A-Za-z0-9]){2,})$""",
      multiLine: true,
    );

    if (isNullOrEmpty() || !expression.hasMatch(this!)) {
      return "Email address is not valid!";
    }

    return null;
  }

  String? isStrongPassword() {
    final expression = RegExp(
        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*()_+])[A-Za-z\d!@#$%^&*()_+]{8,}$');

    if (isNullOrEmpty() || !expression.hasMatch(this!)) {
      return "Please enter a strong password";
    }

    return null;
  }
}
