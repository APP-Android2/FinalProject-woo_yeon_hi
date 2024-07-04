import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:woo_yeon_hi/utils.dart';

import '../dialogs.dart';

class UserProvider extends ChangeNotifier {
  int _userIdx = 0;
  String _userAccount = "";
  bool _alarmsAllow = false;
  int _appLockState = 0;
  int _homePresetType = 0;
  int _loginType = 0;
  String _loveDday = dateToString(DateTime.now());
  int _loverIdx = 0;
  String _profileMsg = "";
  bool _topBarActivate = false;
  int _topBarType = 0;
  String _userBirth = dateToString(DateTime.now());
  String _userNickname = "기본닉네임";
  String _userProfileImage = "lib/assets/images/default_profile.png";
  int _userState = 2;

  String _loverNickname = "";
  bool _loginSuccess = false;
  List<int> _lockPassword = [0, 0, 0, 0];

  int get userIdx => _userIdx;

  String get userAccount => _userAccount;

  bool get alarmsAllow => _alarmsAllow;

  int get appLockState => _appLockState;

  int get homePresetType => _homePresetType;

  int get loginType => _loginType;

  String get loveDday => _loveDday;

  int get loverIdx => _loverIdx;

  String get profileMsg => _profileMsg;

  bool get topBarActivate => _topBarActivate;

  int get topBarType => _topBarType;

  String get userBirth => _userBirth;

  String get userNickname => _userNickname;

  String get userProfileImage => _userProfileImage;

  int get userState => _userState;

  String get loverNickname => _loverNickname;

  bool get loginSuccess => _loginSuccess;

  List<int> get lockPassword => _lockPassword;

  TextEditingController _userNicknameTextEditController = TextEditingController();
  TextEditingController _loverNickNameTextEditController = TextEditingController();
  TextEditingController _profileMessageTextEditController = TextEditingController();
  TextEditingController _codeTextEditController = TextEditingController();

  TextEditingController get userNicknameTextEditController =>
      _userNicknameTextEditController;

  TextEditingController get loverNickNameTextEditController =>
      _loverNickNameTextEditController;

  TextEditingController get profileMessageTextEditController =>
      _profileMessageTextEditController;

  TextEditingController get codeTextEditController => _codeTextEditController;


  XFile? _image;

  XFile? get image => _image;

  void setImage(XFile? image) {
    _image = image;
    notifyListeners();
  }

  void setUserIdx(int userIdx) {
    _userIdx = userIdx;
    notifyListeners();
  }

  void setUserAccount(String userAccount) {
    _userAccount = userAccount;
    notifyListeners();
  }

  void setLoginType(int loginType) {
    _loginType = loginType;
    notifyListeners();
  }

  void setUserState(int userState) {
    _userState = userState;
    notifyListeners();
  }

  void setLoverIdx(int loverIdx) {
    _loverIdx = loverIdx;
    notifyListeners();
  }

  void setLoginSuccess(bool loginSuccess) {
    _loginSuccess = loginSuccess;
    notifyListeners();
  }

  void setAppLockState(int state) {
    _appLockState = state;
    notifyListeners();
  }

  void setLockPassword(List<int> passwordList) {
    _lockPassword = passwordList;
    notifyListeners();
  }

  void setUserNickname(String userNickname) {
    _userNickname = userNickname;
    notifyListeners();
  }

  void setLoverNickname(String loverNickname) {
    _loverNickname = loverNickname;
    notifyListeners();
  }

  void setProfileMsg(String profileMsg) {
    _profileMsg = profileMsg;
    notifyListeners();
  }

  void setUserProfileImage(String profileImageRoute) {
    _userProfileImage = profileImageRoute;
    notifyListeners();
  }

  void setUserBirth(String date) {
    _userBirth = date;
    notifyListeners();
  }

  void setAlarmsAllow(bool allow) {
    _alarmsAllow = allow;
    notifyListeners();
  }

  void setLoveDday(String date) {
    _loveDday = date;
    notifyListeners();
  }

  void setHomePresetType(int presetPosition) {
    _homePresetType = presetPosition;
    notifyListeners();
  }

  void setTopBarType(int type) {
    _topBarType = type;
    notifyListeners();
  }

  void setTopBarActivate(bool activate) {
    _topBarActivate = activate;
    notifyListeners();
  }

  void setUserAllData(int userIdx, String userAccount, bool alarmsAllow,
      int appLockState, int homePresetType, int loginType,
      String loveDday, int loverIdx, String profileMessage, bool topBarActivate,
      int topBarType, String userBirth,
      String userNickname, String userProfileImage, int userState) {
    _userIdx = userIdx;
    _userAccount = userAccount;
    _alarmsAllow = alarmsAllow;
    _appLockState = appLockState;
    _homePresetType = homePresetType;
    _loginType = loginType;
    _loveDday = loveDday;
    _loverIdx = loverIdx;
    _profileMsg = profileMessage;
    _topBarActivate = topBarActivate;
    _topBarType = topBarType;
    _userBirth = userBirth;
    _userNickname = userNickname;
    _userProfileImage = userProfileImage;
    _userState = userState;
  }

  bool checkProvider(TextEditingController textEditingController) {
    if (textEditingController.text.isEmpty ||
        textEditingController.text == "") {
      return false;
    } else {
      return true;
    }
  }


  signInWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      print('email = ${googleUser.email}');
      print('id = ${googleUser.id}');

      setUserAccount(googleUser.email);
      setLoginSuccess(true);
    } else {
      showToast("구글 계정 로그인에 실패하였습니다.");
    }
  }

  signInWithKakao() async {
    if (await isKakaoTalkInstalled()) {
      try {
        //카카오톡 설치됨, 카카오톡으로 로그인 시도
        await UserApi.instance.loginWithKakaoTalk();
        setLoginSuccess(true);
        // setUserAccount(카카오계정정보);
      } catch (error) {
        print('카카오톡으로 로그인 실패 $error');
        showToast("카카오 계정 로그인에 실패하였습니다.");
        if (error is PlatformException && error.code == 'CANCELED') {
          print('사용자가 로그인 취소');
          showToast("카카오 계정 로그인을 취소하였습니다.");
          return;
        }

        print('카카오 계정으로 로그인 시도');
        try {
          await UserApi.instance.loginWithKakaoAccount();
          // setUserAccount(카카오계정정보);
          setLoginSuccess(true);
        } catch (error) {
          print('카카오 계정으로 로그인 실패 $error');
          showToast("카카오 계정 로그인에 실패하였습니다.");
        }
      }
    } else {
      //카카오톡 설치 안됨, 카카오계정으로 로그인 시도
      try {
        await UserApi.instance.loginWithKakaoAccount();
        // setUserAccount(카카오계정정보);
        setLoginSuccess(true);
      } catch (error) {
        showToast("카카오 계정 로그인에 실패하였습니다.");
      }
    }
  }
}


class ConnectCodeProvider extends ChangeNotifier {

  bool _isCodeGenerated = false;
  bool _isCodeExpired = false;
  String _randomCodeText = "";
  TextEditingController _codeTextEditController = TextEditingController();

  bool get isCodeGenerated => _isCodeGenerated;
  bool get isCodeExpired => _isCodeExpired;
  String get randomCodeText => _randomCodeText;
  TextEditingController get codeTextEditController => _codeTextEditController;

  void setIsCodeGenerated(bool bool){
    _isCodeGenerated = bool;
    notifyListeners();
  }

  void setIsCodeExpired(bool bool){
    _isCodeExpired = bool;
    notifyListeners();
  }

  void setRandomCodeText(String randomCode){
    _randomCodeText = randomCode;
    notifyListeners();
  }

  void setCodeText(String randomCode){
    _randomCodeText = randomCode;
    notifyListeners();
  }
}

class CalendarProvider extends ChangeNotifier{
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();

  DateTime get focusedDay => _focusedDay;
  DateTime? get selectedDay => _selectedDay;

  void setFocusedDay(DateTime date){
    _focusedDay = date;
    notifyListeners();
  }
  void setSelectedDay(DateTime date){
    _selectedDay = date;
    notifyListeners();
  }
}

class AuthCodeProvider extends ChangeNotifier {

  bool _showErrorMessage = false;
  bool _isAuthCodeGenerated = false;
  bool _isAuthCodeExpired = false;
  String _authCodeText = "";
  TextEditingController _authNumberTextEditController = TextEditingController();

  bool get showErrorMessage => _showErrorMessage;
  bool get isAuthCodeGenerated => _isAuthCodeGenerated;
  bool get isAuthCodeExpired => _isAuthCodeExpired;
  String get authCodeText => _authCodeText;
  TextEditingController get authNumberTextEditController => _authNumberTextEditController;

  void setShowErrorMessage(bool error){
    _showErrorMessage = error;
    notifyListeners();
  }
  void setIsAuthCodeGenerated(bool generated){
    _isAuthCodeGenerated = generated;
    notifyListeners();
  }
  void setIsAuthCodeExpired(bool expired){
    _isAuthCodeExpired = expired;
    notifyListeners();
  }
  void setAuthCodeText(String authCode){
    _authCodeText = authCode;
    notifyListeners();
  }
}

