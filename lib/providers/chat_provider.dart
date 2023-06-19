import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/message_model.dart';
import '../utils/data.dart';

class ChatProvider extends ChangeNotifier {
  final List<Message> _messages = [
    Message(
        message: "Hi, I'm ICET's Chat bot",
        role: "system",
        time: DateTime.now().toIso8601String()),
    Message(
        message: "Ask me Anything about ICET",
        role: "system",
        time: DateTime.now().toIso8601String()),
  ];

  List<Message> get messages => _messages;

  Future<void> sendMessage(String message) async {
    _messages.add(Message(
        message: message,
        role: "user",
        time: DateTime.now().toIso8601String()));
    notifyListeners();

    final url = Uri.parse("https://api.openai.com/v1/chat/completions");
    const header = {
      "Content-Type": "application/json",
      "Authorization":
          "Bearer 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"
    };
    List<Map<String, dynamic>> conversation = [
      {
        "role": "system",
        "content": "You are an  assistant at Ilahia college of Engineering and Technology(ICET)"
      },
      {
        "role": "user",
        "content":
            "These are the details about the college , ${Data.data}."
      },
      {
        "role": "assistant",
        "content":
            "okay I'll answer to the questions shortly without any other explanations"
      },
    ];

    for (var element in _messages) {
      if(element.role != "system"){
        conversation.add({"role": element.role, "content": element.message});
      }
    }
    final body = {
      "messages": conversation,
      "max_tokens": 100,
      "temperature": 0,
      "model": "gpt-3.5-turbo"
    };

    final response =
        await http.post(url, headers: header, body: json.encode(body));
    print(response.body);
    final Map<String, dynamic> result = json.decode(response.body);
    _messages.add(Message(
        message: result["choices"][0]['message']["content"],
        role: "assistant",
        time: DateTime.now().toIso8601String()));
    notifyListeners();
  }
}
