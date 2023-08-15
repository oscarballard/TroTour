import 'package:flutter/material.dart';

import 'domain/repositories/authentication_repository.dart';
import 'domain/repositories/connectivity_repository.dart';
import 'domain/repositories/geolocation_repository.dart';
import 'presentation/routes/app_routes.dart';
import 'presentation/routes/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        initialRoute: Routes.splash,
        routes: appRoutes,
      ),
    );
  }
}

class Injector extends InheritedWidget {
  const Injector({
    super.key,
    required super.child,
    required this.connectivityRepository,
    required this.authenticationRepository,
    required this.geolocationRepository,
  });

  final ConnectivityRepository connectivityRepository;
  final AuthenticationRepository authenticationRepository;
  final GeoLocationRepository geolocationRepository;
  
  @override
  bool updateShouldNotify(_) => false;

  static Injector of(BuildContext context){
    final injector = context.dependOnInheritedWidgetOfExactType<Injector>();
    assert(injector != null, 'Injecto could not be found');
    return injector!;
  }
}
