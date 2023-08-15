import 'package:firebase_auth/firebase_auth.dart';

import '../../../domain/either.dart';
import '../../../domain/enums.dart';

class AuthenticationApi {
  Future<Either<SighInFailure, String>> createSessionWithLogin({
    required String username,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: username, password: password);
      User? user = userCredential.user;

      final sessionId = user?.uid;

      if (sessionId != null) {
        return Either.right(sessionId);
      } else {
        return Either.left(SighInFailure.notFound);
      }
    } catch (e) {
      return Either.left(SighInFailure.unknow);
    }
  }

  Future<Either<SighInFailure, String>> createAccout({
    required String username,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: username, password: password);
      User? user = userCredential.user;

      final sessionId = user?.uid;

      if (sessionId != null) {
        return Either.right(sessionId);
      } else {
        return Either.left(SighInFailure.notFound);
      }
    } catch (e) {
      return Either.left(SighInFailure.unknow);
    }
  }
}
