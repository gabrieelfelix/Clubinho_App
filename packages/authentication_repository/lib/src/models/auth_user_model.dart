enum UserRole {
  teacher,
  coordinator,
  admin,
}

class AuthUserModel {
  final String userId;
  final UserRole userRole;

  AuthUserModel({required this.userId, required this.userRole});

  AuthUserModel copyWith({
    String? userId,
    UserRole? userRole,
  }) =>
      AuthUserModel(
        userId: userId!,
        userRole: userRole!,
      );
}
