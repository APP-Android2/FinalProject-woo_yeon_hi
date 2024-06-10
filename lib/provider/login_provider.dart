import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:woo_yeon_hi/model/enums.dart';

import '../dialogs.dart';

class UserProvider extends ChangeNotifier{
  String _userAccount = "";
  LoginType _userLoginType = LoginType.none;
  int _userState = 0;
  bool _loginSuccess = false;
  int _appLockState = 0;
  List<int> _lockPassword = [0,0,0,0];
  String _userNickname = "기본닉네임";
  String _loverNickname = "";
  String _profileMsg = "";
  String _profileImage = "lib/assets/images/default_profile.png";
  DateTime _userBirth = DateTime.now();
  bool _alarmsAllow = false;
  DateTime _loveDday = DateTime.now();
  int _presetType = 0;
  int _topBarType = 0;
  bool _topBarActivate = false;

  String get userAccount => _userAccount;
  LoginType get userLoginType => _userLoginType;
  int get userState => _userState;
  bool get loginSuccess => _loginSuccess;
  int get appLockState => _appLockState;
  List<int> get lockPassword => _lockPassword;
  String get userNickname => _userNickname;
  String get loverNickname => _loverNickname;
  String get profileMsg => _profileMsg;
  String get profileImage => _profileImage;
  DateTime get userBirth => _userBirth;
  bool get alarmsAllow => _alarmsAllow;
  DateTime get loveDday => _loveDday;
  int get presetType => _presetType;
  int get topBarType => _topBarType;
  bool get topBarActivate => _topBarActivate;

  TextEditingController _userNicknameTextEditController = TextEditingController();
  TextEditingController _loverNickNameTextEditController = TextEditingController();
  TextEditingController _profileMessageTextEditController = TextEditingController();
  TextEditingController _codeTextEditController = TextEditingController();

  TextEditingController get userNicknameTextEditController => _userNicknameTextEditController;
  TextEditingController get loverNickNameTextEditController => _loverNickNameTextEditController;
  TextEditingController get profileMessageTextEditController => _profileMessageTextEditController;
  TextEditingController get codeTextEditController => _codeTextEditController;


  XFile? _image;
  XFile? get image => _image;
  void setImage(XFile? image) {
    _image = image;
    notifyListeners();
  }

  void setUserAccount(String userAccount){
    _userAccount = userAccount;
    notifyListeners();
  }

  void setUserLoginType(LoginType userLoginType){
    _userLoginType = userLoginType;
    notifyListeners();
  }

  void setUserState(int userState){
    _userState = userState;
    notifyListeners();
  }

  void setLoginSuccess(bool loginSuccess){
    _loginSuccess = loginSuccess;
    notifyListeners();
  }

  void setAppLockState(int state){
    _appLockState = state;
    notifyListeners();
  }

  void setLockPassword(List<int> passwordList){
    _lockPassword = passwordList;
    notifyListeners();
  }

  void setUserNickname(String userNickname){
    _userNickname = userNickname;
    notifyListeners();
  }

  void setLoverNickname(String loverNickname){
    _loverNickname = loverNickname;
    notifyListeners();
  }

  void setProfileMsg(String profileMsg){
    _profileMsg = profileMsg;
    notifyListeners();
  }

  void setProfileImage(String profileImageRoute){
    _profileImage = profileImageRoute;
    notifyListeners();
  }

  void setUserBirth(DateTime date){
    _userBirth = date;
    notifyListeners();
  }

  void setAlarmsAllow(bool allow){
    _alarmsAllow = allow;
    notifyListeners();
  }

  void setLoveDday(DateTime date){
    _loveDday = date;
    notifyListeners();
  }

  void setPresetType(int idx){
    _presetType = idx;
    notifyListeners();
  }

  void setTopBarType(int idx){
    _topBarType = idx;
    notifyListeners();
  }

  void setTopBarActivate(bool activate){
    _topBarActivate = activate;
    notifyListeners();
  }

  bool checkProvider(TextEditingController textEditingController){
    if(textEditingController.text.isEmpty || textEditingController.text == ""){
      return false;
    }else{
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

    } else{
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