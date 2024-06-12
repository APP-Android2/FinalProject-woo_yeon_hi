import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:woo_yeon_hi/model/enums.dart';
import 'package:woo_yeon_hi/utils.dart';

import '../model/diary_model.dart';

Future<int> getDiarySequence() async {
  var querySnapShot = await FirebaseFirestore.instance
      .collection('Sequence')
      .doc('DiarySequence')
      .get();
  var sequence = querySnapShot.data()!.values.first;
  return sequence;
}

Future<void> setDiarySequence(int sequence) async {
  await FirebaseFirestore.instance
      .collection('Sequence')
      .doc('DiarySequence')
      .set({'value': sequence});
}

Future<void> addDiary(Diary diary) async {
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

Future<List<Map<String, dynamic>>> getDiaryData(
    int? user_idx,
    int filter_editor,
    int filter_sort,
    String filter_start,
    String filter_end) async {
  List<Map<String, dynamic>> results = [];

  Query<Map<String, dynamic>> query =
      FirebaseFirestore.instance.collection('DiaryData');

  if (user_idx != null) {
    // 내가 쓴 일기
    if (filter_editor == DiaryEditorState.EDITOR_USER.type) {
      query = query.where('diary_user_idx', isEqualTo: user_idx);
    }
    // 상대방이 쓴 일기
    else if (filter_editor == DiaryEditorState.EDITOR_LOVER.type) {
      query = query.where('diary_user_idx', isEqualTo: user_idx);
    }
  }

  // 기간 조회
  if (filter_start.isNotEmpty && filter_end.isNotEmpty) {
    query = query
        .where('diary_date', isGreaterThanOrEqualTo: filter_start)
        .where('diary_date', isLessThanOrEqualTo: filter_end);
  } else if (filter_start.isNotEmpty && filter_end.isEmpty) {
    query = query.where('diary_date', isGreaterThanOrEqualTo: filter_start);
  } else if (filter_start.isEmpty && filter_end.isNotEmpty) {
    query = query.where('diary_date', isLessThanOrEqualTo: filter_end);
  }

  // 정렬 조건
  if (filter_sort == DiarySortState.SORT_ASC.type) {
    query = query.orderBy('diary_idx', descending: false);
  } else {
    query = query.orderBy('diary_idx', descending: true);
  }

  var querySnapShot = await query.get();
  for (var doc in querySnapShot.docs) {
    results.add(doc.data());
  }

  return results;
}

Future<void> uploadDiaryImage(XFile imageFile, String imageName) async {
  await FirebaseStorage.instance
      .ref('image/diary/$imageName')
      .putFile(File(imageFile.path));
}

Future<Image> getDiaryImage(String path) async {
  var imageURL =
      await FirebaseStorage.instance.ref('image/diary/$path').getDownloadURL();
  var image = Image.network(
    imageURL,
    fit: BoxFit.cover,
  );
  return image;
}

Future<void> readDiary(Diary diary) async {
  var querySnapshot = await FirebaseFirestore.instance
      .collection('DiaryData')
      .where('diary_idx', isEqualTo: diary.diaryIdx)
      .get();
  var document = querySnapshot.docs.first;
  document.reference.update({'diary_lover_check': true});
}

Future<bool> isExistOnDate(DateTime date) async {
  var stringDate = dateToString(date);
  var querySnapshot = await FirebaseFirestore.instance
      .collection('DiaryData')
      .where('diary_date', isEqualTo: stringDate)
      .get();
  if (querySnapshot.docs.isNotEmpty) {
    return true;
  } else {
    return false;
  }
}
