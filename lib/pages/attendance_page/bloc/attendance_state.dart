part of 'attendance_bloc.dart';

enum AttendanceStatus {
  initial,
  loading,
  present,
  absent,
  failure,
  edit,
  success
}

class AttendanceBlocState extends Equatable {
  final AttendanceStatus state;
  final String? message;
  final List<AttendanceModel>? attendanceList;
  final List<KidsModel>? kidsList;

  const AttendanceBlocState._({
    this.state = AttendanceStatus.loading,
    this.message,
    this.attendanceList,
    this.kidsList,
  });

  const AttendanceBlocState.initial() : this._(state: AttendanceStatus.initial);

  const AttendanceBlocState.failure({required String message})
      : this._(state: AttendanceStatus.failure, message: message);

  const AttendanceBlocState.successAttendance(
      {required List<AttendanceModel> listModel})
      : this._(state: AttendanceStatus.success, attendanceList: listModel);

  const AttendanceBlocState.successKids({required List<KidsModel> kidsList})
      : this._(state: AttendanceStatus.success, kidsList: kidsList);

  AttendanceBlocState.successTakeAtt({
    required String message,
  }) : this._(
          state: AttendanceStatus.success,
          message: message,
          kidsList: [],
        );

  const AttendanceBlocState.change({required List<KidsModel> kidsList})
      : this._(state: AttendanceStatus.success, kidsList: kidsList);

  const AttendanceBlocState.loading() : this._();

  @override
  List<Object?> get props => [state, message, kidsList, attendanceList];
}

extension HomePageStateExtensions on AttendanceBlocState {
  bool get isInitial => state == AttendanceStatus.initial;
  bool get isLoading => state == AttendanceStatus.loading;
  bool get isPresent => state == AttendanceStatus.present;
  bool get isAbsent => state == AttendanceStatus.absent;
  bool get isFailure => state == AttendanceStatus.failure;
  bool get isSuccess => state == AttendanceStatus.success;
}
