import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/user_model.dart';


Future<void> saveUser(UserModel user) async {
  await FirebaseFirestore.instance.collection('userData').add({
    "user_idx": user.userIdx,
    "login_type": user.loginType,
    "user_account": user.userAccount,
    "user_nickname": user.userNickname,
    "user_birth": user.userBirth,
    "user_profileImage": user.userProfileImage,
    "lover_user_idx": user.loverUserIdx,
    "lover_nickname": user.loverNickname,
    "home_preset_type": user.homePresetType,
    "top_bar_type": user.topBarType,
    "profile_message": user.profileMessage,
    "alarms_allow": user.alarmsAllow,
    "app_lock_state": user.appLockState,
    "top_bar_activate": user.topBarActivate,
    "lock_password": user.lockPassword,
    "user_state": user.lockPassword,
    "love_dDay": user.loveDday,
  });
}

Future<void> setUserIndexx(int idx) async {
  await FirebaseFirestore.instance
      .collection('Sequence')
      .doc('DiarySequence')
      .set({'value': idx});
}

// // 지금 뜨는 콘텐츠 정보를 가져온다.
// Future<int> getUserIndex() async {
//
//   var querySnapshot = await FirebaseFirestore.instance.collection('userData').where("user_idx").get();
//
//   List<int> results = List<int>.from(querySnapshot.docs[0].data()['hot_movie_idx']);
//
//   return results;
// }