import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/provider/login_register_provider.dart';
import 'package:woo_yeon_hi/screen/login/password_reset_screen.dart';
import 'package:woo_yeon_hi/screen/main_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/style/text_style.dart';
import 'package:woo_yeon_hi/utils.dart';

import '../../dialogs.dart';

class PasswordEnterScreen extends StatefulWidget {
  const PasswordEnterScreen({super.key});

  @override
  State<PasswordEnterScreen> createState() => _PasswordEnterScreenState();
}

class _PasswordEnterScreenState extends State<PasswordEnterScreen> {

  @override
  void initState() {
    super.initState();
    _bioAuthDialog();
  }

  Future<void> _bioAuthDialog () async {
    Provider.of<UserProvider>(context, listen: false).appLockState == 2
        ? Future.delayed(const Duration(milliseconds: 500), () async {
      _authenticateWithBiometrics();})
        : null;
  }


  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Container(
      width: deviceWidth,
      height: deviceHeight,
      padding: const EdgeInsets.all(20),
      color: ColorFamily.cream,
      child: Column(
        children: [
          SizedBox(height: deviceHeight * 0.22),
          const Text("비밀번호 입력", style: TextStyleFamily.passwordTextStyle),
          SizedBox(height: deviceHeight * 0.08),
          SizedBox(
            height: 50,
            width: deviceWidth * 0.6,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(4, (index) {
                  return _buildPasswordIcon(index < checkingPassword.length);
                })),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: 160,
              child: TextButton(
                  style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all<Color>(Colors.transparent)),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const PasswordResetScreen()));
                  },
                  child: Row(
                    children: [
                      const Text(
                        "비밀번호를 모르겠어요",
                        style: TextStyle(
                            color: ColorFamily.black,
                            fontSize: 12,
                            fontFamily: FontFamily.mapleStoryLight),
                      ),
                      SvgPicture.asset("lib/assets/icons/expand.svg",
                          width: 18, height: 18)
                    ],
                  )),
            ),
          ),
          SizedBox(height: deviceHeight * 0.18),
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
                    onTap: () {
                      _authenticateWithBiometrics();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child:
                      Provider.of<UserProvider>(context, listen: false).appLockState == 2
                      ? const Text(
                        "생체인증",
                        style: TextStyleFamily.smallTitleTextStyle)
                      : const Text("", style: TextStyleFamily.smallTitleTextStyle)
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
                        child:
                            SvgPicture.asset("lib/assets/icons/backspace.svg")),
                  ),
                )
              ],
            ),
          ),
        ],
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

  final List<int> checkingPassword = [];
  final int _maxNumbers = 4;

  void _numInputCheck() {
    setState(() {
      firstNumInput = checkingPassword.length > 0;
      secondNumInput = checkingPassword.length > 1;
      thirdNumInput = checkingPassword.length > 2;
      fourthNumInput = checkingPassword.length > 3;
    });
  }

  void _addNumber(int number) {
    setState(() {
      if (checkingPassword.length < _maxNumbers) {
        checkingPassword.add(number);
      }
      if (checkingPassword.length == _maxNumbers) {
        _checkPassword();
      }
    });
    _numInputCheck();
  }

  void _removeNumber() {
    setState(() {
      if (checkingPassword.isNotEmpty) {
        checkingPassword.removeLast();
      }
    });
    _numInputCheck();
  }

  Future<void> _checkPassword() async {
    var listEquality = const ListEquality();
    var lockPassword = await _fetchPassword();

    if (!listEquality.equals(checkingPassword,
        lockPassword)) {
      showBlackToast("비밀번호가 일치하지 않습니다.");
      Future.delayed(const Duration(milliseconds: 100), () {
        _initiatePassword();
      });
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => const MainScreen()),
              (route) => false);
    }
  }

  void _initiatePassword() {
    setState(() {
      checkingPassword.clear();
    });
  }

  final LocalAuthentication auth = LocalAuthentication();
  bool _isAuthenticating = false;
  bool _isAuthenticated = false;

  Future<void> _authenticateWithBiometrics() async {
    if (_isAuthenticating || _isAuthenticated) {
      return;
    }

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
          sensitiveTransaction: true,
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } on PlatformException catch (e) {
      print(e);
      return;
    } finally {
      setState(() {
        _isAuthenticating = false;
      });
    }

    if (!mounted) {
      return;
    }

    if (authenticated) {
      var lockPassword = await _fetchPassword();
      setState(() {
        checkingPassword.add(lockPassword[0]);
        checkingPassword.add(lockPassword[1]);
        checkingPassword.add(lockPassword[2]);
        checkingPassword.add(lockPassword[3]);
        _isAuthenticated = true;
      });
      await Future.delayed(const Duration(milliseconds: 100), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => const MainScreen()),
              (route) => false);
      });
    }
  }

  Future<List<int>> _fetchPassword() async {
    const storage = FlutterSecureStorage();
    List<int> lockPassword = stringToList(((await storage.read(key: "lockPassword")) ?? ""));
    return lockPassword;
  }

}
