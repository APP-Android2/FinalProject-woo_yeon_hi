

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:woo_yeon_hi/model/photo_map_model.dart';

Future<int> getPhotoMapSequence() async {
  var querySnapShot = await FirebaseFirestore.instance
      .collection('Sequence')
      .doc('PhotoMapSequence')
      .get();
  var sequence = querySnapShot.data()!.values.first;
  return sequence;
}

Future<void> setPhotoMapSequence(int sequence) async {
  await FirebaseFirestore.instance
      .collection('Sequence')
      .doc('PhotoMapSequence')
      .set({'value': sequence});
}

Future<void> addPhotoMap(PhotoMap photoMap) async {
  await FirebaseFirestore.instance.collection('PhotoMapData').add({
    "map_idx": photoMap.mapIdx,
    "map_user_idx": photoMap.mapUserIdx,
    "map_type": photoMap.mapType,
    "map_name": photoMap.mapName,
    "map_snapshot": photoMap.mapSnapshot,
    "map_state": photoMap.mapState,
  });
}

Future<List<PhotoMap>> getPhotoMap(int userIdx) async {
  List<PhotoMap> results = [];
  var querySnapshot = await FirebaseFirestore.instance.collection('PhotoMapData')
      .where('map_user_idx', isEqualTo: userIdx)
      .get();

  for(var doc in querySnapshot.docs){
    results.add(PhotoMap.fromData(doc.data()));
  }
  return results;
}

Future<void> uploadPhotoMapImage(Uint8List data, String imageName) async {
  await FirebaseStorage.instance
      .ref('image/photoMap/$imageName')
      .putData(data);
}

Future<Image> getPhotoMapImage(String? path) async {
  var imageURL =
  await FirebaseStorage.instance.ref('image/photoMap/$path').getDownloadURL();
  var image = Image.network(
    imageURL,
    fit: BoxFit.cover,
  );
  return image;
}

Future<void> changePhotoMapName(int idx, String newName) async {
  var querySnapshot = await FirebaseFirestore.instance
      .collection('PhotoMapData')
      .where('map_idx', isEqualTo: idx)
      .get();
  var document = querySnapshot.docs.first;
  document.reference.update({'map_name': newName});
}

Future<void> deletePhotoMap(int idx) async {
  var querySnapshot = await FirebaseFirestore.instance
      .collection('PhotoMapData')
      .where('map_idx', isEqualTo: idx)
      .get();
  var document = querySnapshot.docs.first;
  document.reference.delete();
}




