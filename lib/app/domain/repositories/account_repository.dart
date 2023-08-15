import '../models/user.dart';

abstract class AccoutRespository{
  Future<Users?> getUserData();
}