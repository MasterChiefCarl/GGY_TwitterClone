import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ggy_twitter_clone/src/models/user_account_model.dart';
import '../models/post_model.dart';

//import post_model.dart
final String firebaseUID = FirebaseAuth.instance.currentUser!.uid;
late String currentUser = UserNameFromDB(uid: firebaseUID).toString();

class navHomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class UserNameFromDB extends StatelessWidget {
  final String uid;
  const UserNameFromDB({required this.uid});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AccUser>(
        stream: AccUser.fromUidStream(uid: uid),
        builder: (context, AsyncSnapshot<AccUser?> snap) {
          if (snap.error != null || !snap.hasData) {
            return const Text('. . .');
          } else {
            currentUser = snap.data!.username.toString();
            return Text(snap.data!.username.toString());
          }
        });
  }
}

class _HomePageState extends State<navHomePage> {
  List<Post> posts = [
    Post(
      title: "My Post",
      body: "This is my post",
      userId: "@daryll_gomez",
      postId: "1",
      imageUrl: "https://picsum.photos/200/300",
      likes: 32,
    ),
    Post(
        title: "Another Post",
        body:
            "However, this post is longer than usual, because I will try to display as many words as I can. Yay! Does it wrap, or does it not wrap? Who knows? Why don't you check it out!",
        userId: "@carl_garces",
        postId: "2"),
    Post(
        userId: "@elon_musk",
        body: "Just fired 300 employees, still looking fresh",
        imageUrl:
            "https://cdn.vox-cdn.com/thumbor/b0PmAywJc1nLA9vUkyJo5-jFmBE=/1400x1400/filters:format(jpeg)/cdn.vox-cdn.com/uploads/chorus_asset/file/23633427/GettyImages_1395371342.jpg"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 25,
              width: 200,
              child: Center(
                child: Text('Home',
                    style: GoogleFonts.quicksand(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff7b7b7b),
                    )),
              ),
            ),
            Container(
              child: Center(
                  child: Column(children: [
                for (Post postIter in posts)
                  ListTile(
                      //leading: Text(postIter.userId.toString()),
                      title: Text(postIter.userId.toString()),
                      subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (postIter.sharedByUser == true)
                              Text("Shared from: " +
                                  postIter.originalPoster.toString()),
                            Text(postIter.body.toString()),
                            if (postIter.imageUrl != "")
                              Image.network(
                                postIter.imageUrl,
                                height: 400,
                                width: 400,
                              ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      posts.add(
                                        Post(
                                            sharedByUser: true,
                                            userId: currentUser,
                                            //CARL! FIND A WAY TO GET THE CURRRENT
                                            //LOGGED IN USER AND PUT IT HERE!
                                            //REPLACE currentUser with THE CURRENT
                                            //USER BY MAKING OR CALLING A FUNCTION
                                            originalPoster:
                                                postIter.userId.toString(),
                                            body: postIter.body.toString(),
                                            shares: postIter.shares + 1,
                                            likes: postIter.likes,
                                            imageUrl:
                                                postIter.imageUrl.toString()),
                                      );

                                      setState(() {});
                                    },
                                    icon: Icon(Icons.share)),
                                IconButton(
                                    onPressed: () {
                                      postIter.likePost();
                                      setState(() {});
                                    },
                                    icon: Icon(Icons.star))
                              ],
                            )
                          ]),
                      trailing: Column(
                        children: <Widget>[
                          Text(" "),
                          Text(postIter.likes.toString() + ' likes'),
                          Text(postIter.shares.toString() + ' shares'),
                        ],
                      )),
              ])),
            ),
          ]),
        ),
      ),
    );
  }
}
