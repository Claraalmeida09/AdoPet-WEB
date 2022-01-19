import 'package:adopet/core/utils/extensions.dart';
import 'package:adopet/features/login/domain/entities/login.dart';

class LoginModel extends Login {
  LoginModel({
    required String username,
    required String password,
  })  : assert(
          !username.isNullEmptyOrWhitespace,
        ),
        assert(
          !password.isNullEmptyOrWhitespace,
        ),
        super(
          username: username,
          password: password,
        );

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
    };
  }
}
