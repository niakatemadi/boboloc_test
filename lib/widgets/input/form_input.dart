import 'package:flutter/material.dart';

class FormInput extends StatefulWidget {
  bool isFieldEmpty;
  var variableFilled;
  String label;
  FormInput(
      {super.key,
      required this.variableFilled,
      required this.isFieldEmpty,
      required this.label});

  @override
  State<FormInput> createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.isFieldEmpty ? 65 : 45,
      child: TextFormField(
        decoration: InputDecoration(
            border: const OutlineInputBorder(), labelText: widget.label),
        onChanged: (value) {
          widget.variableFilled = value;
        },
        validator: (value) {
          if (value!.isEmpty || value == null) {
            setState(() {
              widget.isFieldEmpty = true;
            });
            return 'Entrer une adresse email';
          }
          setState(() {
            widget.isFieldEmpty = false;
          });

          return null;
        },
      ),
    );
  }
}
