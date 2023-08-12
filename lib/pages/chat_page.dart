import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:chatterly/components/chat_bubble.dart';
import 'package:chatterly/services/chat/chart_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ChatPage extends StatefulWidget {
  final String receiverFullName;
  final String receiverEmail;
  final String receiverUid;
  const ChatPage(
      {super.key,
      required this.receiverEmail,
      required this.receiverUid,
      required this.receiverFullName});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage(String message) async {
    if (message.isNotEmpty) {
      await _chatService.sendMessage(widget.receiverUid, message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverFullName),
      ),
      body: Column(
        children: [
          // messages
          Expanded(child: _messageList()),

          // textfield
          _userInput(),

          const SizedBox(
            height: 25,
          )
        ],
      ),
    );
  }

  // buid messages list
  Widget _messageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(
          widget.receiverUid, _firebaseAuth.currentUser!.uid),
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
                .map<Widget>((doc) => __messageItemList(doc))
                .toList());
      },
    );
  }

  // build message item
  Widget __messageItemList(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

    // set alignment
    var alignment = data['senderId'] == _firebaseAuth.currentUser!.uid
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: data['senderId'] == _firebaseAuth.currentUser!.uid
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          mainAxisAlignment: data['senderId'] == _firebaseAuth.currentUser!.uid
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            ChatBubble(
                message: data['message'],
                isSender: data['senderId'] == _firebaseAuth.currentUser!.uid)
          ],
        ),
      ),
    );
  }

  // build user input
  Widget _userInput() {
    return MessageBar(
      onSend: (_) => sendMessage(_),
    );
  }
}
