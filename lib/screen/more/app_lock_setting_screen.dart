
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/dialogs.dart';
import 'package:woo_yeon_hi/screen/more/password_setting_screen.dart';
import 'package:woo_yeon_hi/style/font.dart';

import '../../dao/user_dao.dart';
import '../../model/user_model.dart';
import '../../style/color.dart';
import '../../style/text_style.dart';
import '../../widget/more/app_lock_setting_top_app_bar.dart';
import 'package:local_auth_android/local_auth_android.dart';

class AppLockSettingScreen extends StatefulWidget {
  final bool bioAuth;
  const AppLockSettingScreen({super.key, required this.bioAuth});

  @override
  State<AppLockSettingScreen> createState() => _AppLockSettingScreenState();
}

class _AppLockSettingScreenState extends State<AppLockSettingScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  bool _isAuthenticating = false;
  late bool appLockSwitchValue = false;
  late bool bioLockSwitchValue = false;
  bool _isLoading = true; // Loading 상태를 나타내는 변수
  
  static const storage = FlutterSecureStorage();
  late String appLockState = "";
  late String userAccount = "";



  @override
  void initState() {
    super.initState();
    _asyncMethod();
  }

  Future<void> _asyncMethod() async {
    appLockState = (await storage.read(key: "appLockState"))??"0";
    userAccount = (await storage.read(key: "loginAccount"))!;

    setState(() {
      if(appLockState=="0"){
        appLockSwitchValue = false;
        bioLockSwitchValue = false;
      }else if(appLockState=="1"){
        appLockSwitchValue = true;
        bioLockSwitchValue = false;
      }else{
        appLockSwitchValue = true;
        bioLockSwitchValue = true;
      }
      _isLoading = false; // 데이터 로드가 완료되면 로딩 상태를 false로 설정
    });
  }
  
  
  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery
        .of(context)
        .size
        .width;
    var deviceHeight = MediaQuery
        .of(context)
        .size
        .height;

    if (_isLoading) {
      // 로딩 중인 상태를 표시
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
          appBar: const AppLockSettingTopAppBar(),
          body: Container(
              width: deviceWidth,
              height: deviceHeight,
              padding: const EdgeInsets.all(20),
              color: ColorFamily.cream,
              child: Column(
                children: [
                  SizedBox(
                      width: deviceWidth - 40,
                      height: 60,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("잠금 설정",
                                  style: TextStyleFamily.smallTitleTextStyle),
                              Switch(
                                  value: appLockSwitchValue,
                                  activeColor: ColorFamily.white,
                                  activeTrackColor: ColorFamily.pink,
                                  inactiveThumbColor: ColorFamily.gray,
                                  inactiveTrackColor: ColorFamily.white,
                                  trackOutlineColor:
                                  appLockSwitchValue
                                      ? MaterialStateProperty.all(
                                      Colors.transparent)
                                      : MaterialStateProperty.all(
                                      ColorFamily.gray),
                                  trackOutlineWidth: const MaterialStatePropertyAll(
                                      1),
                                  onChanged: (bool value) async {
                                    if (appLockSwitchValue == false) {
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PasswordSettingScreen(
                                                      bioAuth: widget
                                                          .bioAuth)));
                                    } else {
                                      setState(() {
                                        appLockSwitchValue = value;
                                        bioLockSwitchValue = value;
                                      });
                                      await storage.write(
                                          key: "appLockState",
                                          value: "0");
                                    }
                                  })
                            ],
                          ),
                          const SizedBox(
                            height: 0.5,
                            child:
                            Divider(color: ColorFamily.gray, thickness: 0.5),
                          )
                        ],
                      )),
                  widget.bioAuth
                      ? SizedBox(
                      width: deviceWidth - 40,
                      height: 60,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("생체 인증 (Touch ID, Face ID)",
                                  style:
                                  TextStyleFamily.smallTitleTextStyle),
                              Switch(
                                  value: bioLockSwitchValue,
                                  activeColor: ColorFamily.white,
                                  activeTrackColor: ColorFamily.pink,
                                  inactiveThumbColor: ColorFamily.gray,
                                  inactiveTrackColor: ColorFamily.white,
                                  trackOutlineColor:
                                  bioLockSwitchValue
                                      ? MaterialStateProperty.all(Colors
                                      .transparent)
                                      : MaterialStateProperty.all(ColorFamily
                                      .gray),
                                  trackOutlineWidth: const MaterialStatePropertyAll(
                                      1),
                                  onChanged: (bool value) async {
                                    setState(() {
                                      bioLockSwitchValue = value;
                                    });
                                    appLockSwitchValue==false
                                    ? setState(() {
                                      bioLockSwitchValue = false;
                                      Fluttertoast.showToast(
                                          msg: "잠금 설정을 먼저 해주세요.",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: ColorFamily.black,
                                          textColor: ColorFamily.white,
                                          fontSize: 14.0
                                      );
                                    })
                                    : bioLockSwitchValue
                                        ? await _authenticateWithBiometrics()
                                        ? setState(() async {
                                      await storage.write(key: 'appLockState', value: "2");
                                    })
                                        : setState(() {
                                      bioLockSwitchValue = false;
                                    })
                                        : _cancelAuthentication();
                                  }),
                            ],
                          ),
                          const SizedBox(
                            height: 0.5,
                            child: Divider(
                                color: ColorFamily.gray, thickness: 0.5),
                          )
                        ],
                      ))
                      : SizedBox(
                      width: deviceWidth - 40,
                      height: 60,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text("생체 인증 (Touch ID, Face ID)",
                                  style:
                                  TextStyleFamily.smallTitleTextStyle),
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                                "기기에 생체 인증 사용 설정이 안 되어 있거나, 생체 인증을 지원하지 않는 기기입니다.",
                                style: TextStyle(
                                    fontSize: 10,
                                    fontFamily:
                                    FontFamily.mapleStoryLight,
                                    color: ColorFamily.gray)),
                          ),
                          SizedBox(
                            height: 0.5,
                            child: Divider(
                                color: ColorFamily.gray, thickness: 0.5),
                          )
                        ],
                      )),
                ],
              )));
    }
  }

  Future<bool> _authenticateWithBiometrics() async {
    bool authenticated = false;

    try {
      setState(() {
        _isAuthenticating = true;
      });
      authenticated = await auth.authenticate(
        authMessages: [
          const AndroidAuthMessages(
            biometricHint: '',
            biometricNotRecognized: '생체정보가 일치하지 않습니다.',
            biometricRequiredTitle: '생체정보가 필요합니다.',
            biometricSuccess: '스캔 완료',
            cancelButton: '취소',
            deviceCredentialsRequiredTitle: '생체정보가 필요합니다.',
            deviceCredentialsSetupDescription: '기기 설정으로 이동하여 생체정보를 등록하세요.',
            goToSettingsButton: '설정',
            goToSettingsDescription: '기기 설정으로 이동하여 생체정보를 등록하세요.',
            signInTitle: '생체정보 스캔',
          )
        ],
        localizedReason:
        '기기에 등록된 생체정보를 스캔해주세요.',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
      });
      return _isAuthenticating;
    }
    if (!mounted) {
      return _isAuthenticating;
    }
    return authenticated;
  }

  Future<void> _cancelAuthentication() async {
    await auth.stopAuthentication();
    setState(() => _isAuthenticating = false);
  }
}
