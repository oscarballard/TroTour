import 'package:flutter/material.dart';

import '../../../../domain/enums.dart';
import '../../../../my_app.dart';
import '../../../routes/routes.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignUpView> {
  String _userName = '', _password = '';
  bool _fethching = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            child: AbsorbPointer(
              absorbing: _fethching,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (text) {
                        setState(() {
                          _userName = text.trim();
                        });
                      },
                      decoration:
                          const InputDecoration(hintText: 'Nombre de usuario'),
                      validator: (text) {
                        text = text?.trim().toLowerCase() ?? '';
                        if (text.isEmpty) {
                          return 'Nombre usuario vacio';
                        } else {
                          return null;
                        }
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (text) {
                        setState(() {
                          _password = text.replaceAll(" ", '').toLowerCase();
                        });
                      },
                      decoration: const InputDecoration(hintText: 'Contraseña'),
                      validator: (text) {
                        text = text?.replaceAll(" ", '').toLowerCase() ?? '';
                        if (text.length < 4) {
                          return 'Contraseña invalida';
                        } else {
                          return null;
                        }
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  Builder(
                    builder: (context) {
                      if (_fethching) {
                        return const CircularProgressIndicator();
                      } else {
                        return MaterialButton(
                          onPressed: () {
                            final isValid = Form.of(context).validate();
                            if (isValid) {
                              _submit(context);
                            }
                          },
                          color: Colors.blue,
                          child: const Text("Login"),
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submit(BuildContext context) async {
    setState(() {
      _fethching = true;
    });
    final result = await Injector.of(context).authenticationRepository.createAccout(
          _userName,
          _password,
        );

    if (!mounted) {
      return;
    }

    result.when((failure) {
      setState(() {
        _fethching = false;
      });
      final message = {
        SighInFailure.notFound: 'Cuanta no encontrada',
        SighInFailure.unauthorized: 'Contraseña invalida',
        SighInFailure.unknow: 'Error',
      }[failure];

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message!)),
      );
    }, (user) {
      Navigator.pushReplacementNamed(context, Routes.map);
    });
  }
}
