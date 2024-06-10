import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/screen/login/password_reset_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/style/text_style.dart';

import '../../provider/password_provider.dart';

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
    return ChangeNotifierProvider(
        create: (context) => PasswordEnterProvider(),
        child: Consumer<PasswordEnterProvider>(
            builder: (context, provider, _) {
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
                  return provider.buildPasswordIcon(
                      index < provider.checkingPasswordList.length);
                })),
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
            height: deviceHeight * 0.08,
            width: deviceWidth - 40,
            child: Row(
              children: [
                SizedBox(
                  height: deviceHeight * 0.08,
                  width: (deviceWidth - 40) / 3,
                  child: InkWell(
                    onTap: () {
                      provider.addNumber(1, context);
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
                      provider.addNumber(2, context);
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
                      provider.addNumber(3, context);
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
                      provider.addNumber(4, context);
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
                      provider.addNumber(5, context);
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
                      provider.addNumber(6, context);
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
                      provider.addNumber(7, context);
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
                      provider.addNumber(8, context);
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
                      provider.addNumber(9, context);
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
                      provider.addNumber(0, context);
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
                      provider.removeNumber();
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
    ));}));
  }
}
