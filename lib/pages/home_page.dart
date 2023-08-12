import 'dart:math';
import 'package:chatterly/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'chat_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // fireAuth instance
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void signout() async {
    final authService = Provider.of<AuthService>(context, listen: false);

    await authService.signout();
  }

  Color randomColor() {
    Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: const Text(
            "Chats",
          ),
          actions: [
            IconButton(onPressed: signout, icon: const Icon(Icons.logout))
          ],
        ),
        body: _userList(),
      ),
    );
  }

  // a widget to display all user except the current user
  Widget _userList() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Error')));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return SpinKitWave(
            color: Colors.blue[300],
            size: 110,
          );
        }

        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _userListItem(doc))
              .toList(),
        );
      },
    );
  }

  // user item
  Widget _userListItem(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data =
        documentSnapshot.data()! as Map<String, dynamic>;

    // display all users
    if (_firebaseAuth.currentUser!.email != data['email']) {
      List<String> names = data['fullname'].split(' ');

      return Column(
        children: [
          ListTile(
            title: Text(
              data['fullname'],
              style: const TextStyle(fontSize: 16),
            ),
            subtitle: Text(
              data['email'],
              style: const TextStyle(fontSize: 16),
            ),
            leading: CircleAvatar(
              backgroundColor: randomColor(),
              foregroundColor: Colors.white,
              child: Text(names[0][0] + (names.length > 1 ? names[1][0] : ""),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            onTap: () {
              // navigate to the chat page
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChatPage(
                            receiverFullName: data['fullname'],
                            receiverEmail: data['email'],
                            receiverUid: data['uid'],
                          )));
            },
          ),
          const Divider(),
        ],
      );
    } else {
      return Container();
    }
  }
}
