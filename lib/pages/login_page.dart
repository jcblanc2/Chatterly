import 'package:chatterly/components/auth_button.dart';
import 'package:chatterly/components/auth_text_field.dart';
import 'package:chatterly/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function() onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() async {
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signInWithEmailAndPassword(
          emailController.text, passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Incorrect email or password")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: SingleChildScrollView(
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
                    color: Color(0xFF2296f3),
                  ),

                  const SizedBox(
                    height: 50,
                  ),

                  // message
                  const Text(
                    "Welcome back you've been missed!",
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
                    height: 25,
                  ),

                  // login button
                  AuthButton(onTap: login, text: "Sign In"),

                  const SizedBox(
                    height: 50,
                  ),

                  // don't have account -> register
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Text("Not a member?"),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Register now",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2296f3),
                        ),
                      ),
                    )
                  ])
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
