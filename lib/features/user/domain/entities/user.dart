import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    this.id,
    required this.username,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
  });

  final int? id;
  final String username;
  final String name;
  final String email;
  final String password;
  final String phone;

  @override
  List<Object?> get props => [
        username,
        email,
      ];
}
