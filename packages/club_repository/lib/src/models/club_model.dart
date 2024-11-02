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

  // ver como iterar kids e teachers
  factory ClubModel.fromJson(Map<String, dynamic> json) {
    return ClubModel(
        id: json['user_id'] ?? '',
        name: json['username'] ?? '',
        kids: json['login'] ?? '',
        teachers: json['role'] ?? '');
  }

  // Convenience getter to determine whether the current user is empty
  bool get isEmpty => this == ClubModel.empty;
  // Convenience getter to determine whether the current user is not empty
  bool get isNotEmpty => this != ClubModel.empty;

  @override
  List<Object?> get props => [id, kids, name, teachers];
}
