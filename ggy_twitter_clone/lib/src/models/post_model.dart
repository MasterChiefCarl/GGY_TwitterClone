//start of post_model.dart

//import simple_moment
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

  Post({DateTime? created}) {
    created = DateTime.now();
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
      print('user liked this post');
    } else {
      likes--;
      print('user unliked this post');
    }
  }

  sharePost() {
    if (sharedByUser == false) {
      shares++;
      print("user shared the post");
    } else {
      shares--;
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
