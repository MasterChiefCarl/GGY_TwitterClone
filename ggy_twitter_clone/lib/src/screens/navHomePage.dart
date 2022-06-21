import 'package:cloud_firestore/cloud_firestore.dart';
// ignore_for_file: file_names, unused_import, unnecessary_late, use_key_in_widget_constructors, camel_case_types

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ggy_twitter_clone/src/models/user_account_model.dart';
import '../models/post_model.dart';

//import post_model.dart
final String firebaseUID = FirebaseAuth.instance.currentUser!.uid;

String? currUsr = FirebaseFirestore.instance
    .collection('users')
    .doc(FirebaseAuth.instance.currentUser!.uid)
    .get()
    .toString();

class navHomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<navHomePage> {
  Post tempPost = Post();
  List<Post> posts = [
    Post(
      title: "My Post",
      body: "This is my post",
      userId: currUsr,
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
        //add a new post button on the button right with dialog
        floatingActionButton: FloatingActionButton(onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    //show three text fields for title, body, and image url
                    content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                      TextField(
                        onChanged: (value) {
                          tempPost.title = value;
                        },
                        decoration: InputDecoration(
                          labelText: "Title",
                        ),
                      ),
                      TextField(
                        onChanged: (value) {
                          tempPost.body = value;
                        },
                        decoration: InputDecoration(
                          labelText: "Body",
                        ),
                      ),
                      TextField(
                        onChanged: (value) {
                          tempPost.imageUrl = value;
                        },
                        decoration: InputDecoration(
                          labelText: "Image URL",
                        ),
                      ),
                      RaisedButton(
                          child: Text("Post"),
                          onPressed: () {
                            //add the post to the list of posts
                            posts.add(Post(
                                body: tempPost.body.toString(),
                                title: tempPost.title.toString(),
                                imageUrl: tempPost.imageUrl.toString(),
                                userId: currUsr));
                            tempPost.clear();
                            setState(() {});
                            Navigator.pop(context);
                          })
                    ]));
              });
        }),
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
                              Text(postIter.createdParsed.toString()),
                              Text(""),
                              if (postIter.sharedByUser == true)
                                Text("Shared from: " +
                                    postIter.originalPoster.toString()),
                              Text(postIter.body.toString()),
                              Text(""),
                              if (postIter.imageUrl != "")
                                Image.network(
                                  alignment: Alignment.topLeft,
                                  postIter.imageUrl,
                                  height: 200,
                                  width: 300,
                                ),
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        posts.add(
                                          Post(
                                              sharedByUser: true,
                                              userId: currUsr,
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
                                      icon: Icon(Icons.star)),
                                  if (postIter.userId == currUsr) //FIX THIS!
                                    IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () {
                                          //show confirmation dialog before deleting
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text("Delete Post"),
                                                  content: Text(
                                                      "Are you sure you want to delete this post?"),
                                                  actions: [
                                                    FlatButton(
                                                      child: Text("Cancel"),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                    FlatButton(
                                                      child: Text("Delete"),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        posts.remove(postIter);
                                                        setState(() {});
                                                      },
                                                    ),
                                                  ],
                                                );
                                              });
                                        }),
                                  if (postIter.userId == currUsr)
                                    IconButton(
                                        onPressed: () {
                                          //show edit dialog
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text("Edit Post"),
                                                  content: TextField(
                                                    decoration: InputDecoration(
                                                      labelText: "Edit Post",
                                                    ),
                                                    onChanged: (value) {
                                                      postIter.body = value;
                                                    },
                                                  ),
                                                  actions: [
                                                    FlatButton(
                                                      child: Text("Cancel"),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                    FlatButton(
                                                      child: Text("Edit"),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        setState(() {});
                                                      },
                                                    ),
                                                  ],
                                                );
                                              });
                                        },
                                        icon: Icon(Icons.edit))
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
        ));
  }
}
