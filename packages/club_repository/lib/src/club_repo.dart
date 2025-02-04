import 'package:authentication_repository/authentication_repository.dart';
import 'package:club_repository/src/models/club_model.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class IClubRepository {
  Future<Result<String, Failure>> createClub({required String name});

  Future<Result<List<ClubModel>, Failure>> getAllClubs({required String uuid});

  Future<Result<String, Failure>> editName({
    required String uuid,
    required String name,
  });

  Future<Result<String, Failure>> editAddress({
    required String uuid,
    required String address,
  });

  Future<Result<ClubModel, Failure>> getClubInfo({required String id});
}
