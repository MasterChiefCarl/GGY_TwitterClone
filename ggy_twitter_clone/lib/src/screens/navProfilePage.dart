import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ggy_twitter_clone/service_locators.dart';
import 'package:ggy_twitter_clone/src/controllers/auth_controllers.dart';
import 'package:ggy_twitter_clone/src/services/image_service.dart';
import 'package:ggy_twitter_clone/src/widgets/avatars.dart';
import 'package:google_fonts/google_fonts.dart';

class navProfilePage extends StatefulWidget {
  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<navProfilePage> {
  final AuthController _auth = locator<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child:
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          height: 50,
          width: 200,
          child: Center(
            child: Column(
              children: [
                Text('Profile',
                    style: GoogleFonts.quicksand(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff7b7b7b),
                    )),
              ],
            ),
          ),
        ),
        Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onLongPress: () {
                    _selectImgDialogue();
                  },
                  child: AvatarImage(
                    uid: FirebaseAuth.instance.currentUser!.uid,
                    radius: 40,
                  ),
                ),
                const SizedBox(
                  // width: double.infinity,
                  width: 15,
                  height: 15,
                ),
                UserNameFromDB(
                    uid: FirebaseAuth.instance.currentUser!.uid, fontSize: 25),
                EmailFromDB(
                    uid: FirebaseAuth.instance.currentUser!.uid, fontSize: 10),
              ],
            ),
          ),
        ),
        SizedBox(
        height: 350,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              ElevatedButton(
                onPressed: () {
                  _selectImgDialogue();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  fixedSize: const Size(240, 50),
                  primary: Colors.lightBlueAccent,
                  // : Theme.of(context).colorScheme.onSurface),
                ),
                child: Text(
                  'Change Profile Picture',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  fixedSize: const Size(240, 50),
                  primary: Colors.lightBlueAccent,
                  // : Theme.of(context).colorScheme.onSurface),
                ),
                child: Text(
                  'Change Username',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  fixedSize: const Size(240, 50),
                  primary: Colors.lightBlueAccent,
                  // : Theme.of(context).colorScheme.onSurface),
                ),
                child: Text(
                  'Change Email',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  fixedSize: const Size(240, 50),
                  primary: Colors.blue,
                  // : Theme.of(context).colorScheme.onSurface),
                ),
                child: Text(
                  'Change Password',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _logoutDialogue();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  fixedSize: const Size(240, 50),
                  primary: Colors.red,
                  // : Theme.of(context).colorScheme.onSurface),
                ),
                child: Text(
                  'Log Out',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    ));
  }

  Future<void> _logoutDialogue() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: SingleChildScrollView(
            child: Column(
              children: const <Widget>[
                Text('Would you like to approve logout sequence?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                print('Confirmed');
                _auth.logout();
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  Future<void> _selectImgDialogue() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Image Source'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextButton(onPressed: (){ImageService.updateProfileImagegallery();},child: const Text('Select Image From Galley')),
                TextButton(onPressed: (){ImageService.updateProfileImagecamera();},child: const Text('Select Image From Camera')),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
