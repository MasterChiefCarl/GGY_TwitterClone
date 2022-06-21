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

class PostController with ChangeNotifier {
  late StreamSubscription authStream;
  User? currentUser;
  FirebaseAuthException? error;
  String? errorS;
  bool working = true;
  final NavigationService nav = locator<NavigationService>();
  PostController() {}
}
