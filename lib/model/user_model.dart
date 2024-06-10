import 'enums.dart';

class User {
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

  User(
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

  factory User.fromData(Map<String, dynamic> data){
    return User(
        userIdx: data['user_idx'],
        loginType: data['diary_user_idx'],
        userAccount: data['diary_date'],
        userNickname: data['diary_weather'],
        userBirth: data['diary_image'],
        userProfileImage: data['diary_title'],
        loverUserIdx: data['diary_content'],
        loverNickname: data['diary_lover_check'],
        homePresetType: data['diary_state'],
      topBarType: data['diary_state'],
      profileMessage: data['diary_state'],
      alarmsAllow: data['diary_state'],
      appLockState: data['diary_state'],
      topBarActivate: data['diary_state'],
      lockPassword: data['diary_state'],
      userState: data['diary_state'],
      loveDday: data['diary_state'],
    );
  }
}