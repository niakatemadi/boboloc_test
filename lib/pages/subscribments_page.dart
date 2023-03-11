import 'package:boboloc/utils/my_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SubscribmentsPage extends StatefulWidget {
  const SubscribmentsPage({super.key});

  @override
  State<SubscribmentsPage> createState() => _SubscribmentsPageState();
}

class _SubscribmentsPageState extends State<SubscribmentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {}, child: Text("Buy silver subscribment")),
      ),
    );
  }
}
