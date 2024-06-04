import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:woo_yeon_hi/screen/more/app_lock_setting_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/widget/more/app_lock_top_app_bar.dart';

import '../../style/font.dart';
import '../../style/text_style.dart';

class PasswordCheckScreen extends StatefulWidget {
  final bool isBioAuthSupported;

  const PasswordCheckScreen(this.isBioAuthSupported, {super.key});

  @override
  State<PasswordCheckScreen> createState() => _PasswordCheckScreenState();
}

class _PasswordCheckScreenState extends State<PasswordCheckScreen> {
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
          AndroidAuthMessages(
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


    Future<void> _cancelAuthentication() async {
      await auth.stopAuthentication();
      setState(() => _isAuthenticating = false);
    }
  }

  //TODO widget.isBioAuthSupported를 조건으로 노출 여부 결정
  void showBioAuthDialog(BuildContext context){

    showMaterialModalBottomSheet(
        backgroundColor: ColorFamily.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20))),
        context: context,
        builder: (context) =>
            Container(
                height: 390,
                child: Column(children: [
                  Container(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        children: [
                          SizedBox(height: 30),
                          Text('생체 인증 등록', style: TextStyle(color: ColorFamily.black,fontFamily: FontFamily.mapleStoryLight,fontSize: 20)),
                          SizedBox(height: 50),
                          Container(
                            width: 250,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(width:75, child: SvgPicture.asset("lib/assets/icons/fingerprint.svg", height: 64)),
                                SvgPicture.asset("lib/assets/icons/face_id.svg", width: 64, height: 64)
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                          Container(
                            width: 250,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Touch ID",style: TextStyleFamily.appBarTitleLightTextStyle),
                                Text("Face ID",style: TextStyleFamily.appBarTitleLightTextStyle)
                              ],
                            ),
                          ),
                          SizedBox(height: 30),
                          Text("기기에 등록되어 있는 생체정보를 통해",style: TextStyleFamily.normalTextStyle),
                          Text("앱 잠금을 해제할 수 있습니다.",style: TextStyleFamily.normalTextStyle),
                        ],
                      )
                  ),
                  SizedBox(height: 40),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(left: 50)),
                        Expanded(
                          child: Container(
                            child: Material(
                              color: ColorFamily.white,
                              elevation: 0.5,
                              shadowColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(20.0),
                              ),
                              child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => AppLockSettingScreen(isBioAuthSupported: widget.isBioAuthSupported)));
                                  },
                                  borderRadius:
                                  BorderRadius.circular(20.0),
                                  child:
                                  Container(
                                      height: 40,
                                      width: 120,
                                      child:
                                      Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "다음에",
                                          style: TextStyleFamily.normalTextStyle,
                                        ),
                                      )
                                  )
                              ),
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(left: 20)),
                        Expanded(
                          child: Material(
                            color: ColorFamily.beige,
                            elevation: 0.5,
                            shadowColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: InkWell(
                              onTap: () {
                                _authenticateWithBiometrics();
                              },
                              borderRadius: BorderRadius.circular(20.0),
                              child: Container(
                                  height: 40,
                                  width: 120,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "사용하기",
                                      style: TextStyleFamily.normalTextStyle,
                                    ),
                                  )),
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(right: 50)),
                      ],
                    ),
                  ),
                ])));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppLockSettingTopAppBar(),
      body: Container(
        padding: EdgeInsets.all(20),
        color: ColorFamily.cream,
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 170)),
            Container(
                child: Text("비밀번호 확인",
                    style: TextStyleFamily.passwordTextStyle)),
            Padding(padding: EdgeInsets.only(top: 75)),
            Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 50,
                    child:
                    SvgPicture.asset("lib/assets/icons/woo_yeon_hi_48px.svg"),
                  ),
                  Padding(padding: EdgeInsets.only(right: 20)),
                  Container(
                    alignment: Alignment.center,
                    width: 50,
                    child:
                    SvgPicture.asset("lib/assets/icons/woo_yeon_hi_48px.svg"),
                  ),
                  Padding(padding: EdgeInsets.only(right: 20)),
                  Container(
                    alignment: Alignment.center,
                    width: 50,
                    child:
                    SvgPicture.asset("lib/assets/icons/password_bar_24px.svg"),
                  ),
                  Padding(padding: EdgeInsets.only(right: 20)),
                  Container(
                    alignment: Alignment.center,
                    width: 50,
                    child:
                    SvgPicture.asset("lib/assets/icons/password_bar_24px.svg"),
                  ),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 210)),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  Expanded(
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          alignment: Alignment.center,
                          width: 60,
                          height: 30,
                          child: Text(
                            "1",
                            style: TextStyleFamily.passwordTextStyle,
                          ),
                        ),
                      )),
                  Padding(padding: EdgeInsets.only(right: 50)),
                  Expanded(
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(0.0),
                        child: Container(
                          alignment: Alignment.center,
                          width: 60,
                          height: 30,
                          child: Text(
                            "2",
                            style: TextStyleFamily.passwordTextStyle,
                          ),
                        ),
                      )),
                  Padding(padding: EdgeInsets.only(right: 50)),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(0.0),
                      child: Container(
                        alignment: Alignment.center,
                        width: 60,
                        height: 30,
                        child: Text(
                          "3",
                          style: TextStyleFamily.passwordTextStyle,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 35)),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  Expanded(
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(0.0),
                        child: Container(
                          alignment: Alignment.center,
                          width: 60,
                          height: 30,
                          child: Text(
                            "4",
                            style: TextStyleFamily.passwordTextStyle,
                          ),
                        ),
                      )),
                  Padding(padding: EdgeInsets.only(right: 50)),
                  Expanded(
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(0.0),
                        child: Container(
                          alignment: Alignment.center,
                          width: 60,
                          height: 30,
                          child: Text(
                            "5",
                            style: TextStyleFamily.passwordTextStyle,
                          ),
                        ),
                      )),
                  Padding(padding: EdgeInsets.only(right: 50)),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(0.0),
                      child: Container(
                        alignment: Alignment.center,
                        width: 60,
                        height: 30,
                        child: Text(
                          "6",
                          style: TextStyleFamily.passwordTextStyle,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 35)),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  Expanded(
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(0.0),
                        child: Container(
                          alignment: Alignment.center,
                          width: 60,
                          height: 30,
                          child: Text(
                            "7",
                            style: TextStyleFamily.passwordTextStyle,
                          ),
                        ),
                      )),
                  Padding(padding: EdgeInsets.only(right: 50)),
                  Expanded(
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(0.0),
                        child: Container(
                          alignment: Alignment.center,
                          width: 60,
                          height: 30,
                          child: Text(
                            "8",
                            style: TextStyleFamily.passwordTextStyle,
                          ),
                        ),
                      )),
                  Padding(padding: EdgeInsets.only(right: 50)),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(0.0),
                      child: Container(
                        alignment: Alignment.center,
                        width: 60,
                        height: 30,
                        child: Text(
                          "9",
                          style: TextStyleFamily.passwordTextStyle,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 35)),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  Expanded(
                      child: InkWell(
                        onTap: () {
                          showBioAuthDialog(context);
                        },
                        borderRadius: BorderRadius.circular(0.0),
                        child: Container(
                          alignment: Alignment.center,
                          width: 60,
                          height: 30,
                          child: Text(
                            "",
                            style: TextStyleFamily.passwordTextStyle,
                          ),
                        ),
                      )),
                  Padding(padding: EdgeInsets.only(right: 50)),
                  Expanded(
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(0.0),
                        child: Container(
                          alignment: Alignment.center,
                          width: 60,
                          height: 30,
                          child: Text(
                            "0",
                            style: TextStyleFamily.passwordTextStyle,
                          ),
                        ),
                      )),
                  Padding(padding: EdgeInsets.only(right: 50)),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(0.0),
                      child: Container(
                        alignment: Alignment.center,
                        width: 60,
                        height: 30,
                        child: SvgPicture.asset("lib/assets/icons/backspace.svg"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

