import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/post_model.dart';
//import post_model.dart

class navHomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
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
                            Text(postIter.body.toString()),
                            if (postIter.imageUrl != "")
                              Image.network(
                                postIter.imageUrl,
                                height: 400,
                                width: 400,
                              ),
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
