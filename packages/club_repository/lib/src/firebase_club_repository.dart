import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_repository/club_repository.dart';
import 'package:club_repository/src/failure/failure.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:uuid/uuid.dart';

class FirebaseClubRepository implements IClubRepository {
  final FirebaseFirestore _firebaseFirestore;

  FirebaseClubRepository({required FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<Result<String, Failure>> createClub({required String name}) async {
    const uuid = Uuid();
    final customId = 'club-${uuid.v4().substring(0, 5)}';

    try {
      await _firebaseFirestore.collection('clubs').doc(customId).set({
        'name': name.trim(),
        'teachers': [],
        'kids': [],
      });
      return const Success('Clubinho criado com sucesso!');
    } on FirebaseException catch (e) {
      return const Error(Failure(message: ''));
    }
  }
}
