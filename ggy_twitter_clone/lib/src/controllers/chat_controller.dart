import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ggy_twitter_clone/src/models/chat_message_model.dart';

class ChatController with ChangeNotifier {
  late StreamSubscription _chatSub;
  List<ChatMessage> chats = [];

  ChatController() {
    _chatSub = ChatMessage.currentChats().listen(chatUpdateHandler);
  }

  @override
  void dispose() {
    _chatSub.cancel();
    super.dispose();
  }

  chatUpdateHandler(List<ChatMessage> update) {
    for(ChatMessage message in update){
      if(message.hasNotSeenMessage(FirebaseAuth.instance.currentUser!.uid)){
        message.updateSeen(FirebaseAuth.instance.currentUser!.uid);
      }
    }
    chats = update;
    notifyListeners();
  }

  Future sendMessage({required String message}) {
    ChatMessage payload = ChatMessage(
      sentBy: FirebaseAuth.instance.currentUser!.uid,
      message: message,
    );
    return FirebaseFirestore.instance.collection('chats').add(payload.json);
  }
}
