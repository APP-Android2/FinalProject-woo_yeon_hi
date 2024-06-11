import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import 'enums.dart';

class UserModel with ChangeNotifier{
  int userIdx;
  int loginType;
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

  factory UserModel.fromData(Map<String, dynamic> data){
    return UserModel(
        userIdx: data['user_idx'],
        loginType: data['login_type'],
        userAccount: data['user_account'],
        userNickname: data['user_nickname'],
        userBirth: data['user_birth'],
        userProfileImage: data['user_profile_image'],
        loverUserIdx: data['lover_user_idx'],
        loverNickname: data['lover_nickname'],
        homePresetType: data['home_Preset_type'],
        topBarType: data['top_bar_type'],
        profileMessage: data['profile_message'],
        alarmsAllow: data['alarms_allow'],
      appLockState: data['app_lock_state'],
      topBarActivate: data['top_bar_activate'],
      lockPassword: data['lock_password'],
      userState: data['user_state'],
      loveDday: data['love_d_day'],
    );
  }

  bool checkProvider(TextEditingController textEditingController){
    if(textEditingController.text.isEmpty || textEditingController.text == ""){
      return false;
    }else{
      return true;
    }
  }

  XFile? _image;
  XFile? get image => _image;
  void setImage(XFile? image) {
    _image = image;
    notifyListeners();
  }

  void providerNotify(){
    notifyListeners();
  }
}