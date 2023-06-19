import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/message_model.dart';
import '../providers/chat_provider.dart';
import 'chat_bubble.dart';

class MessagesList extends StatelessWidget {
  const MessagesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final provider = Provider.of<ChatProvider>(context);
    final messages = provider.messages;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(

          image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRu3FQM9guMHIkaprYg6oCmpv73cHavgixuqLfAQ0uMiA&usqp=CAU&ec=48665701"),
          fit: BoxFit.fitWidth,
        ),
      ),
      child: ListView.builder(
          padding: EdgeInsets.symmetric(
              horizontal: mediaQuery.width * .01,
              vertical: mediaQuery.height * .01),
          itemCount: messages.length,
          itemBuilder: (ctx, index) {
            final message = Message(
              role: messages[index].role,
              message: messages[index].message,
              time: messages[index].time,
            );

            return ChatBubble(message: message);
          }),
    );
  }
}
