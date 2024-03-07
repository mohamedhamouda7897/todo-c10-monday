import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_c10_monday/firebase/firebase_functions.dart';
import 'package:todo_c10_monday/user_model.dart';

class MyProvider extends ChangeNotifier {
  User? firebaseUser;
  UserModel? userModel;

  MyProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      initUser();
    }
  }

  initUser() async {
    userModel = await FirebaseFunctions.readUser();
    notifyListeners();
  }
}
