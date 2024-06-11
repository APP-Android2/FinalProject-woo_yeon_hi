import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:woo_yeon_hi/model/ledger_model.dart';

class LedgerDao{

  // 가계부 시퀀스값 가져오기
  Future<int> getLedgerSequence() async {
    var querySnapShot = await FirebaseFirestore.instance.collection('Sequence').doc('LedgerSequence').get();
    var sequence = querySnapShot.data()!['value'];
    return sequence;
  }

  // 가계부 시퀀스값 업데이트
  Future<void> updateLedgerSequence(int LedgerSequence) async {
    await FirebaseFirestore.instance.collection('Sequence').doc('LedgerSequence').set({
      'value': LedgerSequence
    });
  }

  // 가계부 데이터를 Firestore에 저장하기
  Future<void> saveLedger(Ledger ledger) async {
    await FirebaseFirestore.instance.collection('Ledger').add(ledger.toMap());
  }

  // 가계부 데이터를 Firestore에서 가져오기
  Future<List<Ledger>> getLedgerData() async {
    var querySnapShot = await FirebaseFirestore.instance.collection('Ledger').get();
    return querySnapShot.docs.map((doc) => Ledger.fromMap(doc.data() as Map<String, dynamic>)).toList();
  }
}