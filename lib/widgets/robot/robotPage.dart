/*
import 'dart:async';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:metuverse/storage/User.dart';
import 'package:metuverse/widgets/app_bar.dart';
import '../bottom_navigation_bar.dart';
import 'chatmessage.dart';
import 'threedots.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [];
  ChatGPT? chatGPT;
  StreamSubscription? _subscription;
  bool _isTyping = false;

  void extractDate(String input) {
    final dateRegex =
        RegExp(r'(\b\d{1,2}\b)[/\.](\b\d{1,2}\b)[/\.](\b\d{2}|\b\d{4})\b');
    final match = dateRegex.firstMatch(input);
    if (match != null) {
      final day = match.group(1);
      final month = match.group(2);
      final year = match.group(3)!.padLeft(4, '20');
      final date =
          DateTime(int.parse(year), int.parse(month!), int.parse(day!));
      final formattedDate = DateFormat('dd/MM/yy').format(date);
      insertNewData(formattedDate);
    }
  }

  @override
  void initState() {
    super.initState();
    chatGPT = ChatGPT.instance.builder(
      "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",
    );
  }

  @override
  void dispose() {
    chatGPT!.close();
    _subscription?.cancel();
    super.dispose();
  }

  void _sendMessage() {
    if (_controller.text.isEmpty) return;
    ChatMessage message = ChatMessage(
      text: _controller.text,
      sender: User.fullName,
    );
    setState(() {
      _messages.insert(0, message);
      _isTyping = true;
    });

    _controller.clear();

    _subscription?.cancel(); // Cancel any existing subscription

    final request = CompleteReq(
        prompt: message.text, model: kTranslateModelV3, max_tokens: 200);
    _subscription = chatGPT!
        .onCompleteStream(request: request)
        .asBroadcastStream()
        .listen((response) {
      print(response!.choices[0].text);
      insertNewData(response.choices[0].text);
      _subscription
          ?.cancel(); // Cancel the subscription after the response is received
    });
  }

  void insertNewData(String response) {
    ChatMessage botMessage = ChatMessage(
      text: response,
      sender: "bot",
    );
    setState(() {
      _isTyping = false;
      _messages.insert(0, botMessage);
    });
  }

  Widget _buildTextComposer() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            style: TextStyle(color: Colors.white70),
            controller: _controller,
            onSubmitted: (value) {
              _sendMessage();
              extractDate(value);
            },
            decoration: const InputDecoration.collapsed(
                hintText: "Question/description",
                hintStyle: TextStyle(color: Colors.white70)),
          ),
        ),
        ButtonBar(
          children: [
            IconButton(
              icon: const Icon(
                Icons.send,
                color: Colors.white70,
              ),
              onPressed: () {
                _sendMessage();
                extractDate(_controller.text);
              },
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MetuverseAppBar(),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: Column(
          children: [
            Flexible(
                child: ListView.builder(
              reverse: true,
              padding: EdgeInsets.all(8.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _messages[index];
              },
            )),
            if (_isTyping) const ThreeDots(),
            const Divider(
              height: 1.0,
            ),
            Container(
              decoration: BoxDecoration(color: Colors.black),
              child: _buildTextComposer(),
            )
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
*/