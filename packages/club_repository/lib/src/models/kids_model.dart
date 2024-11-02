import 'package:equatable/equatable.dart';

class KidsModel extends Equatable {
  final String id;
  final String email;
  final String name;
  final String? adm;
  const KidsModel(
      {required this.id, required this.email, required this.name, this.adm});

  // Empty user witch represents an unauthenticaded user
  static const empty = KidsModel(id: '', email: '', name: '', adm: '');

  //modify KidsModel parameters
  KidsModel copyWith({String? id, String? email, String? name, String? adm}) {
    return KidsModel(
        id: id ?? this.id,
        email: email ?? this.email,
        name: name ?? this.name,
        adm: adm ?? this.adm);
  }

  factory KidsModel.fromJson(Map<String, dynamic> json) {
    return KidsModel(
        id: json['user_id'] ?? '',
        name: json['username'] ?? '',
        email: json['login'] ?? '',
        adm: json['role'] ?? '');
  }

  // Convenience getter to determine whether the current user is empty
  bool get isEmpty => this == KidsModel.empty;
  // Convenience getter to determine whether the current user is not empty
  bool get isNotEmpty => this != KidsModel.empty;

  @override
  List<Object?> get props => [id, email, name, adm];
}
