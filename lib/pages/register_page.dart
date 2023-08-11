import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/auth_button.dart';
import '../components/auth_text_field.dart';
import '../services/auth/auth_service.dart';

class Register extends StatefulWidget {
  final void Function() onTap;
  const Register({super.key, required this.onTap});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // text controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signup() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Password do not match!")));
      return;
    }

    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signUpWithEmailAndPassword(
          emailController.text, passwordController.text, nameController.text);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Error while login.")));
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

                  // name textfield
                  AuthTextField(
                    controller: nameController,
                    hint: "Full name",
                    obscureText: false,
                  ),

                  const SizedBox(
                    height: 10,
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
                  AuthButton(onTap: signup, text: "Sign Up"),

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
      ),
    );
  }
}
