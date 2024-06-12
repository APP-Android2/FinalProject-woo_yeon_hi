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