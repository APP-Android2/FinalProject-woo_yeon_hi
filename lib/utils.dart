import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/provider/login_register_provider.dart';

import 'dao/user_dao.dart';
import 'dialogs.dart';

/// Datetime 객체를 날짜 저장 형식으로 변환합니다.
String dateToString(DateTime date) {
  String year = DateFormat('yyyy').format(date);
  String month = date.month.toString().padLeft(2, " ");
  String day = date.day.toString().padLeft(2, " ");
  return '$year.$month.$day.';
}

/// 'yyyy.MM.dd.' 형태의 문자열 날짜 데이터를 DateTime으로 변환합니다.
DateTime stringToDate(String date) {
  List<String> splitDate = date.split(".");
  String year = splitDate[0];
  String month = splitDate[1].replaceAll(" ", "");
  String day = splitDate[2].replaceAll(" ", "");

  return DateTime(int.parse(year), int.parse(month), int.parse(day));
}

/// Datetime 객체를 날짜 저장 형식으로 변환합니다.
/// 날짜 뒤 요일이 추가된 형식입니다. (E)
String dateToStringWithDay(DateTime date) {
  String selectedDay = DateFormat('yyyy. M. dd.(E)', 'ko_KR').format(date);
  return '$selectedDay';
}

String listToString(List<int> list) {
  return list.join(',');
}

List<int> stringToList(String input) {
  List<int> result = [];

  List<String> parts = input.split(',');
  for (String part in parts) {
    result.add(int.parse(part.trim()));
  }

  return result;
}

/// FlutterSecureStorage에 저장된 value객체(String)를 int타입으로 변환합니다.
int stringToInt(String value) {
  int number = 0;
  try {
    number = int.parse(value);
  } catch (e) {
    print('Error: $e');
  }
  return number;
}

/// signIn 과정에서 호출 시 중간 저장된 DB데이터를 삭제 후 로그인 화면으로 이동합니다.
void signOut(BuildContext context) async {
  switch (Provider.of<UserProvider>(context, listen: false).loginType) {
    case 1:
      await GoogleSignIn().signOut();
      break;
    case 2:
      try {
        await UserApi.instance.logout();
        print('로그아웃 성공, SDK에서 토큰 삭제');
      } catch (error) {
        print('로그아웃 실패, SDK에서 토큰 삭제 $error');
      }
      break;
    case 0:
      break;
  }
  await deleteUserData(
      Provider.of<UserProvider>(context, listen: false).userIdx);
  Provider.of<UserProvider>(context, listen: false).setLoginType(0);
  showBlackToast("등록이 취소되었습니다.");
}

Future<Map<String, dynamic>> fetchUserData() async {
  const storage = FlutterSecureStorage();
  final userIdx = stringToInt((await storage.read(key: "userIdx")) ?? "");
  final userAccount = (await storage.read(key: "userAccount")) ?? "";
  final alarmsAllow = await getSpecificUserData(userIdx, 'alarms_allow') ?? false;
  final appLockState = await getSpecificUserData(userIdx, 'app_lock_state') ?? 0;
  final homePresetType = await getSpecificUserData(userIdx, 'home_preset_type') ?? 0;
  final loginType = await getSpecificUserData(userIdx, 'login_type') ?? 0;
  final loveDday = await getSpecificUserData(userIdx, 'love_dDay') ?? "${DateTime.now()}";
  final loverIdx = await getSpecificUserData(userIdx, 'lover_idx') ?? 0;
  final profileMessage = await getSpecificUserData(userIdx, 'profile_message') ?? "";
  final topBarActivate = await getSpecificUserData(userIdx, 'top_bar_activate') ?? false;
  final topBarType = await getSpecificUserData(userIdx, 'top_bar_type') ?? 0;
  final userBirth = await getSpecificUserData(userIdx, 'user_birth') ?? "${DateTime.now()}";
  final userNickname = await getSpecificUserData(userIdx, 'user_nickname') ?? "기본닉네임";
  final userProfileImage = await getSpecificUserData(userIdx, 'user_profile_image') ?? "lib/assets/images/default_profile.png";
  final userState = await getSpecificUserData(userIdx, 'user_state') ?? 2;

  return {
    'userIdx': userIdx,
    'userAccount': userAccount,
    'alarmsAllow': alarmsAllow,
    'appLockState': appLockState,
    'homePresetType': homePresetType,
    'loginType': loginType,
    'loveDday': loveDday,
    'loverIdx': loverIdx,
    'profileMessage': profileMessage,
    'topBarActivate': topBarActivate,
    'topBarType': topBarType,
    'userBirth': userBirth,
    'userNickname': userNickname,
    'userProfileImage': userProfileImage,
    'userState': userState,
  };
}
