import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils.dart';

Future<bool> isExistOnSummaryDate(DateTime date) async {
  var stringDate = dateToString(date);
  var querySnapshotDiary = await FirebaseFirestore.instance
      .collection('DiaryData')
      .where('diary_date', isEqualTo: stringDate)
      .get();

  var querySnapshotHistory = await FirebaseFirestore.instance
      .collection('HistoryData')
      .where('history_date', isEqualTo: stringDate)
      .get();

  var querySnapshotLedger = await FirebaseFirestore.instance
      .collection('Ledger')
      .where('ledger_date', isEqualTo: stringDate)
      .get();

  var querySnapshotCalendar = await FirebaseFirestore.instance
      .collection('ScheduleData')
      .where('schedule_start_date', isEqualTo: stringDate)
      .get();

  if (querySnapshotDiary.docs.isNotEmpty || querySnapshotHistory.docs.isNotEmpty || querySnapshotLedger.docs.isNotEmpty || querySnapshotCalendar.docs.isNotEmpty) {
    return true;
  } else {
    return false;
  }
}

Future<bool> saveAuthCodeData(String code, int idx) async {
  var querySnapshot = await FirebaseFirestore.instance
      .collection('CodeData')
      .where('code', isEqualTo: code)
      .get();
  if(querySnapshot.docs.isNotEmpty){
    return false;
  } else{
    await FirebaseFirestore.instance.collection('CodeData').add({
      'auth_code': code,
      'user_idx': idx,
    });
    return true;
  }
}

Future<String?> isVerifiedCode(String code, int idx) async {
  Map<String, dynamic> results = {};
  String? result;

  try {
    Query<Map<String, dynamic>> query = FirebaseFirestore.instance
        .collection('CodeData')
        .where('auth_code', isEqualTo: code);
    var querySnapShot = await query.get();
    for (var doc in querySnapShot.docs) {
      results = doc.data();
    }
    if(results['user_idx']==idx){
      result = results['auth_code'];
    } else {
      result = null;
    }
  } catch (error) {
    result = null;
  }

  return result;
}

Future<void> deleteAuthCodeData(int userIdx) async {
  QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
      .collection('CodeData')
      .where('user_idx', isEqualTo: userIdx)
      .get();

  for (DocumentSnapshot<Map<String, dynamic>> docSnapshot in querySnapshot.docs) {
    await docSnapshot.reference.delete();
  }
}