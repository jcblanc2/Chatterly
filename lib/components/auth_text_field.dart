import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscureText;

  const AuthTextField(
      {super.key,
      required this.controller,
      required this.hint,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green.shade200)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          fillColor: Colors.grey[200],
          filled: true,
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey)),
    );
  }
}
