import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woo_yeon_hi/screen/login/password_reset_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/style/text_style.dart';

class PasswordEnterScreen extends StatefulWidget {
  const PasswordEnterScreen({super.key});

  @override
  State<PasswordEnterScreen> createState() => _PasswordEnterScreenState();
}

class _PasswordEnterScreenState extends State<PasswordEnterScreen> {
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
          SizedBox(height: deviceHeight * 0.2),
          const Text("비밀번호 입력", style: TextStyleFamily.passwordTextStyle),
          SizedBox(height: deviceHeight * 0.1),
          SizedBox(
            width: deviceWidth * 0.6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: 50,
                    height: 50,
                    child: SvgPicture.asset(
                        "lib/assets/icons/woo_yeon_hi_48px.svg",
                        height: 50,
                        width: 50)),
                SizedBox(
                    width: 50,
                    height: 50,
                    child: SvgPicture.asset(
                        "lib/assets/icons/woo_yeon_hi_48px.svg",
                        height: 50,
                        width: 50)),
                SizedBox(
                    width: 50,
                    child: SvgPicture.asset(
                        "lib/assets/icons/password_bar_24px.svg")),
                SizedBox(
                    width: 50,
                    child: SvgPicture.asset(
                        "lib/assets/icons/password_bar_24px.svg")),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.only(right: deviceWidth * 0.08),
            child: TextButton(
                style: ButtonStyle(
                    overlayColor:
                        MaterialStateProperty.all<Color>(Colors.transparent)),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const PasswordResetScreen()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
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
          SizedBox(height: deviceHeight * 0.18),
          SizedBox(
            width: deviceWidth * 0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: deviceHeight * 0.08,
                  width: deviceWidth * 0.3,
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
                  width: deviceWidth * 0.3,
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
                  width: deviceWidth * 0.3,
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
            width: deviceWidth * 0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: deviceHeight * 0.08,
                  width: deviceWidth * 0.3,
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
                  width: deviceWidth * 0.3,
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
                  width: deviceWidth * 0.3,
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
            width: deviceWidth * 0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: deviceHeight * 0.08,
                  width: deviceWidth * 0.3,
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
                  width: deviceWidth * 0.3,
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
                  width: deviceWidth * 0.3,
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
            width: deviceWidth * 0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: deviceHeight * 0.08,
                  width: deviceWidth * 0.3,
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
                  width: deviceWidth * 0.3,
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
                  width: deviceWidth * 0.3,
                  child: InkWell(
                    onTap: () {
                      print("지우기 클릭됨");
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
    ));
  }
}
