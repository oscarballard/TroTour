import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../domain/either.dart';
import '../../domain/enums.dart';
import '../../domain/models/user.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../services/remote/authentication_api.dart';

const _key = 'sessionId';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  AuthenticationRepositoryImpl(
      this._secureStorage, this._firebaseAuth, this._auth);
  final FlutterSecureStorage _secureStorage;
  final FirebaseAuth _firebaseAuth;
  final AuthenticationApi _auth;

  User get user => _firebaseAuth.currentUser!;

  @override
  Future<Users?> getUserData() {
    return Future.value(
      Users(),
    );
  }

  @override
  Future<bool> get isSignedIn async {
    final sessionId = await _secureStorage.read(key: _key);
    return sessionId != null;
  }

  @override
  Future<Either<SighInFailure, Users>> sighIn(
    String userName,
    String password,
  ) async {
    try {
      final loginResult = await _auth.createSessionWithLogin(
        username: userName,
        password: password,
      );

      return loginResult.when((failure) => Either.left(failure),
          (sessionId) async {
        await _secureStorage.write(key: _key, value: sessionId);
        return Either.right(Users());
      });
    } on FirebaseAuthException {
      return Either.left(SighInFailure.notFound);
    }
  }

  @override
  Future<Either<SighInFailure, Users>> createAccout(
    String userName,
    String password,
  ) async {
    try {
      final loginResult = await _auth.createAccout(
        username: userName,
        password: password,
      );

      return loginResult.when((failure) => Either.left(failure),
          (sessionId) async {
        await _secureStorage.write(key: _key, value: sessionId);
        return Either.right(Users());
      });
    } on FirebaseAuthException {
      return Either.left(SighInFailure.notFound);
    }
  }

  @override
  Future<void> signOut() {
    return _secureStorage.delete(key: _key);
  }
}
