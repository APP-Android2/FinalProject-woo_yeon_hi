import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:woo_yeon_hi/model/enums.dart';

import '../model/plan_model.dart';

Future<int> getPlanSequence() async {
  var querySnapShot = await FirebaseFirestore.instance
      .collection('Sequence')
      .doc('PlanSequence')
      .get();
  var sequence = querySnapShot.data()!.values.first;
  return sequence;
}

Future<void> setPlanSequence(int sequence) async {
  await FirebaseFirestore.instance
      .collection('Sequence')
      .doc('PlanSequence')
      .set({'value': sequence});
}

Future<void> addPlan(Plan plan) async {
  await FirebaseFirestore.instance.collection('PlanData').add({
    "plan_idx": plan.planIdx,
    "plan_title": plan.planTitle,
    "plan_date": plan.planDate,
    "plan_write_date": plan.planWriteDate,
    "plan_user_idx": plan.planUserIdx,
    "planed_array": plan.planedArray,
    "plan_state": plan.planState,
  });
}

Future<List<Plan>> getPlanData(int userIdx) async {
  List<Plan> result = [];

  var querySnapshot = await FirebaseFirestore.instance
      .collection('PlanData')
      .where('plan_user_idx', isEqualTo: userIdx)
      .where('plan_state', isEqualTo: PlanState.STATE_NORMAL.state)
      .get();

  var querySnapshot2 = await FirebaseFirestore.instance
      .collection('PlanData')
      .where('plan_user_idx', isEqualTo: userIdx)
      .where('plan_state', isEqualTo: PlanState.STATE_SUCCESS.state)
      .get();

  for (var doc in querySnapshot.docs) {
    result.add(Plan.fromData(doc.data()));
  }

  for (var doc in querySnapshot2.docs) {
    result.add(Plan.fromData(doc.data()));
  }

  return result;
}

Future<void> normalPlan(Plan plan) async {
  var querySnapshot = await FirebaseFirestore.instance
      .collection('PlanData')
      .where('plan_idx', isEqualTo: plan.planIdx)
      .get();

  await FirebaseFirestore.instance
      .collection('PlanData')
      .doc(querySnapshot.docs.first.id)
      .update({'plan_state': PlanState.STATE_SUCCESS.state});
}

Future<void> successPlan(Plan plan) async {
  var querySnapshot = await FirebaseFirestore.instance
      .collection('PlanData')
      .where('plan_idx', isEqualTo: plan.planIdx)
      .get();
  var document = querySnapshot.docs.first;
  document.reference.update({'plan_state': PlanState.STATE_NORMAL.state});
}

Future<void> deletePlan(Plan plan) async {
  var querySnapshot = await FirebaseFirestore.instance
      .collection('PlanData')
      .where('plan_idx', isEqualTo: plan.planIdx)
      .get();
  var document = querySnapshot.docs.first;
  document.reference.update({'plan_state': PlanState.STATE_DELETE.state});
}

Future<void> updatePlan(Plan plan, Map<String, dynamic> map) async {
  var querySnapshot = await FirebaseFirestore.instance
      .collection('PlanData')
      .where('plan_idx', isEqualTo: plan.planIdx)
      .get();
  var document = querySnapshot.docs.first;
  document.reference.update(map);
}
