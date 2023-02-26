import 'package:boboloc/database/authentication.dart';
import 'package:boboloc/utils/clipper.dart';
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
  bool _isFieldEmpty = false;

  bool _isConnected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Stack(children: [
            Container(
              height: 390,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(color: Colors.white),
              child: const Image(
                image: AssetImage('assets/car_background.png'),
                fit: BoxFit.fill,
              ),
            ),
            ClipPath(
              clipper: WaveClipper(),
              child: Container(
                height: 390,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(113, 101, 227, 0.7),
                ),
                child: const Center(
                  child: Text(
                    'Connexion',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ]),
          Container(
            height: MediaQuery.of(context).size.height - 390,
            width: MediaQuery.of(context).size.width,
            child: Column(children: [
              _isConnected ? Text('Vous etes connecté') : Text(''),
              const SizedBox(height: 45),
              Form(
                  key: _formKey,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 120,
                    child: Column(
                      children: [
                        SizedBox(
                          height: _isFieldEmpty ? 65 : 45,
                          child: TextFormField(
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Email'),
                            onChanged: (value) {
                              _email = value;
                            },
                            validator: (value) {
                              if (value!.isEmpty || value == null) {
                                setState(() {
                                  _isFieldEmpty = true;
                                });
                                return 'Entrer une adresse email';
                              }
                              setState(() {
                                _isFieldEmpty = false;
                              });

                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: _isFieldEmpty ? 65 : 45,
                          child: TextFormField(
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Mot de passe'),
                            onChanged: (value) {
                              _password = value;
                            },
                            validator: (value) {
                              if (value!.isEmpty || value == null) {
                                setState(() {
                                  _isFieldEmpty = true;
                                });
                                return 'Entrer un mot de passe';
                              }

                              setState(() {
                                _isFieldEmpty = false;
                              });

                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 45,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                print('user connected !');
                                print(_email);
                                print(_password);
                                await Authentication()
                                    .signIn(email: _email, password: _password);
                                setState(() {
                                  _isConnected = true;
                                });
                              }
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<
                                        Color>(
                                    const Color.fromRGBO(113, 101, 227, 1))),
                            child: const Text('Se connecter'),
                          ),
                        )
                      ],
                    ),
                  )),
              const SizedBox(height: 20),
              const Text('Mot de passe oublié'),
              const SizedBox(height: 45),
              SizedBox(
                width: MediaQuery.of(context).size.width - 120,
                height: 45,
                child: ElevatedButton(
                  onPressed: () => context.go('/sign_up'),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromRGBO(255, 99, 99, 1))),
                  child: const Text("S'inscrire"),
                ),
              )
            ]),
          )
        ],
      ),
    ));
  }
}
