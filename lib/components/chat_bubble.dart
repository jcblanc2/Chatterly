import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isSender;
  const ChatBubble({super.key, required this.message, required this.isSender});

  @override
  Widget build(BuildContext context) {
    if (isSender) {
      return BubbleSpecialThree(
          text: message,
          color: const Color(0xFF1B97F3),
          tail: true,
          textStyle: const TextStyle(color: Colors.white, fontSize: 16));
    } else {
      return BubbleSpecialThree(
        text: message,
        color: const Color(0xFFE8E8EE),
        tail: true,
        isSender: false,
      );
    }
  }
}
