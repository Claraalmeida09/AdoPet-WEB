import 'package:adopet/features/user/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    int? id,
    required String username,
    required String name,
    required String email,
    required String password,
    required String phone,
  }) : super(
          id: id,
          username: username,
          name: name,
          email: email,
          password: password,
          phone: phone,
        );

  factory UserModel.fromCache(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    };
  }

  static UserModel fromJsonModel(Map<String, dynamic> json) =>
      UserModel.fromJson(json);
}
