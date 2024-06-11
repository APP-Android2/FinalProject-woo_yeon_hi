import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../model/user_model.dart';


Future<void> saveUserData(UserModel user) async {
  await FirebaseFirestore.instance.collection('userData').add({
    "user_idx": user.userIdx,
    "login_type": user.loginType,
    "user_account": user.userAccount,
    "user_nickname": user.userNickname,
    "user_birth": user.userBirth,
    "user_profileImage": user.userProfileImage,
    "lover_user_idx": user.loverUserIdx,
    "lover_nickname": user.loverNickname,
    "home_preset_type": user.homePresetType,
    "top_bar_type": user.topBarType,
    "profile_message": user.profileMessage,
    "alarms_allow": user.alarmsAllow,
    "app_lock_state": user.appLockState,
    "top_bar_activate": user.topBarActivate,
    "lock_password": user.lockPassword,
    "user_state": user.userState,
    "love_dDay": user.loveDday,
  });
}

Future<List<Map<String, dynamic>>> getUserData(
    int userIdx,
    int loginType,
    String userAccount,
    String userNickname,
    DateTime userBirth,
    String userProfileImage,
    int loverUserIdx,
    String loverNickname,
    int homePresetType,
    int topBarType,
    String profileMessage,
    bool alarmsAllow,
    int appLockState,
    bool topBarActivate,
    List lockPassword,
    int userState,
    DateTime loveDday)
    async {
      List<Map<String, dynamic>> results = [];

      Query<Map<String, dynamic>> query =
      FirebaseFirestore.instance.collection('UserData');

  var querySnapShot = await query.get();
  for (var doc in querySnapShot.docs) {
    results.add(doc.data());
  }

  return results;
}





Future<int> getUserSequence() async {
  var querySnapShot = await FirebaseFirestore.instance
      .collection('Sequence')
      .doc('UserSequence')
      .get();
  var sequence = querySnapShot.data()!.values.first;
  return sequence;
}

Future<void> setUserSequence(int sequence) async {
  await FirebaseFirestore.instance
      .collection('Sequence')
      .doc('UserSequence')
      .set({'value': sequence});
}

Future<void> uploadUserProfileImage(XFile imageFile, String imageName) async {
  await FirebaseStorage.instance
      .ref('image/userProfile/$imageName')
      .putFile(File(imageFile.path));
}

Future<Image> getDiaryImagePath(String path) async {
  var imageURL =
  await FirebaseStorage.instance.ref('image/userProfile/$path').getDownloadURL();
  var image = Image.network(
    imageURL,
    fit: BoxFit.cover,
  );
  return image;
}