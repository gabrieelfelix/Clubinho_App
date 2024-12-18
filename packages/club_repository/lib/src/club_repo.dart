import 'package:authentication_repository/authentication_repository.dart';
import 'package:club_repository/src/models/club_model.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class IClubRepository {
  Future<Result<String, Failure>> createClub({required String name});

  Future<Result<List<ClubModel>, Failure>> getAllClubs({required String uuid});
}
