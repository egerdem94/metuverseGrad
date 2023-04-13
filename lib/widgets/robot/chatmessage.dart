import 'package:flutter/material.dart';
import 'package:metuverse/user/User.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({
    Key? key,
    required this.text,
    required this.sender,
    this.isImage = false,
  }) : super(key: key);

  final String text;
  final String sender;
  final bool isImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color:
                  sender == User.fullName ? Colors.red[200] : Colors.green[200],
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(8.0),
            child: Text(sender, style: TextStyle(color: Colors.white)),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(text.trim(), style: TextStyle(color: Colors.white70)),
          ),
        ],
      ),
    );
  }
}
