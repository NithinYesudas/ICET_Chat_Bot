import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import '../chat_widgets/messages_list.dart';
import '../providers/chat_provider.dart';
import '../utils/custom_colors.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final provider = Provider.of<ChatProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async{
               await FirebaseAuth.instance.signOut();
              },
              icon: const Icon(
                Ionicons.log_out_outline,
                color: Colors.white,
              ))
        ],
        leading: Padding(
          padding: EdgeInsets.only(
              left: mediaQuery.width * .03,
              top: mediaQuery.width * .02,
              bottom: mediaQuery.width * .02),
          child: const CircleAvatar(
            radius: 6,
            backgroundImage: NetworkImage(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRu3FQM9guMHIkaprYg6oCmpv73cHavgixuqLfAQ0uMiA&usqp=CAU&ec=48665701"),
          ),
        ),
        elevation: 5,
        backgroundColor: CustomColors.lightAccent,
        title: Text(
          "LIZA",
          style: GoogleFonts.nunitoSans(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 22),
        ),
      ),
      body: Column(
        children: [
          const Expanded(child: MessagesList()),
          Container(
            
            height: mediaQuery.height * .1,
            padding: EdgeInsets.symmetric(horizontal: mediaQuery.width * .01),
            child: Row(
              children: [
                SizedBox(
                  width: mediaQuery.width * .8,
                  child: TextField(
                    controller: _controller,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Ionicons.lock_closed_outline,
                          color: CustomColors.lightAccent,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 5),
                        hintText: "Message",
                        hintStyle: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w600, color: Colors.black38),
                        fillColor: Colors.black12,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none)),
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.only(
                            left: 20, right: 15, bottom: 15, top: 15),
                        backgroundColor: CustomColors.lightAccent,
                        shape: const CircleBorder()),
                    onPressed: () {
                      provider.sendMessage(_controller.text);

                      _controller.clear();
                    },
                    child: const Icon(
                      Ionicons.send_sharp,
                      color: Colors.white,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
