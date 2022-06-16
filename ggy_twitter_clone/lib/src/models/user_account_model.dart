import 'package:cloud_firestore/cloud_firestore.dart';

class AccUser {
  final String uid,handle, username, email, image;
  Timestamp created, updated;

  AccUser(this.uid, this.username, this.email, this.image, this.handle, this.created,
      this.updated);

  static AccUser fromDocumentSnap(DocumentSnapshot snap) {
    Map<String, dynamic> json = snap.data() as Map<String, dynamic>;

    return AccUser(
      snap.id,
      json['username'] ?? '',
      json['email'] ?? '',
      json['image'] ?? '',
      json['handle'] ?? '',
      json['created'] ?? Timestamp.now(),
      json['updated'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> get json => {
        'uid': uid,
        'username': username,
        'email': email,
        'image': image,
        'handle': handle,
        'created': created,
        'updated': updated
      };

  static Future<AccUser> fromUid({required String uid}) async {
    DocumentSnapshot snap =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return AccUser.fromDocumentSnap(snap);
  }

  static Stream<AccUser> fromUidStream({required String uid}) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .snapshots()
        .map(AccUser.fromDocumentSnap);
  }
  
}

