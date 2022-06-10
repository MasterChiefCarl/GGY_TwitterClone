
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageService {
  static updateProfileImagegallery() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? uncroppedImage =
          await picker.pickImage(source: ImageSource.gallery);
      if (uncroppedImage != null) {
        final CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: uncroppedImage.path,
          uiSettings: [
            AndroidUiSettings(
                showCropGrid: true,
                toolbarTitle: 'Crop Image',
                initAspectRatio: CropAspectRatioPreset.square,
                hideBottomControls: true,
                lockAspectRatio: true),
            IOSUiSettings(
              title: 'Crop Image',
            ),
          ],
        );
        if (croppedFile != null) {
          final storageRef = FirebaseStorage.instance.ref();
          final profileRef = storageRef.child(
              'profiles/${FirebaseAuth.instance.currentUser!.uid}/${croppedFile.path.split('/').last}');
          print(profileRef.fullPath);
          File file = File(croppedFile.path);
          print(croppedFile.path);
          TaskSnapshot result = await profileRef.putFile(file);
          String publicUrl = await profileRef.getDownloadURL();
          print(publicUrl);
          FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update({'image': publicUrl});
          print(result);
        }
      } else {}
    } catch (e) {
      print(e);
    }
  }
  static updateProfileImagecamera() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? uncroppedImage =
          await picker.pickImage(source: ImageSource.camera);
      if (uncroppedImage != null) {
        final CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: uncroppedImage.path,
          uiSettings: [
            AndroidUiSettings(
                showCropGrid: true,
                toolbarTitle: 'Crop Image',
                initAspectRatio: CropAspectRatioPreset.square,
                hideBottomControls: true,
                lockAspectRatio: true),
            IOSUiSettings(
              title: 'Crop Image',
            ),
          ],
        );
        if (croppedFile != null) {
          final storageRef = FirebaseStorage.instance.ref();
          final profileRef = storageRef.child(
              'profiles/${FirebaseAuth.instance.currentUser!.uid}/${croppedFile.path.split('/').last}');
          print(profileRef.fullPath);
          File file = File(croppedFile.path);
          print(croppedFile.path);
          TaskSnapshot result = await profileRef.putFile(file);
          String publicUrl = await profileRef.getDownloadURL();
          print(publicUrl);
          FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update({'image': publicUrl});
          print(result);
        }
      } else {}
    } catch (e) {
      print(e);
    }
  }
}
