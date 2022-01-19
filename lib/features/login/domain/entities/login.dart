import 'package:equatable/equatable.dart';

class Login extends Equatable {
  const Login({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;

  @override
  List<Object?> get props => [
        username,
      ];
}
