import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:woo_yeon_hi/model/schedule_model.dart';

Future<void> addTest() async {
  await FirebaseFirestore.instance.collection('test').add({
    'data1' : 100,
    'data2' : 11.11,
    'data3' : '안녕하세요'
  });
}

Future<void> printTest() async {
  var result = await FirebaseFirestore.instance.collection('test').get();

  for(var doc in result.docs){
    var map = doc.data();
    print("firebase test : $map");
  }
}

Future<int> getScheduleSequence() async {
  var querySnapShot = await FirebaseFirestore.instance
      .collection('Sequence')
      .doc('ScheduleSequence')
      .get();
  var sequence = querySnapShot.data()!.values.first;

  return sequence;
}

Future<void> setScheduleSequence(int sequence) async {
  await FirebaseFirestore.instance
      .collection('Sequence')
      .doc('ScheduleSequence')
      .set({'value' : sequence});
}

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

Future<List<Map<String, dynamic>>> getScheduleData() async {
  List<Map<String, dynamic>> results = [];

  var querySnapShot = await FirebaseFirestore.instance.collection('ScheduleData').get();

  for(var doc in querySnapShot.docs){
    results.add(doc.data());
  }

  return results;
}