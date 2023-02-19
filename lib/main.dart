import 'package:boboloc/database/authentication.dart';
import 'package:boboloc/models/user_connexion_model.dart';
import 'package:boboloc/router/router.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserConnexionData?>.value(
      value: Authentication().user,
      catchError: ((User, UserConnexionData) => null),
      initialData: null,
      child: MaterialApp.router(
        routerConfig: MyRouter().routerDatas(),
      ),
    );
  }
}
