import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:woo_yeon_hi/dao/user_dao.dart';

import '../model/user_model.dart';

Future<bool> saveCodeData(String code, String codeType, int idx) async {
  var querySnapshot = await FirebaseFirestore.instance
      .collection('CodeData')
      .where('code', isEqualTo: code)
      .get();
  if(querySnapshot.docs.isNotEmpty){
    return false;
  } else{
    await FirebaseFirestore.instance.collection('CodeData').add({
      'code': code,
      'host_idx': idx,
      'code_state': false
    });
    return true;
  }
}

// Future<void> updateCodeData(String updateCode, String codeType) async {
//   var querySnapshot = await FirebaseFirestore.instance
//       .collection('CodeData')
//       .get();
//
//   var document = querySnapshot.docs.first;
//   document.reference.update({codeType: updateCode});
// }

Future<void> deleteCodeData(String code) async {
  QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
      .collection('CodeData')
      .where('code', isEqualTo: code)
      .get();

  for (DocumentSnapshot<Map<String, dynamic>> docSnapshot in querySnapshot.docs) {
    await docSnapshot.reference.delete();
  }
}

Future<bool> isValidCodeData(String code) async {
  var querySnapshot = await FirebaseFirestore.instance
      .collection('CodeData')
      .where('code', isEqualTo: code)
      .get();

// 문서가 존재하고, code_state가 false인지 확인
  if (querySnapshot.docs.isNotEmpty) {
    print("존재하는 문서");

    for (var doc in querySnapshot.docs) {
      if (doc.data()['code_state'] == true) {
        print("true리턴");

        return true;
      }
    }
  }
  print("false리턴");

  return false;
}

Future<void> saveUserInfo(String userAccount) async {
  try {
    var userIdx = await getUserSequence() + 1;
    await setUserSequence(userIdx);
    await FirebaseFirestore.instance.collection('userData').add({
      'user_idx': userIdx,
      'user_account': userAccount,
      'user_nickname': "기본닉네임"
    });
  } catch (e) {
    print("Error writing document: $e");
  }
}


Future<void> saveLoverIdx(int userIdx, int loverIdx) async {
  try {
    // userAccount 필드와 일치하는 문서 검색
    var querySnapshot = await FirebaseFirestore.instance.collection('userData')
        .where('user_account', isEqualTo: userIdx)
        .get();

    // 문서가 존재하는 경우 업데이트
    if (querySnapshot.docs.isNotEmpty) {
      for (var doc in querySnapshot.docs) {
        // 문서 ID 가져오기
        String docId = doc.id;

        // 새로운 필드를 추가하여 문서 업데이트
        await FirebaseFirestore.instance.collection('userData').doc(docId).update({'lover_idx': loverIdx});
      }
      print('문서 업데이트 완료');
    } else {
      print('해당 user_account를 가진 문서가 없습니다');
    }
  } catch (e) {
    print('문서 업데이트 중 오류 발생: $e');
  }
}

dynamic getSpecificCodeData(String code, String dataField) async {
  Map<String, dynamic> results = {};
  dynamic result;

  Query<Map<String, dynamic>> query = FirebaseFirestore.instance
      .collection('CodeData')
      .where('code', isEqualTo: code);

  var querySnapShot = await query.get();
  for (var doc in querySnapShot.docs) {
    results = doc.data();
  }

  result = results[dataField];

  return result;
}


Future<void> updateCode(String code, int userIdx) async {
  try {
    // userAccount 필드와 일치하는 문서 검색
    var querySnapshot = await FirebaseFirestore.instance.collection('CodeData')
        .where('code', isEqualTo: code)
        .get();

    // 문서가 존재하는 경우 업데이트
    if (querySnapshot.docs.isNotEmpty) {
      for (var doc in querySnapshot.docs) {
        // 문서 ID 가져오기
        String docId = doc.id;

        // 새로운 필드를 추가하여 문서 업데이트
        await FirebaseFirestore.instance.collection('CodeData').doc(docId).update({'code_state': true});
        await FirebaseFirestore.instance.collection('CodeData').doc(docId).update({'guest_idx': userIdx});
      }
      print('문서 업데이트 완료');
    } else {
      print('해당 userAccount를 가진 문서가 없습니다');
    }
  } catch (e) {
    print('문서 업데이트 중 오류 발생: $e');
  }
}


// dynamic getMyNickname(int loverIdx) async {
//   Map<String, dynamic> results = {};
//   dynamic result;
//
//   Query<Map<String, dynamic>> query = FirebaseFirestore.instance
//       .collection('userData')
//       .where('user_idx', isEqualTo: loverIdx);
//
//   var querySnapShot = await query.get();
//   for (var doc in querySnapShot.docs) {
//     results = doc.data();
//   }
//
//   result = results['lover_nickname'];
//
//   return result;
// }