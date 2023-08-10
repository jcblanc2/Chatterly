import 'package:flutter/material.dart';
import '../components/auth_button.dart';
import '../components/auth_text_field.dart';

class Register extends StatefulWidget {
  final void Function() onTap;
  const Register({super.key, required this.onTap});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signup() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),

                // logo
                const Icon(
                  Icons.person,
                  size: 100,
                ),

                const SizedBox(
                  height: 50,
                ),

                // message
                const Text(
                  "Let's create an account for you!",
                  style: TextStyle(fontSize: 16),
                ),

                const SizedBox(
                  height: 25,
                ),

                // email textfield
                AuthTextField(
                  controller: emailController,
                  hint: "Email",
                  obscureText: false,
                ),

                const SizedBox(
                  height: 10,
                ),

                // password textfield
                AuthTextField(
                  controller: passwordController,
                  hint: "Password",
                  obscureText: true,
                ),

                const SizedBox(
                  height: 10,
                ),

                // confirm password textfield
                AuthTextField(
                  controller: confirmPasswordController,
                  hint: "Confirm password",
                  obscureText: true,
                ),

                const SizedBox(
                  height: 25,
                ),

                // register button
                const AuthButton(text: "Sign Un"),

                const SizedBox(
                  height: 50,
                ),

                // don't have account -> register
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text("Already a member?"),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      "Login now",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
