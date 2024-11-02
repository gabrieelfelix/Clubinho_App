import 'package:equatable/equatable.dart';

class TeachersModel extends Equatable {
  final String id;
  final String email;
  final String name;
  final String adm;
  final String phone;
  const TeachersModel({
    required this.id,
    required this.email,
    required this.name,
    required this.adm,
    required this.phone,
  });

  // Empty user witch represents an unauthenticaded user
  static const empty =
      TeachersModel(id: '', email: '', name: '', adm: '', phone: '');

  //modify TeachersModel parameters
  TeachersModel copyWith(
      {String? id, String? email, String? name, String? adm, String? phone}) {
    return TeachersModel(
        id: id ?? this.id,
        email: email ?? this.email,
        name: name ?? this.name,
        adm: adm ?? this.adm,
        phone: phone ?? this.phone);
  }

  factory TeachersModel.fromJson(Map<String, dynamic> json) {
    return TeachersModel(
      id: json['user_id'] ?? '',
      name: json['username'] ?? '',
      email: json['login'] ?? '',
      adm: json['role'] ?? '',
      phone: json['role'],
    );
  }

  // Convenience getter to determine whether the current user is empty
  bool get isEmpty => this == TeachersModel.empty;
  // Convenience getter to determine whether the current user is not empty
  bool get isNotEmpty => this != TeachersModel.empty;

  @override
  List<Object?> get props => [id, email, name, adm];
}
