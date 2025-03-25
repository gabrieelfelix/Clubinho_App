import 'package:authentication_repository/authentication_repository.dart';

class Utils {
  static UserRole userRoleToEnum(String role) {
    switch (role) {
      case 'teacher':
        return UserRole.teacher;
      case 'coordinator':
        return UserRole.coordinator;
      case 'admin':
        return UserRole.admin;
      default:
        return UserRole.teacher;
    }
  }

  static String userRoleToString(UserRole role) {
    switch (role) {
      case UserRole.teacher:
        return "teacher";
      case UserRole.coordinator:
        return "coordinator";
      case UserRole.admin:
        return "admin";
      default:
        return "teacher";
    }
  }
}
