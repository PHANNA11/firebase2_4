import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FireStoreDatabase {
  String? downlaodURL;
  Future downloadURLFromStorage() async {
    downlaodURL = await FirebaseStorage.instance
        .ref()
        .child(
            '/image/data/user/0/com.example.firebase_auth2_4/cache/file_picker')
        .child('LCC-.png')
        .getDownloadURL();
    debugPrint('Link :${downlaodURL.toString()}');
    return downlaodURL;
  }

  Future getData() async {
    try {
      debugPrint('Link2:${downloadURLFromStorage()}');
      return downloadURLFromStorage();
    } catch (e) {
      debugPrint('Error :$e');
      return null;
    }
  }
}
