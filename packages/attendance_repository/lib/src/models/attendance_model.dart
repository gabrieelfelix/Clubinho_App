import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class AttendanceModel extends Equatable {
  final List<AttendanceItem> attendanceList;
  final String clubId;
  final String date;

  const AttendanceModel({
    required this.attendanceList,
    required this.clubId,
    required this.date,
  });

  static const empty =
      AttendanceModel(attendanceList: [], clubId: '', date: '');

  AttendanceModel copyWith({
    List<AttendanceItem>? attendanceList,
    String? clubId,
    String? date,
  }) {
    return AttendanceModel(
      attendanceList: attendanceList ?? this.attendanceList,
      clubId: clubId ?? this.clubId,
      date: date ?? this.date,
    );
  }

  factory AttendanceModel.fromJson(
      DocumentSnapshot<Map<String, dynamic>> json) {
    return AttendanceModel(
      attendanceList: (json['attendanceList'] as List<dynamic>?)
              ?.map(
                  (e) => AttendanceItem.fromJson(Map<String, dynamic>.from(e)))
              .toList() ??
          [],
      clubId: json['clubId'] ?? '',
      date: json.id,
    );
  }
  factory AttendanceModel.fromJsonBasic(
      DocumentSnapshot<Map<String, dynamic>> json) {
    return AttendanceModel(
      attendanceList: [],
      clubId: '',
      date: json.id,
    );
  }

  // factory AttendanceModel.fromDocument(
  //     DocumentSnapshot<Map<String, dynamic>> doc) {
  //   final data = doc.data()!;
  //   return AttendanceModel(
  //     attendanceList: (data['attendanceList'] as List<dynamic>?)
  //             ?.map(
  //                 (e) => AttendanceItem.fromJson(Map<String, dynamic>.from(e)))
  //             .toList() ??
  //         [],
  //     clubId: data['clubId'] ?? '',
  //     date: data['date'] ?? '',
  //   );
  // }

  bool get isEmpty => this == AttendanceModel.empty;
  bool get isNotEmpty => this != AttendanceModel.empty;

  @override
  List<Object?> get props => [attendanceList, clubId, date];
}

class AttendanceItem extends Equatable {
  final String kidId;
  final bool present;

  const AttendanceItem({
    required this.kidId,
    required this.present,
  });

  factory AttendanceItem.fromJson(Map<String, dynamic> json) {
    return AttendanceItem(
      kidId: json['kidId'] ?? '',
      present: json['present'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'kidId': kidId,
      'present': present,
    };
  }

  @override
  List<Object?> get props => [kidId, present];
}
