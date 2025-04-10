import 'dart:core';
extension EmailValidator on String {
  bool isEmail() {
    return  RegExp(
            r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$")
        .hasMatch(this);
  }
}
