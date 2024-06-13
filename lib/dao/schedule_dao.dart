import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:woo_yeon_hi/model/schedule_model.dart';
import 'package:woo_yeon_hi/utils.dart';


// ScheduleSequence 로 부터 값을 받아옴
Future<int> getScheduleSequence() async {
  var querySnapShot = await FirebaseFirestore.instance
      .collection('Sequence')
      .doc('ScheduleSequence')
      .get();
  var sequence = querySnapShot.data()!.values.first;

  return sequence;
}

// Firebase - ScheduleSequence 에 저장
Future<void> setScheduleSequence(int sequence) async {
  await FirebaseFirestore.instance
      .collection('Sequence')
      .doc('ScheduleSequence')
      .set({'value' : sequence});
}

// Firebase - ScheduleData 에 저장
Future<void> saveSchedule(Schedule schedule) async {
  await FirebaseFirestore.instance.collection("ScheduleData").add({
    "schedule_idx" : schedule.scheduleIdx,
    "schedule_user_idx" : schedule.scheduleUserIdx,
    "schedule_start_date" : schedule.scheduleStartDate,
    "schedule_finish_date" : schedule.scheduleFinishDate,
    "schedule_start_time" : schedule.scheduleStartTime,
    "schedule_finish_time" : schedule.scheduleFinishTime,
    "schedule_title" : schedule.scheduleTitle,
    "schedule_color" : schedule.scheduleColor,
    "schedule_memo" : schedule.scheduleMemo,
    "schedule_state" : schedule.scheduleState,
  });
}

// Firebase - ScheduleDate 로 부터 List<Map<St, d>> 형태의 값을 받아옴
Future<List<Map<String, dynamic>>> getScheduleData() async {
  List<Map<String, dynamic>> results = [];

  var querySnapShot = await FirebaseFirestore.instance.collection('ScheduleData').get();

  for(var doc in querySnapShot.docs){
    results.add(doc.data());
  }

  return results;
}

// 요일에 값이 있는지 - 참거짓
Future<bool> isExistOnSchedule(DateTime date) async {
  // Datetime 객체를 날짜 저장 형식으로 변환
  var stringDate = dateToStringWithDay(date);
  var querySnapshot = await FirebaseFirestore.instance
      .collection('ScheduleData')
      .where('schedule_start_date', isEqualTo: stringDate)
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    return true;
  } else {
    return false;
  }
}