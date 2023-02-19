import 'package:boboloc/database/authentication.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Connexion'),
        ),
        body: Center(
          child: SizedBox(
            width: 300,
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    const Text(
                      'Connexion',
                      style: TextStyle(fontSize: 30),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'Email'),
                      onChanged: (value) {
                        _email = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Entrer votre email';
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      decoration:
                          const InputDecoration(hintText: 'Mot de passe'),
                      onChanged: (value) {
                        _password = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Entre un mot de passe';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            print('user connected !');
                            print(_email);
                            print(_password);
                            Authentication()
                                .signIn(email: _email, password: _password);
                          }
                        },
                        child: const Text('Se connecter')),
                    ElevatedButton(
                        onPressed: () => context.go('/sign_up'),
                        child: const Text("Créer un compte"))
                  ],
                )),
          ),
        ));
  }
}
