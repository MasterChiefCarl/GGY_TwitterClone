import 'dart:async';
import 'package:random_string_generator/random_string_generator.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../service_locators.dart';
import '../models/user_account_model.dart';
import '../screens/authentication/auth_screen.dart';
import '../screens/home/home_screen.dart';
import 'navigation/navigation_service.dart';

class AuthController with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late StreamSubscription authStream;
  User? currentUser;
  FirebaseAuthException? error;
  String? errorS;
  bool working = true;
  final NavigationService nav = locator<NavigationService>();
  AuthController() {
    authStream = _auth.authStateChanges().listen(handleAuthUserChanges);
  }

  @override
  dispose() {
    authStream.cancel();
    super.dispose();
  }

  handleAuthUserChanges(User? event) {
    ///if no user exists, pop everything and show the AuthScreen
    if (event == null) {
      print('no logged in user');
      nav.popUntilFirst();
      nav.pushReplacementNamed(AuthScreen.route);
    }

    ///if a user exists, redirect to home immediately
    if (event != null) {
      print('logged in user');
      print(event.email);
      nav.pushReplacementNamed(HomeScreen.route);
    }
    error = null;
    working = false;
    currentUser = event;
    notifyListeners();
  }

  Future login(String email, password) async {
    try {
      working = true;
      notifyListeners();
      UserCredential? result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      ///there is no 'working=false' here as the handleAuthUserChanges does that for us
      return result;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      print(e.code);
      working = false;
      currentUser = null;
      error = e;
      notifyListeners();
    }
  }

  Future logout() async {
    working = true;
    notifyListeners();
    await _auth.signOut();
    working = false;
    notifyListeners();
    return;
  }

  Future register(
      {required String email,
      required String password,
      required String username,
      required String handle}) async {
    try {
      working = true;
      notifyListeners();
      UserCredential createdUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (createdUser.user != null) {
        AccUser userModel = AccUser(createdUser.user!.uid, username, email, '',
            handle, Timestamp.now(), Timestamp.now());

        errorS = "Created account Sucessfully! Logging In....";
        return FirebaseFirestore.instance
            .collection('users')
            .doc(userModel.uid)
            .set(userModel.json);
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      print(e.code);
      working = false;
      currentUser = null;
      error = e;
      notifyListeners();
    }
  }

  flush() {
    errorS = "";
    notifyListeners();
  }

  Future changeFogotPassword(String email) async {
    try {
      working = true;
      notifyListeners();
      await _auth.sendPasswordResetEmail(email: email);
      working = false;
      errorS = "Reset has been sent successfully! Please Check your Inbox <3";
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      print(e.message);
      print(e.code);
      working = false;
      currentUser = null;
      error = e;
      notifyListeners();
    }
  }
  Future updateHandle({required String uid, required String newHandle}){
    return FirebaseFirestore.instance.collection('users').doc(uid).update({
      'handle': newHandle
    });
  }
  Future updateUsername({required String uid, required String newUsername}){
    return FirebaseFirestore.instance.collection('users').doc(uid).update({
      'username': newUsername
    });
  }

  String showUserName ({required String uid}){
    
    return " ";
  }
  
}
