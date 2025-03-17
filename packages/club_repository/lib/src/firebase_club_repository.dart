import 'dart:developer';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_repository/club_repository.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:uuid/uuid.dart';

class FirebaseClubRepository implements IClubRepository {
  final FirebaseFirestore _firebaseFirestore;

  FirebaseClubRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  /// User cache key.
  final userCacheKey = '__user_cache_key__';

  @override
  Future<Result<String, Failure>> createClub({required String name}) async {
    const uuid = Uuid();
    final customId = 'club-${uuid.v4().substring(0, 5)}';

    try {
      final String userCache =
          CacheClient.read<AuthUserModel>(key: userCacheKey)!.userId;

      await _firebaseFirestore.collection('clubs').doc(customId).set({
        'name': name.trim(),
        'teachers': [userCache],
        'kids': [],
        'address': 'Rua teste'
      });

      await _firebaseFirestore.collection('teachers').doc(userCache).update({
        'classIds': FieldValue.arrayUnion([customId]),
      });
      return const Success('Clubinho criado com sucesso!');
    } on FirebaseException catch (e) {
      return const Error(Failure(message: 'Erro ao criar clubinho!'));
    }
  }

  @override
  Future<Result<List<ClubModel>, FailureClub>> getAllClubs(
      {required String uuid}) async {
    try {
      final String userCache =
          CacheClient.read<AuthUserModel>(key: userCacheKey)!.userId;

      final teacherDoc =
          await _firebaseFirestore.collection('teachers').doc(userCache).get();

      if (!teacherDoc.exists) {
        throw Exception('Professor não encontrado');
      }

      final classIds = teacherDoc.data()?['classIds'] ?? [];

      if (classIds.isEmpty) {
        return const Success([]);
      }
      // isso vai ate 10
      final classesQuery = await _firebaseFirestore
          .collection('clubs')
          .where(FieldPath.documentId, whereIn: classIds)
          .get();

      log('log clubs query ==> ${classesQuery.docs}');

      final clubList = classesQuery.docs
          .map((doc) => ClubModel.fromJsonBasic(
              doc as DocumentSnapshot<Map<String, dynamic>>))
          .toList();

      return Success(clubList);
    } on FirebaseException catch (e) {
      log('Firebase error: ${e.message}');
      return const Error(FailureClub(message: 'Nenhum Clubinho Vinculado!'));
    } catch (e) {
      log('General error: $e');
      return Error(FailureClub(message: e.toString()));
    }
  }

  @override
  Future<Result<String, Failure>> editAddress(
      {required String uuid, required String address}) async {
    try {
      await _firebaseFirestore.collection('clubs').doc(uuid).update({
        'address': address,
      });
      return const Success('Editado com sucesso!');
    } on FirebaseException catch (e) {
      return Error(FailureClub(message: e.message!));
    }
  }

  @override
  Future<Result<String, Failure>> editName(
      {required String uuid, required String name}) async {
    try {
      await _firebaseFirestore.collection('clubs').doc(uuid).update({
        'name': name,
      });
      return const Success('Editado com sucesso!');
    } on FirebaseException catch (e) {
      return Error(FailureClub(message: e.message!));
    }
  }

  @override
  Future<Result<ClubModel, Failure>> getClubInfo({required String id}) async {
    try {
      DocumentSnapshot documentSnapshot =
          await _firebaseFirestore.collection('clubs').doc(id).get();

      if (documentSnapshot.exists) {
        // final data =
        //     documentSnapshot.data() as DocumentSnapshot<Map<String, dynamic>>;
        final data = documentSnapshot.data();

        return Success(ClubModel.fromJson(data as Map<String, dynamic>));
      } else {
        return const Error(Failure(message: 'Clubinho não existe'));
      }
    } on FirebaseException catch (e) {
      return const Error(Failure(message: "Erro ao buscar dados"));
    }
  }

  @override
  Future<Result<List<TeachersModel>, Failure>> getUsers(
      {required String id}) async {
    try {
      QuerySnapshot querySnapshot = await _firebaseFirestore
          .collection('teachers')
          .where('classIds', arrayContains: id)
          .get();

      List<TeachersModel> teachers = querySnapshot.docs.map((doc) {
        return TeachersModel.fromJson(doc.data() as Map<String, dynamic>)
            .copyWith(id: doc.id);
      }).toList();

      return Success(teachers);
    } on FirebaseException catch (e) {
      return Error(
          Failure(message: "Erro ao buscar professores: ${e.message}"));
    }
  }

  @override
  Future<Result<List<KidsModel>, Failure>> getChildren(
      {required String id}) async {
    try {
      final DocumentSnapshot docSnapshot =
          await _firebaseFirestore.collection('clubs').doc(id).get();

      if (!docSnapshot.exists) {
        return const Error(Failure(message: "Clube não encontrado"));
      }

      final data = docSnapshot.data() as Map<String, dynamic>;
      final List<dynamic> kidsData = data['kids'] ?? [];

      final List<KidsModel> kids = kidsData
          .map((kidData) => KidsModel.fromJson(kidData as Map<String, dynamic>))
          .toList();

      return Success(kids);
    } on FirebaseException catch (e) {
      return Error(
        Failure(message: "Erro ao buscar crianças: ${e.message}"),
      );
    } catch (e) {
      return Error(
        Failure(message: "Erro inesperado ao buscar crianças: $e"),
      );
    }
  }

  @override
  Future<Result<String, Failure>> addChild({
    required String id,
    required String address,
    required String age,
    required String birthDate,
    required String contactNumber,
    required String fatherName,
    required String fullName,
    required String motherName,
    required String notes,
  }) async {
    const uuid = Uuid();
    final customId = 'child-${uuid.v4().substring(0, 4)}';

    final Map<String, dynamic> newKid = {
      "address": address,
      "age": age,
      "birthDate": birthDate,
      "contactNumber": contactNumber,
      "fatherName": fatherName,
      "fullName": fullName,
      "motherName": motherName,
      "notes": notes,
      "id": customId,
    };

    try {
      await _firebaseFirestore.collection('clubs').doc(id).update({
        'kids': FieldValue.arrayUnion([newKid]),
      });

      return const Success('Criança adicionada com sucesso!');
    } on FirebaseException catch (e) {
      return Error(Failure(message: "Erro ao adicionar criança: ${e.message}"));
    } catch (e) {
      return Error(Failure(message: "Erro inesperado: $e"));
    }
  }
}
