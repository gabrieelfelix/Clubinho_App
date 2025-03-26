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
}
