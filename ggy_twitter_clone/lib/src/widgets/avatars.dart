import 'package:flutter/material.dart';
import 'package:ggy_twitter_clone/src/models/user_account_model.dart';

class UserNameFromDB extends StatelessWidget {
  final String uid;
  final double fontSize;
  const UserNameFromDB({required this.uid, Key? key, this.fontSize = 15})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AccUser>(
        stream: AccUser.fromUidStream(uid: uid),
        builder: (context, AsyncSnapshot<AccUser?> snap) {
          if (snap.error != null || !snap.hasData) {
            return const Text('. . .');
          } else {
            return Text(snap.data!.username,
                style: TextStyle(fontSize: fontSize));
          }
        });
  }
}

class UserNameShareFromDB extends StatelessWidget {
  final String uid;
  final double fontSize;
  const UserNameShareFromDB({required this.uid, Key? key, this.fontSize = 15})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AccUser>(
        stream: AccUser.fromUidStream(uid: uid),
        builder: (context, AsyncSnapshot<AccUser?> snap) {
          if (snap.error != null || !snap.hasData) {
            return const Text('. . .');
          } else {
            return Text("@" + snap.data!.username,
                style:
                    TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold));
          }
        });
  }
}

class EmailFromDB extends StatelessWidget {
  final String uid;
  final double fontSize;
  const EmailFromDB({required this.uid, Key? key, this.fontSize = 15})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AccUser>(
        stream: AccUser.fromUidStream(uid: uid),
        builder: (context, AsyncSnapshot<AccUser?> snap) {
          if (snap.error != null || !snap.hasData) {
            return const Text('. . .');
          } else {
            return Text(snap.data!.email, style: TextStyle(fontSize: fontSize));
          }
        });
  }
}

class HandleFromDB extends StatelessWidget {
  final String uid;
  final double fontSize;
  const HandleFromDB({required this.uid, Key? key, this.fontSize = 15})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AccUser>(
        stream: AccUser.fromUidStream(uid: uid),
        builder: (context, AsyncSnapshot<AccUser?> snap) {
          if (snap.error != null || !snap.hasData) {
            return const Text('. . .');
          } else {
            return Text(snap.data!.handle,
                style: TextStyle(fontSize: fontSize));
          }
        });
  }
}

class AvatarImage extends StatelessWidget {
  final String uid;
  final double radius;
  const AvatarImage({required this.uid, this.radius = 22, Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AccUser>(
        stream: AccUser.fromUidStream(uid: uid),
        builder: (context, AsyncSnapshot<AccUser?> snap) {
          if (snap.error != null || !snap.hasData) {
            return CircleAvatar(
              radius: radius,
              backgroundColor: Colors.grey,
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: radius * .95,
              ),
            );
          } else {
            if (snap.data!.image.isEmpty) {
              return CircleAvatar(
                radius: radius,
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: radius * .95,
                ),
              );
            } else {
              return CircleAvatar(
                radius: radius,
                backgroundColor: Colors.grey,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Image.network(snap.data!.image),
                ),
              );
            }
          }
        });
  }
}


// class SquareAvatarImage extends StatelessWidget {
//   final String uid;
//   final double radius;
//   const SquareAvatarImage({required this.uid, this.radius = 50, Key? key})
//       : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<AccUser>(
//         stream: AccUser.fromUidStream(uid: uid),
//         builder: (context, AsyncSnapshot<AccUser?> snap) {
//           if (snap.error != null || !snap.hasData) {
//             return CircleAvatar(
//               radius: radius,
//               backgroundColor: Colors.grey,
//               child: Icon(
//                 Icons.person,
//                 color: Colors.white,
//                 size: radius * .95,
//               ),
//             );
//           } else {
//             if (snap.data!.image.isEmpty) {
//               return CircleAvatar(
//                 radius: radius,
//                 backgroundColor: Colors.grey,
//                 child: Icon(
//                   Icons.person,
//                   color: Colors.white,
//                   size: radius * .95,
//                 ),
//               );
//             } else {
//               return CircleAvatar(
//                 radius: radius,
//                 backgroundColor: Colors.grey,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(50.0),
//                   child: Image.network(snap.data!.image),
//                 ),
//               );
//             }
//           }
//         });
//   }
// }
