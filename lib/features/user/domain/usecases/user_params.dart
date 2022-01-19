import 'package:adopet/features/user/domain/entities/user.dart';
import 'package:equatable/equatable.dart';

class UserParams extends Equatable {
  const UserParams({
    required this.user,
  });
  final User user;

  @override
  List<Object?> get props => [
        user,
      ];
}
