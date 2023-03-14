import 'package:boboloc/database/authentication.dart';
import 'package:boboloc/models/user_connexion_model.dart';
import 'package:boboloc/router/router.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  Stripe.publishableKey =
      "pk_test_51MhL6PF3c6zQiIn4WC9W4j2pnwZ16bOZoMtI2InAkzOj2E7lw450J5rPlDH4jqpf4jrqJP3k1EEmIGqayGuPY1IX00YcJ9NrYz";
  await Stripe.instance.applySettings();
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
        debugShowCheckedModeBanner: false,
        routerConfig: MyRouter().routerDatas(),
      ),
    );
  }
}
