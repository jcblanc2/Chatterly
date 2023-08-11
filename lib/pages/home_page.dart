import 'package:chatterly/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void signout() async {
    final authService = Provider.of<AuthService>(context, listen: false);

    await authService.signout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chats"),
        actions: [
          IconButton(onPressed: signout, icon: const Icon(Icons.logout))
        ],
      ),
    );
  }
}
