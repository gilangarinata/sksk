class Validator {
  static bool emailValidation(String text) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(text);
  }

  static bool passwordValidation(String text) {
    return text.length > 5 ? true : false;
  }
}
