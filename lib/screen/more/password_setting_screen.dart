import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/provider/more_provider.dart';
import 'package:woo_yeon_hi/screen/more/app_lock_setting_screen.dart';
import 'package:woo_yeon_hi/screen/more/password_check_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';

import '../../style/text_style.dart';

class PasswordSettingScreen extends StatefulWidget {
  const PasswordSettingScreen({super.key});

  @override
  State<PasswordSettingScreen> createState() => _PasswordSettingScreenState();
}

class _PasswordSettingScreenState extends State<PasswordSettingScreen> {
  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AppLockSettingScreen())),
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: ColorFamily.cream,
          backgroundColor: ColorFamily.cream,
          centerTitle: true,
          title: const Text("앱 잠금 설정", style: TextStyleFamily.appBarTitleLightTextStyle,),
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AppLockSettingScreen()));
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
              const Text("비밀번호 입력",
                  style: TextStyleFamily.passwordTextStyle),
              SizedBox(height: deviceHeight * 0.08),
              SizedBox(
                height: 50,
                width: deviceWidth*0.6,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(4, (index) {
                      return _buildPasswordIcon(
                          index < passwordList.length);
                    })),
              ),
              SizedBox(height: deviceHeight*0.25),
              SizedBox(
                height: deviceHeight * 0.08,
                width: deviceWidth-40,
                child: Row(
                  children: [
                    SizedBox(
                      height: deviceHeight * 0.08,
                      width: (deviceWidth-40)/3,
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
                      width: (deviceWidth-40)/3,
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
                      width: (deviceWidth-40)/3,
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
                width: deviceWidth-40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: deviceHeight * 0.08,
                      width: (deviceWidth-40)/3,
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
                      width: (deviceWidth-40)/3,
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
                      width: (deviceWidth-40)/3,
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
                width: deviceWidth-40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: deviceHeight * 0.08,
                      width: (deviceWidth-40)/3,
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
                      width: (deviceWidth-40)/3,
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
                      width: (deviceWidth-40)/3,
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
                width: deviceWidth-40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: deviceHeight * 0.08,
                      width: (deviceWidth-40)/3,
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
                      width: (deviceWidth-40)/3,
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
                      width: (deviceWidth-40)/3,
                      child: InkWell(
                        onTap: () {
                          _removeNumber();
                        },
                        child: Container(
                            alignment: Alignment.center,
                            child: SvgPicture.asset("lib/assets/icons/backspace.svg")
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }

  Widget _buildPasswordIcon(bool isEntered) {
    return isEntered
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

  final List<int> passwordList = [];
  final int _maxNumbers = 4;

  void _numInputCheck() {
    setState(() {
      firstNumInput = passwordList.length > 0;
      secondNumInput = passwordList.length > 1;
      thirdNumInput = passwordList.length > 2;
      fourthNumInput = passwordList.length > 3;
    });
  }

  void _addNumber(int number) {
    setState(() {
      if (passwordList.length < _maxNumbers) {
        passwordList.add(number);
      }
      if (passwordList.length == _maxNumbers) {
        Provider.of<PasswordProvider>(context, listen: false).setPassword(passwordList);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const PasswordCheckScreen(),
          ),
        );
        _initiatePassword();
      }
    });
    _numInputCheck();
  }

  void _removeNumber() {
    setState(() {
      if (passwordList.isNotEmpty) {
        passwordList.removeLast();
      }
    });
    _numInputCheck();
  }

  void _initiatePassword(){
    setState(() {
      firstNumInput = false;
      secondNumInput = false;
      thirdNumInput = false;
      fourthNumInput = false;

      // password.clear();
    });
  }
}
