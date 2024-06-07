import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../model/diary_model.dart';

Future<int> getDiarySequence() async {
  var querySnapShot = await FirebaseFirestore.instance
      .collection('Sequence')
      .doc('DiarySequence')
      .get();
  var sequence = querySnapShot.data()!.values.first;
  return sequence;
}

Future<void> saveDiary(Diary diary) async {
  await FirebaseFirestore.instance.collection('DiaryData').add({
    "diary_idx": diary.diaryIdx,
    "diary_user_idx": diary.diaryUserIdx,
    "diary_date": diary.diaryDate,
    "diary_weather": diary.diaryWeather,
    "diary_image": diary.diaryImage,
    "diary_title": diary.diaryTitle,
    "diary_content": diary.diaryContent,
    "diary_lover_check": diary.diaryLoverCheck,
    "diary_state": diary.diaryState
  });
}

Future<List<Map<String, dynamic>>> getDiaryData() async {
  List<Map<String, dynamic>> results = [];

  var querySnapShot = await FirebaseFirestore.instance.collection('DiaryData').get();
  for(var doc in querySnapShot.docs){
    results.add(doc.data());
  }
  return results;
}

Future<void> uploadDiaryImage(XFile imageFile, String imageName) async {
  await FirebaseStorage.instance.ref('image/diary/$imageName').putFile(File(imageFile.path));
}

Future<Image> getDiaryImage(String path) async {
  var imageURL = await FirebaseStorage.instance.ref('image/diary/test').getDownloadURL();
  var resultImage = Image.network(imageURL);
  return resultImage;
}
