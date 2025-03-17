import 'package:attendance_repository/attendance_repository.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class IAttendanceRepository {
  Future<Result<List<AttendanceModel>, Failure>> getClubAttendances({
    required String clubId,
  });
}
