import 'package:flutter/material.dart';

class CTextInput extends StatelessWidget {
  final String label;
  final Function validator;
  final bool isPassword;
  final TextEditingController controller;

  CTextInput({@required this.label, this.validator, this.isPassword, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword,
      controller: controller,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2.0, color: Theme.of(context).accentColor),
          borderRadius: BorderRadius.all(Radius.zero),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2.0, color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.all(Radius.zero)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2.0, color: Colors.red),
            borderRadius: BorderRadius.all(Radius.zero)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2.0, color: Theme.of(context).accentColor),
            borderRadius: BorderRadius.all(Radius.zero)),
        hintText: label,
      ),
      validator: validator,
    );
  }

}