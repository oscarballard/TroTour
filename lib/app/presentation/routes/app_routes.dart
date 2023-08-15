import 'package:flutter/material.dart';

import '../modules/home/views/home_view.dart';
import '../modules/location/views/location_edit.dart';
import '../modules/map/views/map.dart';
import '../modules/offline/views/offline.dart';
import '../modules/sign_in/views/sign_in_view.dart';
import '../modules/sign_in/views/sign_on.dart';
import '../modules/splash/views/splash_view.dart';
import 'routes.dart';
 
Map<String, Widget Function(BuildContext)> get appRoutes {

  return {
    Routes.splash       : (context) => const SplashView(),
    Routes.signIn       : (context) => const SignInView(),
    Routes.home         : (context) => const HomeView(),
    Routes.offline      : (context) => const OfflineView(),
    Routes.map          : (context) => const MapView(),
    Routes.locationEdit : (context) => const LocationEditView(),
    Routes.signUp : (context) => const SignUpView(),
  };
}