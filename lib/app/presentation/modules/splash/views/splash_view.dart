import 'package:flutter/material.dart';

import '../../../../my_app.dart';
import '../../../routes/routes.dart';

// pantalla de bienvenida 
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  void initState(){
    super.initState();
    // _init();
    WidgetsBinding.instance.addPostFrameCallback((_) { 
      _init();
    });
  }

  Future<void> _init() async {
    final injector = Injector.of(context);
    final connectivityRepository = injector.connectivityRepository;
    final hasInternet = await connectivityRepository.hasInternet;
    
    if(hasInternet){
      final authenticationRepository =   injector.authenticationRepository;
      final isSignedIn = await authenticationRepository.isSignedIn;
      if(isSignedIn){
        final user = await authenticationRepository.getUserData();
        if(mounted){
          if(user != null){
            _goTo(Routes.map);
          }else{
            _goTo(Routes.signIn);
          }
        }
      }else if(mounted){
        _goTo(Routes.map);
      }
    }else{
        _goTo(Routes.offline);
    }
  }

  void _goTo(String routeName){
    Navigator.pushReplacementNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}