import 'package:flutter/cupertino.dart';

import 'enums.dart';

class UserModel with ChangeNotifier{
  int userIdx;
  LoginType loginType;
  String userAccount;
  String userNickname;
  DateTime userBirth;
  String userProfileImage;
  int loverUserIdx;
  String loverNickname;
  int homePresetType;
  int topBarType;
  String profileMessage;
  bool alarmsAllow;
  int appLockState;
  bool topBarActivate;
  List lockPassword;
  int userState;
  DateTime loveDday;

  UserModel(
      {required this.userIdx,
       required this.loginType,
       required this.userAccount,
        required this.userNickname,
        required this.userBirth,
        required this.userProfileImage,
        required this.loverUserIdx,
        required this.loverNickname,
        required this.homePresetType,
        required this.topBarType,
        required this.profileMessage,
        required this.alarmsAllow,
        required this.appLockState,
        required this.topBarActivate,
        required this.lockPassword,
        required this.userState,
        required this.loveDday,
      });

  bool checkProvider(TextEditingController textEditingController){
    if(textEditingController.text.isEmpty || textEditingController.text == ""){
      return false;
    }else{
      return true;
    }
  }
}