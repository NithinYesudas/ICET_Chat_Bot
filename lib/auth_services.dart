import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:illahia_chat_bot/utils/accessory_widgets.dart';

class AuthServices{
  static Future<bool> login(String email, String password, BuildContext context) async{
    bool isSuccessful = true;
    final auth = FirebaseAuth.instance;
    try{
      await auth.signInWithEmailAndPassword(email: email, password: password);

    }on FirebaseAuthException catch(e){
      isSuccessful = false;
      AccessoryWidgets.snackBar(e.code, context);
    }catch(e){
      isSuccessful = false;
      AccessoryWidgets.snackBar("An error occurred", context);
    }
    return isSuccessful;
  }

  static Future<bool> signUp(String email, String password, BuildContext context) async{
    bool isSuccessful = true;
    final auth = FirebaseAuth.instance;
    try{
      await auth.createUserWithEmailAndPassword(email: email, password: password);
    }on FirebaseAuthException catch(e){
      isSuccessful = false;
      AccessoryWidgets.snackBar(e.code, context);
    }catch(e){
      isSuccessful = false;
      AccessoryWidgets.snackBar("An error occurred", context);
    }
    return isSuccessful;
  }
}