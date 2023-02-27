import 'package:boboloc/models/user_connexion_model.dart';
import 'package:boboloc/pages/cars_list_page.dart';
import 'package:boboloc/pages/navigation_page.dart';
import 'package:boboloc/pages/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WrapperPage extends StatelessWidget {
  const WrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserConnexionData?>(context);
    if (user == null) {
      return SignInPage();
    } else {
      return NavigationPage();
    }
  }
}
