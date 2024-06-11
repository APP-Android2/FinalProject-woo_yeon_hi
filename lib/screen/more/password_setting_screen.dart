import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/screen/more/app_lock_setting_screen.dart';
import 'package:woo_yeon_hi/screen/more/password_check_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';

import '../../style/text_style.dart';

class PasswordSettingScreen extends StatefulWidget {
  final bool bioAuth;

  const PasswordSettingScreen({required this.bioAuth, super.key});

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
      onPopInvoked: (didPop) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AppLockSettingScreen(bioAuth: widget.bioAuth))),
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: ColorFamily.cream,
          backgroundColor: ColorFamily.cream,
          centerTitle: true,
          title: const Text("앱 잠금 설정", style: TextStyleFamily.appBarTitleLightTextStyle,),
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AppLockSettingScreen(bioAuth: widget.bioAuth)));
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
                          index < password.length);
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

  final List<int> password = [];
  final int _maxNumbers = 4;

  void _numInputCheck() {
    setState(() {
      firstNumInput = password.length > 0;
      secondNumInput = password.length > 1;
      thirdNumInput = password.length > 2;
      fourthNumInput = password.length > 3;
    });
  }

  void _addNumber(int number) {
    setState(() {
      if (password.length < _maxNumbers) {
        password.add(number);
      }
      if (password.length == _maxNumbers) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PasswordCheckScreen(bioAuth: widget.bioAuth, password: password),
          ),
        );
        _initiatePassword();
      }
    });
    _numInputCheck();
  }

  void _removeNumber() {
    setState(() {
      if (password.isNotEmpty) {
        password.removeLast();
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
