import 'package:flutter/cupertino.dart';

import 'enums.dart';

class UserModel with ChangeNotifier{
  int idx;
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
  bool appLockState;
  String lockPassword;
  int userState;
  DateTime loveDday;

  UserModel(
      {required this.idx,
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
        required this.lockPassword,
        required this.userState,
        required this.loveDday,
      });

  bool checkProvider(TextEditingController textEditingController){
    if(textEditingController.text.isNotEmpty){
      return true;
    }else{
      return false;
    }
  }

  // 사용자가 입력한 입력값을 담을 변수
  String _userInput = "";
  String get userInput => _userInput;

  void setInput(String input){
    _userInput = input;

    notifyListeners();
  }
}