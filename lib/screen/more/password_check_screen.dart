import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/dao/user_dao.dart';
import 'package:woo_yeon_hi/provider/login_register_provider.dart';
import 'package:woo_yeon_hi/provider/more_provider.dart';
import 'package:woo_yeon_hi/screen/more/app_lock_setting_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';

import '../../dialogs.dart';
import '../../style/font.dart';
import '../../style/text_style.dart';
import '../../utils.dart';

class PasswordCheckScreen extends StatefulWidget {
  const PasswordCheckScreen({super.key});

  @override
  State<PasswordCheckScreen> createState() => _PasswordCheckScreenState();
}

class _PasswordCheckScreenState extends State<PasswordCheckScreen> {
  static const storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;

    return PopScope(
        canPop: false,
        onPopInvoked: (didPop) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const AppLockSettingScreen())),
        child: Scaffold(
          appBar: AppBar(
            surfaceTintColor: ColorFamily.cream,
            backgroundColor: ColorFamily.cream,
            centerTitle: true,
            title: const Text(
              "앱 잠금 설정",
              style: TextStyleFamily.appBarTitleLightTextStyle,
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AppLockSettingScreen()));
              },
              icon: SvgPicture.asset('lib/assets/icons/arrow_back.svg'),
            ),
          ),
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
                      children: List.generate(4, (index) {
                        return _buildPasswordIcon(
                            index < checkingPasswordList.length);
                      })),
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
                            _addNumber(1);
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
                            _addNumber(2);
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
                            _addNumber(3);
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
                            _addNumber(4);
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
                            _addNumber(5);
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
                            _addNumber(6);
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
                            _addNumber(7);
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
                            _addNumber(8);
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
                            _addNumber(9);
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
                          onTap: () {},
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
                            _addNumber(0);
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
                            _removeNumber();
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
        ));
  }

  Widget _buildPasswordIcon(bool isActive) {
    return isActive
        ? SvgPicture.asset("lib/assets/icons/woo_yeon_hi_48px.svg",
            width: 48, height: 48)
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SvgPicture.asset("lib/assets/icons/password_bar_24px.svg",
                width: 24),
          );
  }

  bool firstNumInput = false;
  bool secondNumInput = false;
  bool thirdNumInput = false;
  bool fourthNumInput = false;

  final List<int> checkingPasswordList = [];
  final int _maxNumbers = 4;

  void _numInputCheck() {
    setState(() {
      firstNumInput = checkingPasswordList.length > 0;
      secondNumInput = checkingPasswordList.length > 1;
      thirdNumInput = checkingPasswordList.length > 2;
      fourthNumInput = checkingPasswordList.length > 3;
    });
  }

  void _addNumber(int number) {
    setState(() {
      if (checkingPasswordList.length < _maxNumbers) {
        checkingPasswordList.add(number);
      }
      if (checkingPasswordList.length == _maxNumbers) {
        _checkPassword();
      }
    });
    _numInputCheck();
  }

  void _removeNumber() {
    setState(() {
      if (checkingPasswordList.isNotEmpty) {
        checkingPasswordList.removeLast();
      }
    });
    _numInputCheck();
  }

  Future<void> _checkPassword() async {
    var listEquality = const ListEquality();
    if (!listEquality.equals(checkingPasswordList,
        Provider.of<PasswordProvider>(context, listen: false).password)) {
      showBlackToast("비밀번호를 다르게 입력하였습니다.");
      Future.delayed(const Duration(milliseconds: 100), () {
        _initiatePassword();
      });
    } else {
      var password = listToString(checkingPasswordList);
      await storage.write(key: "lockPassword", value: password);
      if (Provider.of<BioAuthProvider>(context, listen: false)
              .bioAuthSupported ==
          true) {
        showBioAuthDialog(context);
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const AppLockSettingScreen()));
      }
    }
  }

  void _initiatePassword() {
    setState(() {
      firstNumInput = false;
      secondNumInput = false;
      thirdNumInput = false;
      fourthNumInput = false;

      checkingPasswordList.clear();
    });
  }

  final LocalAuthentication auth = LocalAuthentication();

  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      setState(() {});
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
      setState(() {});
    } on PlatformException catch (e) {
      print(e);
      setState(() {});
      return;
    }
    if (!mounted) {
      return;
    }

    if (authenticated) {
      await updateSpecificUserData(
          Provider.of<UserProvider>(context, listen: false).userIdx,
          'app_lock_state',
          2);
      Provider.of<UserProvider>(context, listen: false).setAppLockState(2);
      Navigator.pop(context);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const AppLockSettingScreen()));
    }
  }

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
            height: deviceHeight * 0.43,
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
                      width: deviceWidth * 0.55,
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
                      width: deviceWidth * 0.55,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("지문 인식",
                              style: TextStyleFamily.appBarTitleLightTextStyle),
                          Text("얼굴 인식",
                              style: TextStyleFamily.appBarTitleLightTextStyle)
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
                width: deviceWidth - 80,
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
                            onTap: () async {
                              await updateSpecificUserData(
                                  Provider.of<UserProvider>(context,
                                          listen: false)
                                      .userIdx,
                                  'app_lock_state',
                                  1);
                              Provider.of<UserProvider>(context, listen: false)
                                  .setAppLockState(1);
                              Navigator.pop(context);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AppLockSettingScreen()));
                            },
                            borderRadius: BorderRadius.circular(20.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: ColorFamily.gray, width: 0.2),
                                  borderRadius: BorderRadius.circular(20)),
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
            ]))).then((value) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const AppLockSettingScreen()));
      showPinkSnackBar(context, '앱 잠금이 설정되었습니다.');
    });
  }
}
