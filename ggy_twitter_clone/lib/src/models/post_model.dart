//start of post_model.dart

//import simple_moment
import 'dart:ffi';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:ggy_twitter_clone/src/widgets/avatars.dart';
import 'package:simple_moment/simple_moment.dart';

class Post {
  late String title;
  late String body;
  late String userId;
  late String postId;
  late String imageUrl;
  late DateTime created;
  late String posterUid;
  late int likes;
  late int shares;
  late bool likedByUser;
  late bool sharedByUser;
  late String originalPoster;
  late String createdParsed;
  late Map<String, String> comments;
  late Widget newSharer;

  Post(
      {DateTime? created,
      String? posterUid,
      String? title,
      String? body,
      String? userId,
      String? postId,
      String? imageUrl,
      String? originalPoster,
      String? createdParsed,
      int? likes,
      int? shares,
      bool? likedByUser,
      bool? sharedByUser,
      Widget? newSharer}) {
    this.created = created ?? DateTime.now();
    this.posterUid = posterUid ?? "Unknown";
    this.title = title ?? "This is a shared post";
    this.body = body ?? "";
    this.userId = userId ?? "";
    this.postId = postId ?? Random.secure().nextInt(8797797).toString();
    this.imageUrl = imageUrl ?? "";
    this.likes = likes ?? 0;
    this.shares = shares ?? 0;
    this.likedByUser = likedByUser ?? false;
    this.sharedByUser = sharedByUser ?? false;
    this.originalPoster = originalPoster ?? "";
    this.newSharer = newSharer ?? const Text("");

    this.createdParsed = createdParsed ??
        Moment.fromDateTime(DateTime.now()).format('hh:mm a MMMM dd, yyyy ');
    _pushToFirestore();
  }

  String get parsedDate {
    return Moment.fromDateTime(created).format('hh:mm a MMMM dd, yyyy ');
  }

  log() {
    print('title: $title');
    print('body: $body');
    print('userId: $userId');
    print('postId: $postId');
    print('imageUrl: $imageUrl');
    print('created: $created');
  }

  attachImage(String imageUrl) {
    this.imageUrl = imageUrl;
  }

  likePost() {
    if (likedByUser == false) {
      likes++;
      likedByUser = true;
      print('user liked this post');
    } else {
      likes--;
      likedByUser = false;
      print('user unliked this post');
    }
  }

  clear() {
    title = "";
    body = "";
    imageUrl = "";
  }

  sharePost() {
    if (sharedByUser == false) {
      shares++;
      sharedByUser = true;
      print("user shared the post");
    } else {
      shares--;
      sharedByUser = false;
      print("user unshared the post");
    }
  }

  void _pushToFirestore() async {
    await FirebaseFirestore.instance
        .collection("posts")
        .doc(this.postId)
        .set(this.toJson());
  }

  toJson() {
    return {
      'title': title,
      'body': body,
      'userId': userId,
      'postId': postId,
      'imageUrl': imageUrl,
      'created': created.toIso8601String(),
    };
  }

  updatePost(String postUpdate, String titleUpdate) {
    if (postUpdate.isNotEmpty) {
      body = postUpdate;
    }
    if (titleUpdate.isNotEmpty) {
      title = titleUpdate;
    }
    print("post updated with $title and $body");
  }

//function that pushes the post to firestore
  Future<void> pushPost(String? postId, String title, String body,
      String userId, String imageUrl, String posterUid) async {
    await FirebaseFirestore.instance.collection('posts').doc(postId).set({
      'title': title,
      'body': body,
      'userId': userId,
      'postId': postId ?? "",
      'imageUrl': imageUrl,
      'created': DateTime.now().toIso8601String(),
      'posterUid': posterUid,
      'likes': 0,
      'shares': 0,
      'likedByUser': false,
      'sharedByUser': false,
      'originalPoster': posterUid,
      'createdParsed':
          Moment.fromDateTime(created).format('hh:mm a MMMM dd, yyyy '),
      'comments': {},
    });
  }
}
