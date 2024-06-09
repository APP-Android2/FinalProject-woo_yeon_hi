
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/screen/more/password_setting_screen.dart';
import 'package:woo_yeon_hi/style/font.dart';

import '../../model/user_model.dart';
import '../../style/color.dart';
import '../../style/text_style.dart';
import '../../widget/more/app_lock_top_app_bar.dart';
import 'package:local_auth_android/local_auth_android.dart';

class AppLockSettingScreen extends StatefulWidget {
  final bool isBioAuthSupported;

  const AppLockSettingScreen({super.key, required this.isBioAuthSupported});

  @override
  State<AppLockSettingScreen> createState() => _AppLockSettingScreenState();
}

class _AppLockSettingScreenState extends State<AppLockSettingScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  bool? _canCheckBiometrics;
  bool _isAuthenticating = false;

  Future<void> _checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      print(e);
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _authenticateWithBiometrics() async {
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
      return;
    }
    if (!mounted) {
      return;
    }
  }

  Future<void> _cancelAuthentication() async {
    await auth.stopAuthentication();
    setState(() => _isAuthenticating = false);
  }

  late bool _appLockActivated;
  late bool _bioAuthActivated;
  dynamic userProvider;
  @override
  void initState() {
    super.initState();
    userProvider = Provider.of<UserModel>(context, listen: false);
    if(userProvider.appLockState==0){
      _appLockActivated = false;
      _bioAuthActivated = false;
    }else if(userProvider.appLockState==1){
      _appLockActivated = true;
      _bioAuthActivated = false;
    }else{
      _appLockActivated = true;
      _bioAuthActivated = true;
    }
  }


  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;

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
                    width: deviceWidth-40,
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
                                value: _appLockActivated,
                                activeColor: ColorFamily.white,
                                activeTrackColor: ColorFamily.pink,
                                inactiveThumbColor: ColorFamily.gray,
                                inactiveTrackColor: ColorFamily.white,
                                trackOutlineColor:
                                _appLockActivated ? MaterialStateProperty.all(Colors.transparent) : MaterialStateProperty.all(ColorFamily.gray),
                                trackOutlineWidth: const MaterialStatePropertyAll(1),
                                onChanged: (bool value) {
                                  if(_appLockActivated == false){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => PasswordSettingScreen(bioAuth: widget.isBioAuthSupported)));
                                  } else{
                                    setState(() {
                                      _appLockActivated = value;
                                      userProvider.appLockState = 0;
                                      });
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
                widget.isBioAuthSupported
                    ? SizedBox(
                        width: deviceWidth-40,
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
                                    value: _bioAuthActivated,
                                    activeColor: ColorFamily.white,
                                    activeTrackColor: ColorFamily.pink,
                                    inactiveThumbColor: ColorFamily.gray,
                                    inactiveTrackColor: ColorFamily.white,
                                    trackOutlineColor:
                                    _bioAuthActivated ? MaterialStateProperty.all(Colors.transparent) : MaterialStateProperty.all(ColorFamily.gray),
                                    trackOutlineWidth: const MaterialStatePropertyAll(1),
                                    onChanged: (bool value) {
                                      setState(() {
                                        _bioAuthActivated = value;
                                      });
                                      _bioAuthActivated
                                          ? _authenticateWithBiometrics()
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
                    width: deviceWidth-40,
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
                              child: Text("기기에 생체 인증 사용 설정이 안 되어 있거나, 생체 인증을 지원하지 않는 기기입니다.",
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
