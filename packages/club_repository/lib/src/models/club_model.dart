import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_repository/src/models/kids_model.dart';
import 'package:club_repository/src/models/teachers_model.dart';
import 'package:equatable/equatable.dart';

class ClubModel extends Equatable {
  final String id;
  final String name;
  final List<TeachersModel> teachers;
  final List<KidsModel> kids;

  const ClubModel({
    required this.id,
    required this.kids,
    required this.name,
    required this.teachers,
  });

  // Empty user witch represents an unauthenticaded user
  static const empty = ClubModel(id: '', kids: [], name: '', teachers: []);

  //modify ClubModel parameters
  ClubModel copyWith(
      {String? id,
      List<KidsModel>? kids,
      String? name,
      List<TeachersModel>? teachers}) {
    return ClubModel(
      id: id ?? this.id,
      kids: kids ?? this.kids,
      name: name ?? this.name,
      teachers: teachers ?? this.teachers,
    );
  }

  factory ClubModel.fromJson(DocumentSnapshot<Map<String, dynamic>> json) {
    final data = json.data()!;
    return ClubModel(
      id: json.id,
      name: data['name'] ?? '',
      kids: (data['kids'] as List<dynamic>?)
              ?.map((e) => KidsModel.fromJson(
                  e as DocumentSnapshot<Map<String, dynamic>>))
              .toList() ??
          [],
      teachers: (data['teachers'] as List<dynamic>?)
              ?.map((e) => TeachersModel.fromJson(
                  e as DocumentSnapshot<Map<String, dynamic>>))
              .toList() ??
          [],
    );
  }

  factory ClubModel.fromJsonBasic(DocumentSnapshot<Map<String, dynamic>> json) {
    final data = json.data()!;
    return ClubModel(
      id: json.id,
      name: data['name'] ?? '',
      kids: const [],
      teachers: const [],
    );
  }

  // Convenience getter to determine whether the current user is empty
  bool get isEmpty => this == ClubModel.empty;
  // Convenience getter to determine whether the current user is not empty
  bool get isNotEmpty => this != ClubModel.empty;

  @override
  List<Object?> get props => [id, kids, name, teachers];
}
