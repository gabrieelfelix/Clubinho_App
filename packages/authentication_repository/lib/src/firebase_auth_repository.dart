import 'dart:developer';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:multiple_result/multiple_result.dart';

class FirebaseAuthRepository implements IAuthenticationRepository {
  final FirebaseAuth _firebaseAuth;

  final FirebaseFirestore _firebaseFirestore;

  FirebaseAuthRepository(
      {FirebaseAuth? firebaseAuth, FirebaseFirestore? firebaseFirestore})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  /// User cache key.
  final userCacheKey = '__user_cache_key__';

  @override
  Future<void> verifyPhone({required String phoneNumber}) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Se a verificação for automática, você pode assinar diretamente o usuário
        //  await _firebaseAuth.signInWithCredential(credential);
        log('token==> ${credential.smsCode}');
      },
      verificationFailed: (FirebaseAuthException e) {
        // Handle error
        log('Verification failed: ${e.message}');
      },
      codeSent: (String verId, int? resendToken) {
        // O código foi enviado com sucesso
        // setState(() {
        //   verificationId = verId;
        // });
        log('code Sent: $verId');
      },
      codeAutoRetrievalTimeout: (String verId) {
        // O tempo de espera para a verificação automática expirou
        // setState(() {
        //   verificationId = verId;
        // });
        log('retrieval timeout $verId');
      },
    );
  }

  @override
  Future<Result<String, Failure>> signUp({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    //
    try {
      // Create an account with Firebase Authentication
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // Saves the userId as the document name in the "teachers" collection in Firestore
      final String userId = userCredential.user!.uid;

      await _firebaseFirestore.collection('teachers').doc(userId).set({
        'name': name.trim(),
        'email': email.trim(),
        'contact': phone.trim(),
        'classIds': [],
      });

      return const Success('Conta criada! Ative sua conta pelo Email');
    } on FirebaseAuthException catch (e) {
      return Error(CreateUserWithEmailAndPasswordFailure.fromCode(e.code));
    }
  }

  @override
  Future<Result<String, Failure>> signIn(
      {required String email, required String password}) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // Saves the userId for searching data user
      final String userId = userCredential.user!.uid;
      CacheClient.write<AuthUserModel>(
        key: userCacheKey,
        value: AuthUserModel(userId: userId),
      );

      return const Success('Login realizado com sucesso');
    } on FirebaseAuthException catch (e) {
      return Error(SignInWithEmailAndPasswordFailure.fromCode(e.code));
    }
  }

  @override
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }
}
