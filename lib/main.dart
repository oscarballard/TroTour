import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:permission_handler/permission_handler.dart';

import 'app/data/repositories_implementation/authentication_repository_impl.dart';
import 'app/data/repositories_implementation/connectivity_repository_impl.dart';
import 'app/data/repositories_implementation/geolocation_repository_impl.dart';
import 'app/data/services/remote/authentication_api.dart';
import 'app/data/services/remote/internet_checker.dart';
import 'app/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PermissionStatus status = await Permission.location.request();
  await Firebase.initializeApp();
  FirebaseAuth auth = FirebaseAuth.instance;

  if (status.isGranted) {
    runApp(Injector(
        connectivityRepository:
            ConnectivityRepositoryImpl(Connectivity(), InternetChecker()),
        authenticationRepository:
            AuthenticationRepositoryImpl(const FlutterSecureStorage(),auth, AuthenticationApi()),
        geolocationRepository: GeoLocationRepositoryImpl(),
        child: const MyApp()));
  }
}
