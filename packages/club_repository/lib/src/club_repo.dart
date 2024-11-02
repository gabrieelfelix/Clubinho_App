import 'package:club_repository/src/failure/failure.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class IClubRepository {
  Future<Result<String, Failure>> createClub({required String name});
}
