import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  const AuthButton({super.key, this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
            color: const Color(0xFF2296f3),
            borderRadius: BorderRadius.circular(9)),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
