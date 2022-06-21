//start of post_model.dart

//import simple_moment
import 'dart:ffi';

import 'package:simple_moment/simple_moment.dart';

class Post {
  late String title;
  late String body;
  late String userId;
  late String postId;
  late String imageUrl;
  late DateTime created;
  late int likes;
  late int shares;
  late bool likedByUser;
  late bool sharedByUser;
  late String originalPoster;
  late String createdParsed;
  late Map<String, String> comments;

  Post(
      {DateTime? created,
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
      bool? sharedByUser}) {
    this.created = created ?? DateTime.now();
    this.title = title ?? "Post by ${userId}";
    this.body = body ?? "";
    this.userId = userId ?? "";
    this.postId = postId ?? "";
    this.imageUrl = imageUrl ?? "";
    this.likes = likes ?? 0;
    this.shares = shares ?? 0;
    this.likedByUser = likedByUser ?? false;
    this.sharedByUser = sharedByUser ?? false;
    this.originalPoster = originalPoster ?? "";

    this.createdParsed = createdParsed ??
        Moment.fromDateTime(DateTime.now()).format('hh:mm a MMMM dd, yyyy ');
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
}
