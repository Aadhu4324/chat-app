import 'package:flutter/material.dart';

class CustomForm extends StatelessWidget {
  final bool obsecureText;
  final String hintText;
  final FormFieldSetter onSaved;
 const  CustomForm({super.key, required this.obsecureText, required this.hintText, required this.onSaved});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved:onSaved ,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter a Valid $hintText";
        } else {
          return null;
        }
      },
      obscureText: obsecureText,
      decoration: InputDecoration(
          hintText:hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
    );
  }
}
