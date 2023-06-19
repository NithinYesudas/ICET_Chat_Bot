import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:illahia_chat_bot/providers/chat_provider.dart';
import 'package:illahia_chat_bot/screens/home_screen.dart';
import 'package:illahia_chat_bot/screens/login_screen.dart';
import 'package:illahia_chat_bot/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChatProvider>(
      create: (context) => ChatProvider(),
      builder: (context,child) {
        return MaterialApp(

              debugShowCheckedModeBanner: false,

          home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SplashScreen();
                } else if (snapshot.hasData) {
                  return  HomeScreen();
                } else {
                  return const LoginScreen();
                }
              })
        );
      }
    );
  }
}
