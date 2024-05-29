import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
    return Scaffold(
        body: Container(
      color: ColorFamily.cream,
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 175)),
            Container(
                child: Text("비밀번호 입력",
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
            Padding(padding: EdgeInsets.only(top: 10)),
            Container(
              padding: EdgeInsets.only(right: 60),
              child: TextButton(
                style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all<Color>(
                        Colors.transparent)),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) =>
                              PasswordResetScreen()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "비밀번호를 모르겠어요",
                      style: TextStyle(
                          color: ColorFamily.black,
                          fontSize: 12,
                          fontFamily: FontFamily.mapleStoryLight),
                    ),
                    Padding(padding: EdgeInsets.only(right: 5)),
                    Text(
                      ">",
                      style: TextStyle(
                          color: ColorFamily.black,
                          fontSize: 10,
                          fontFamily: FontFamily.mapleStoryLight),
                    )
                  ],
                )
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 200)),
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
                        onTap: () {},
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
    ));
  }
}
