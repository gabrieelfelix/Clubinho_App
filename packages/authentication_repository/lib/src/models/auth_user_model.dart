class AuthUserModel {
  final String userId;

  AuthUserModel({required this.userId});

  AuthUserModel copyWith({String? userId}) => AuthUserModel(userId: userId!);
}
