import 'package:boboloc/constants/colors/colors.dart';
import 'package:boboloc/database/authentication.dart';
import 'package:boboloc/models/user_model.dart';
import 'package:boboloc/utils/clipper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _name = '';
  String _firstName = '';
  String _email = '';
  String _password = '';
  String _adresse = '';
  String _city = '';
  String _companyName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
          leading: IconButton(
              onPressed: () => context.go('/sign_in'),
              icon: const Icon(Icons.arrow_back)),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Stack(children: [
              Container(
                height: 220,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: MyColors(opacity: 1).tertiary),
                child: const Image(
                  image: AssetImage('assets/car_background.png'),
                  fit: BoxFit.fill,
                ),
              ),
              ClipPath(
                clipper: WaveClipperSignUp(),
                child: Container(
                  height: 217,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: MyColors(opacity: 0.7).primary,
                  ),
                  child: Center(
                    child: Text(
                      'Inscription',
                      style: TextStyle(
                          color: MyColors(opacity: 1).tertiary,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ]),
            Form(
                key: _formKey,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 120,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Nom'),
                              onChanged: (value) {
                                _name = value;
                              },
                              validator: (value) {
                                if (value!.isEmpty || value == null) {
                                  return 'Entrer votre nom';
                                }

                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Prénom'),
                              onChanged: (value) {
                                _firstName = value;
                              },
                              validator: (value) {
                                if (value!.isEmpty || value == null) {
                                  return 'Entrer votre prénom';
                                }

                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Nom de société'),
                        onChanged: (value) {
                          _companyName = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty || value == null) {
                            return 'Entrer le nom de votre société';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), labelText: 'Email'),
                        onChanged: (value) {
                          _email = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Entrer votre adresse email';
                          }

                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                            return 'Entrer une adresse email correct';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), labelText: 'Adresse'),
                        onChanged: (value) {
                          _adresse = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty || value == null) {
                            return 'Entrer votre adresse';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), labelText: 'Ville'),
                        onChanged: (value) {
                          _city = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty || value == null) {
                            return 'Entrer le nom de votre ville';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Mot de passe'),
                        onChanged: (value) {
                          _password = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty || value == null) {
                            return 'Entrer un mot de passe';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                          height: 45,
                          width: MediaQuery.of(context).size.width - 120,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          MyColors(opacity: 1).primary)),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  print('New user signed up !');
                                  print(_email);
                                  print(_password);

                                  await Authentication().signUp(UserModel(
                                      name: _name,
                                      firstName: _firstName,
                                      companyName: _companyName,
                                      password: _password,
                                      city: _city,
                                      email: _email,
                                      adresse: _adresse,
                                      subscribmentStatus: "free"));

                                  context.go('/sign_in');
                                }
                              },
                              child: const Text("S'inscrire"))),
                      const SizedBox(
                        height: 15,
                      )
                    ],
                  ),
                ))
          ]),
        ));
  }
}
