import 'dart:core';
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
    "top_bar_activate": user.topBarActivate,
    "lock_password": user.lockPassword,
    "user_state": user.userState,
    "love_dDay": user.loveDday,
  });
}

Future<Map<String, dynamic>> getUserData(String userAccount) async {
  Map<String, dynamic> results = {};

  Query<Map<String, dynamic>> query = FirebaseFirestore.instance
      .collection('userData')
      .where('user_account', isEqualTo: userAccount);

  var querySnapShot = await query.get();
  for (var doc in querySnapShot.docs) {
    results = doc.data();
  }

  return results;
}

dynamic getSpecificUserData(String userAccount, String data) async {
  Map<String, dynamic> results = {};
  dynamic result;

  Query<Map<String, dynamic>> query = FirebaseFirestore.instance
      .collection('userData')
      .where('user_account', isEqualTo: userAccount);

  var querySnapShot = await query.get();
  for (var doc in querySnapShot.docs) {
    results = doc.data();
  }

  result = results[data];

  return result;
}

Future<void> updateUserData(String userAccount, String updateItem, var updateContent) async {
  var querySnapshot = await FirebaseFirestore.instance
      .collection('userData')
      .where('user_account', isEqualTo: userAccount)
      .get();

  var document = querySnapshot.docs.first;
  document.reference.update({updateItem: updateContent});
}

Future<void> deleteUserData(String userAccount) async {
  QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
      .collection('userData')
      .where('user_account', isEqualTo: userAccount)
      .get();

  for (DocumentSnapshot<Map<String, dynamic>> docSnapshot in querySnapshot.docs) {
    await docSnapshot.reference.delete();
  }
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

Future<Image> getProfileImagePath(String path) async {
  var imageURL = await FirebaseStorage.instance
      .ref('image/userProfile/$path')
      .getDownloadURL();
  var image = Image.network(
    imageURL,
    fit: BoxFit.cover,
  );
  return image;
}
