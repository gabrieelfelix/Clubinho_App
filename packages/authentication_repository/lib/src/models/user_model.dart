import 'package:equatable/equatable.dart';

class UsersModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final List<String> classIds;

  const UsersModel({
    required this.id,
    required this.classIds,
    required this.name,
    required this.email,
  });

  // Empty user witch represents an unauthenticaded user
  static const empty = UsersModel(name: '', email: '', classIds: [], id: '');

  //modify UsersModel parameters
  UsersModel copyWith({
    String? contact,
    String? name,
    String? email,
    String? id,
    List<String>? classIds,
  }) {
    return UsersModel(
      id: id ?? this.id,
      classIds: classIds ?? this.classIds,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  factory UsersModel.fromJson(Map<String, dynamic> json) {
    return UsersModel(
      id: "",
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      classIds: (json['classIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );
  }

  // Convenience getter to determine whether the current user is empty
  bool get isEmpty => this == UsersModel.empty;
  // Convenience getter to determine whether the current user is not empty
  bool get isNotEmpty => this != UsersModel.empty;

  @override
  List<Object?> get props => [name, email, classIds, id];
}
