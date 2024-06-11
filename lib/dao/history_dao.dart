import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:woo_yeon_hi/model/history_model.dart';

Future<int> getHistorySequence() async {
  var querySnapShot = await FirebaseFirestore.instance
      .collection('Sequence')
      .doc('HistorySequence')
      .get();
  var sequence = querySnapShot.data()!.values.first;
  return sequence;
}

Future<void> setHistorySequence(int sequence) async {
  await FirebaseFirestore.instance
      .collection('Sequence')
      .doc('HistorySequence')
      .set({'value': sequence});
}

Future<void> addHistory(History history) async {
  await FirebaseFirestore.instance.collection('HistoryData').add({
    "history_idx" : history.historyIdx,
    "history_map_idx" : history.historyMapIdx,
    "history_place_name" : history.historyPlaceName,
    "history_location" : history.historyLocation,
    "history_user_idx" : history.historyUserIdx,
    "history_title" : history.historyTitle,
    "history_date" : history.historyDate,
    "history_content" : history.historyContent,
    "history_image" : history.historyImage,
    "history_state" : history.historyState
  });
}

Future<List<History>> getHistory(int userIdx, int mapIdx) async {
  List<History> results = [];
  var querySnapshot = await FirebaseFirestore.instance.collection('HistoryData')
      .where('history_user_idx', isEqualTo: userIdx)
      .where('history_map_idx', isEqualTo: mapIdx)
      .get();

  for(var doc in querySnapshot.docs){
    results.add(History.fromData(doc.data()));
  }
  return results;
}

Future<void> uploadHistoryImage(XFile imageFile, String imageName) async {
  await FirebaseStorage.instance
      .ref('image/history/$imageName')
      .putFile(File(imageFile.path));
}

Future<Image> getHistoryImage(String? path) async {
  var imageURL =
  await FirebaseStorage.instance.ref('image/history/$path').getDownloadURL();
  var image = Image.network(
    imageURL,
    fit: BoxFit.cover,
  );
  return image;
}