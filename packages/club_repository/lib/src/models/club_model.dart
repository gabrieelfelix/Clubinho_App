import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_repository/src/models/kids_model.dart';
import 'package:club_repository/src/models/teachers_model.dart';
import 'package:equatable/equatable.dart';

class ClubModel extends Equatable {
  final String id;
  final String name;
  final List<TeachersModel> teachers;
  final List<KidsModel> kids;
  final String address;

  const ClubModel({
    required this.id,
    required this.kids,
    required this.name,
    required this.teachers,
    required this.address,
  });

  // Empty user witch represents an unauthenticaded user
  static const empty =
      ClubModel(id: '', kids: [], name: '', teachers: [], address: '');

  //modify ClubModel parameters
  ClubModel copyWith(
      {String? id,
      List<KidsModel>? kids,
      String? name,
      List<TeachersModel>? teachers,
      String? address}) {
    return ClubModel(
      id: id ?? this.id,
      kids: kids ?? this.kids,
      name: name ?? this.name,
      teachers: teachers ?? this.teachers,
      address: address ?? this.address,
    );
  }

// DocumentSnapshot<Map<String, dynamic>>
  factory ClubModel.fromJson(Map<String, dynamic> json) {
    //final data = json.data()!;
    return ClubModel(
      id: "",
      // id: json.id,
      name: json['name'] ?? '',
      kids: const [],
      teachers: const [],
      // kids: (data['kids'] as List<dynamic>?)
      //         ?.map((e) => KidsModel.fromJson(Map<String, dynamic>.from(e)))
      //         .toList() ??
      //     [],
      // teachers: (data['teachers'] as List<dynamic>?)
      //         ?.map((e) => TeachersModel.fromJson(Map<String, dynamic>.from(e)))
      //         .toList() ??
      //     [],
      address: json['address'],
    );
  }

  factory ClubModel.fromJsonBasic(DocumentSnapshot<Map<String, dynamic>> json) {
    final data = json.data()!;
    return ClubModel(
      id: json.id,
      name: data['name'] ?? '',
      kids: const [],
      teachers: const [],
      address: '',
    );
  }

  // Convenience getter to determine whether the current user is empty
  bool get isEmpty => this == ClubModel.empty;
  // Convenience getter to determine whether the current user is not empty
  bool get isNotEmpty => this != ClubModel.empty;

  @override
  List<Object?> get props => [id, kids, name, teachers, address];
}
