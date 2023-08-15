import '../either.dart';
import '../enums.dart';
import '../models/user.dart';

abstract class AuthenticationRepository {
  Future<bool> get isSignedIn;
  Future<Users?> getUserData();
  Future<void> signOut();
  Future<Either<SighInFailure, Users>> sighIn(
    String userName,
    String password,
  );

  Future<Either<SighInFailure, Users>> createAccout(
    String userName,
    String password,
  );

  
}
