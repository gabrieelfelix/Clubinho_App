import 'package:authentication_repository/authentication_repository.dart';
import 'package:club_repository/src/utils/utils.dart';
import 'package:equatable/equatable.dart';

class TeachersModel extends Equatable {
  final String id;
  final String contact;
  final String name;
  final String email;
  final List<String> classIds;
  final UserRole userRole;
  final String clubIdSave;

  const TeachersModel({
    required this.id,
    required this.contact,
    required this.classIds,
    required this.name,
    required this.email,
    required this.userRole,
    required this.clubIdSave,
  });

  // Empty user witch represents an unauthenticaded user
  static const empty = TeachersModel(
    contact: '',
    name: '',
    email: '',
    classIds: [],
    id: '',
    userRole: UserRole.teacher,
    clubIdSave: '',
  );

  //modify TeachersModel parameters
  TeachersModel copyWith({
    String? contact,
    String? name,
    String? email,
    String? id,
    List<String>? classIds,
    UserRole? userRole,
    String? clubIdSave,
  }) {
    return TeachersModel(
      id: id ?? this.id,
      classIds: classIds ?? this.classIds,
      contact: contact ?? this.contact,
      name: name ?? this.name,
      email: email ?? this.email,
      userRole: userRole ?? this.userRole,
      clubIdSave: clubIdSave ?? this.clubIdSave,
    );
  }

  factory TeachersModel.fromJson(Map<String, dynamic> json) {
    // final data = json.data()!;
    return TeachersModel(
      // id: json.id,
      id: "",
      name: json['name'] ?? '',
      contact: json['contact'] ?? '',
      email: json['email'] ?? '',
      classIds: (json['classIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      userRole: Utils.userRoleToEnum(json['role'] ?? ''),
      clubIdSave: '',
    );
  }

  // Convenience getter to determine whether the current user is empty
  bool get isEmpty => this == TeachersModel.empty;
  // Convenience getter to determine whether the current user is not empty
  bool get isNotEmpty => this != TeachersModel.empty;

  @override
  List<Object?> get props =>
      [contact, name, email, classIds, id, userRole, clubIdSave];
}
