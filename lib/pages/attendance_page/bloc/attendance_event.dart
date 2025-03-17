part of 'attendance_bloc.dart';

abstract class IAttendanceEvent extends Equatable {
  const IAttendanceEvent();

  @override
  List<Object> get props => [];
}

class GetAllAttendanceRequired extends IAttendanceEvent {
  final String id;

  const GetAllAttendanceRequired({required this.id});
  @override
  List<Object> get props => [id];
}

class GetAllKidsRequired extends IAttendanceEvent {
  final String id;

  const GetAllKidsRequired({required this.id});
  @override
  List<Object> get props => [id];
}

class TakeAttendanceRequired extends IAttendanceEvent {
  // final String clubId;
  // final String kidId;
  // final bool present;
  final List<KidsModel> kidsList;
  const TakeAttendanceRequired({required this.kidsList});
  @override
  List<Object> get props => [kidsList];
}

class ChangeRequired extends IAttendanceEvent {
  final String kidId;
  final bool isPresent;
  final bool isAbsent;

  const ChangeRequired({
    required this.kidId,
    required this.isPresent,
    required this.isAbsent,
  });

  @override
  List<Object> get props => [kidId, isPresent, isAbsent];
}
