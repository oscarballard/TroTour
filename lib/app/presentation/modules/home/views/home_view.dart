import 'package:flutter/material.dart';

import '../../../../my_app.dart';
import '../../../routes/routes.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Center(
          child: TextButton(
            onPressed: () async {
              Injector.of(context).authenticationRepository.signOut();
              Navigator.pushReplacementNamed(context, Routes.signIn,);
            },
            child: const Text('Sign Out'),
          ),
        ),
      ),
    );
  }
}