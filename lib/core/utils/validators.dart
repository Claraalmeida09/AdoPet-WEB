import 'package:adopet/core/values/texts_adopet.dart';

class Validators {
  static String? genericValidator(String? value) {
    if (value != null && value.isEmpty) {
      return TextsAdoPet.cantBeEmpty;
    }

    return null;
  }

  static String? usernameValidator(String? username) {
    if (username != null && username.isEmpty) {
      return TextsAdoPet.requiredUsename;
    }
    if (username != null && username.length < 3) {
      return TextsAdoPet.enterValidUsername;
    }
    return null;
  }

  static String? passwordValidator(String? password) {
    if (password != null && password.isEmpty) {
      return TextsAdoPet.requiredPassword;
    }
    if (password != null && password.length < 6) {
      return TextsAdoPet.enterValidPassword;
    }
    return null;
  }
}
