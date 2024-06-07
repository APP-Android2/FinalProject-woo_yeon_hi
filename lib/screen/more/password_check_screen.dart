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
            SizedBox(height: deviceHeight * 0.1),
            const Text("비밀번호 확인", style: TextStyleFamily.passwordTextStyle),
            SizedBox(height: deviceHeight * 0.08),
            SizedBox(
              height: 50,
              width: deviceWidth * 0.6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SvgPicture.asset("lib/assets/icons/woo_yeon_hi_48px.svg",
                      width: 48, height: 48),
                  const SizedBox(width: 20),
                  SvgPicture.asset("lib/assets/icons/woo_yeon_hi_48px.svg",
                      width: 48, height: 48),
                  const SizedBox(width: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: SvgPicture.asset(
                        "lib/assets/icons/password_bar_24px.svg",
                        width: 24),
                  ),
                  const SizedBox(width: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: SvgPicture.asset(
                        "lib/assets/icons/password_bar_24px.svg",
                        width: 24),
                  )
                ],
              ),
            ),
            SizedBox(height: deviceHeight * 0.25),
            SizedBox(
              height: deviceHeight * 0.08,
              width: deviceWidth - 40,
              child: Row(
                children: [
                  SizedBox(
                    height: deviceHeight * 0.08,
                    width: (deviceWidth - 40) / 3,
                    child: InkWell(
                      onTap: () {
                        print("1번 클릭됨");
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "1",
                          style: TextStyleFamily.passwordTextStyle,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: deviceHeight * 0.08,
                    width: (deviceWidth - 40) / 3,
                    child: InkWell(
                      onTap: () {
                        print("2번 클릭됨");
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "2",
                          style: TextStyleFamily.passwordTextStyle,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: deviceHeight * 0.08,
                    width: (deviceWidth - 40) / 3,
                    child: InkWell(
                      onTap: () {
                        print("3번 클릭됨");
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "3",
                          style: TextStyleFamily.passwordTextStyle,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: deviceHeight * 0.08,
              width: deviceWidth - 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: deviceHeight * 0.08,
                    width: (deviceWidth - 40) / 3,
                    child: InkWell(
                      onTap: () {
                        print("4번 클릭됨");
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "4",
                          style: TextStyleFamily.passwordTextStyle,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: deviceHeight * 0.08,
                    width: (deviceWidth - 40) / 3,
                    child: InkWell(
                      onTap: () {
                        print("5번 클릭됨");
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "5",
                          style: TextStyleFamily.passwordTextStyle,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: deviceHeight * 0.08,
                    width: (deviceWidth - 40) / 3,
                    child: InkWell(
                      onTap: () {
                        print("6번 클릭됨");
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "6",
                          style: TextStyleFamily.passwordTextStyle,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: deviceHeight * 0.08,
              width: deviceWidth - 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: deviceHeight * 0.08,
                    width: (deviceWidth - 40) / 3,
                    child: InkWell(
                      onTap: () {
                        print("7번 클릭됨");
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "7",
                          style: TextStyleFamily.passwordTextStyle,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: deviceHeight * 0.08,
                    width: (deviceWidth - 40) / 3,
                    child: InkWell(
                      onTap: () {
                        print("8번 클릭됨");
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "8",
                          style: TextStyleFamily.passwordTextStyle,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: deviceHeight * 0.08,
                    width: (deviceWidth - 40) / 3,
                    child: InkWell(
                      onTap: () {
                        print("9번 클릭됨");
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "9",
                          style: TextStyleFamily.passwordTextStyle,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: deviceHeight * 0.08,
              width: deviceWidth - 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: deviceHeight * 0.08,
                    width: (deviceWidth - 40) / 3,
                    child: InkWell(
                      onTap: () {
                        showBioAuthDialog(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "",
                          style: TextStyleFamily.passwordTextStyle,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: deviceHeight * 0.08,
                    width: (deviceWidth - 40) / 3,
                    child: InkWell(
                      onTap: () {
                        print("0번 클릭됨");
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "0",
                          style: TextStyleFamily.passwordTextStyle,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: deviceHeight * 0.08,
                    width: (deviceWidth - 40) / 3,
                    child: InkWell(
                      onTap: () {
                        print("지우기 클릭됨");
                      },
                      child: Container(
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                              "lib/assets/icons/backspace.svg")),
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
        localizedReason: '기기에 등록된 생체정보를 스캔해주세요.',
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
  void showBioAuthDialog(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;

    showMaterialModalBottomSheet(
        backgroundColor: ColorFamily.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        context: context,
        builder: (context) => SizedBox(
            height: deviceHeight*0.43,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    const Text('생체 인증 등록',
                        style: TextStyle(
                            color: ColorFamily.black,
                            fontFamily: FontFamily.mapleStoryLight,
                            fontSize: 20)),
                    const SizedBox(height: 50),
                    SizedBox(
                      width: deviceWidth*0.55,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: 64,
                              child: SvgPicture.asset(
                                  "lib/assets/icons/fingerprint.svg",
                                  height: 64)),
                          SvgPicture.asset("lib/assets/icons/face_id.svg",
                              width: 64, height: 64)
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: deviceWidth*0.55,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("지문 인식",
                              style:
                                  TextStyleFamily.appBarTitleLightTextStyle),
                          Text("Face ID",
                              style:
                                  TextStyleFamily.appBarTitleLightTextStyle)
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text("기기에 등록되어 있는 생체정보를 통해",
                        style: TextStyleFamily.normalTextStyle),
                    const Text("앱 잠금을 해제할 수 있습니다.",
                        style: TextStyleFamily.normalTextStyle),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: deviceWidth-80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Material(
                        color: ColorFamily.white,
                        elevation: 0.5,
                        shadowColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AppLockSettingScreen(
                                              isBioAuthSupported: widget
                                                  .isBioAuthSupported)));
                            },
                            borderRadius: BorderRadius.circular(20.0),
                            child: Container(
                              decoration: BoxDecoration(border: Border.all(color: ColorFamily.gray,width: 0.2),borderRadius: BorderRadius.circular(20)),
                              height: 40,
                              alignment: Alignment.center,
                              child: const Text(
                                "다음에",
                                style: TextStyleFamily.normalTextStyle,
                              ),
                            )),
                      ),
                    ),
                      const SizedBox(width: 20),
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
                              alignment: Alignment.center,
                              child: const Text(
                                "사용하기",
                                style: TextStyleFamily.normalTextStyle,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ])));
  }
}

//TODO 비밀번호 4자리 입력 완료시 widget.isBioAuthSupporeted = true 이면 생체인증 다이얼로그 띄우기
