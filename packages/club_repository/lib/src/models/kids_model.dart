import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class KidsModel extends Equatable {
  final String id;
  final String age;
  final String fullName;
  final String address;
  final String birthDate;
  final String contactNumber;
  final String fatherName;
  final String motherName;
  final String notes;

  const KidsModel({
    required this.id,
    required this.age,
    required this.fullName,
    required this.birthDate,
    required this.address,
    required this.contactNumber,
    required this.fatherName,
    required this.motherName,
    required this.notes,
  });

  /// Empty user witch represents an unauthenticaded user
  static const empty = KidsModel(
    id: '',
    address: '',
    age: '',
    birthDate: '',
    contactNumber: '',
    fatherName: '',
    fullName: '',
    motherName: '',
    notes: '',
  );

  ///modify KidsModel parameters
  KidsModel copyWith({
    String? age,
    String? fullName,
    String? address,
    String? birthDate,
    String? contactNumber,
    String? fatherName,
    String? motherName,
    String? notes,
    String? id,
  }) {
    return KidsModel(
      id: id ?? this.id,
      address: address ?? this.address,
      birthDate: birthDate ?? this.birthDate,
      contactNumber: contactNumber ?? this.contactNumber,
      fatherName: fatherName ?? this.fatherName,
      fullName: fullName ?? this.fullName,
      motherName: motherName ?? this.motherName,
      notes: notes ?? this.notes,
      age: age ?? this.age,
    );
  }

  factory KidsModel.fromJson(DocumentSnapshot<Map<String, dynamic>> json) {
    final data = json.data()!;
    return KidsModel(
      id: json.id,
      fullName: data['fullName'] ?? '',
      age: data['age'] ?? '',
      birthDate: data['birthDate'] ?? '',
      address: data['address'],
      contactNumber: data['contactNumber'],
      fatherName: data['fatherName'],
      motherName: data['motherName'],
      notes: data['notes'],
    );
  }

  /// Convenience getter to determine whether the current user is empty
  bool get isEmpty => this == KidsModel.empty;

  /// Convenience getter to determine whether the current user is not empty
  bool get isNotEmpty => this != KidsModel.empty;

  @override
  List<Object?> get props => [
        address,
        birthDate,
        contactNumber,
        fatherName,
        fullName,
        motherName,
        notes,
        age,
      ];
}
