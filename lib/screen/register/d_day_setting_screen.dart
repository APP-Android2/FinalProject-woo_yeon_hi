import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:woo_yeon_hi/screen/register/nickname_setting_screen.dart';
import 'package:woo_yeon_hi/screen/register/register_screen.dart';

import '../../style/color.dart';
import '../../style/font.dart';

class DdaySettingScreen extends StatelessWidget {
  const DdaySettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.all(20),
          child: Stack(
            children: [
              ListView(
                children: [
                  Column(
                    children: [
                      Container(
                        height: 750,
                        child: Column(
                          children: [
                            Container(
                              height: 650,
                              child: Column(
                                children: [
                                  Padding(padding: EdgeInsets.only(top: 60)),
                                  Container(
                                    child: Text(
                                      "2 / 5",
                                      style: TextStyle(
                                          fontFamily: FontFamily.mapleStoryBold,
                                          fontSize: 15,
                                          color: ColorFamily.pink),
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(top: 20)),
                                  Container(
                                      child: Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "lib/assets/images/heart_fill.png",
                                          height: 24,
                                        ),
                                        Image.asset(
                                          "lib/assets/images/triple_right_arrow.png",
                                          height: 24,
                                        ),
                                        Image.asset(
                                          "lib/assets/images/heart_fill.png",
                                          height: 24,
                                        ),
                                        Image.asset(
                                          "lib/assets/images/triple_right_arrow.png",
                                          height: 24,
                                        ),
                                        Image.asset(
                                          "lib/assets/images/heart_outlined.png",
                                          height: 24,
                                        ),
                                        Image.asset(
                                          "lib/assets/images/triple_right_arrow.png",
                                          height: 24,
                                        ),
                                        Image.asset(
                                          "lib/assets/images/heart_outlined.png",
                                          height: 24,
                                        ),
                                        Image.asset(
                                          "lib/assets/images/triple_right_arrow.png",
                                          height: 24,
                                        ),
                                        Image.asset(
                                          "lib/assets/images/heart_outlined.png",
                                          height: 24,
                                        ),
                                      ],
                                    ),
                                  )),
                                  Padding(padding: EdgeInsets.only(top: 50)),
                                  Container(
                                    child: Text(
                                      "연인이 된 날을 선택해주세요!",
                                      style: TextStyle(
                                          color: ColorFamily.black,
                                          fontSize: 15,
                                          fontFamily:
                                              FontFamily.mapleStoryLight),
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(top: 50)),
                                  Container(
                                    height: 320,
                                    width: 360,
                                    color: Colors.white,
                                    child: Text("이 공간에는 캘린더가 들어갑니다."),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Padding(padding: EdgeInsets.only(left: 50)),
                                  Expanded(
                                    child: Container(height: 40, width: 150),
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 20)),
                                  Expanded(
                                    child: Material(
                                      color: ColorFamily.beige,
                                      elevation: 1.0,
                                      shadowColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      NickNameSettingScreen()));
                                        },
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        child: Container(
                                            height: 40,
                                            width: 150,
                                            child: Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                // "연결코드 생성",
                                                "다음",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: FontFamily
                                                        .mapleStoryLight),
                                              ),
                                            )),
                                      ),
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 50)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 16, 16, 0),
                            child: TextButton(
                              style: ButtonStyle(
                                  overlayColor:
                                      MaterialStateProperty.all<Color>(
                                          ColorFamily.beige)),
                              onPressed: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RegisterScreen()));
                              },
                              child: Column(
                                children: [
                                  Text(
                                    "로그아웃",
                                    style: TextStyle(
                                        color: ColorFamily.black,
                                        fontSize: 14,
                                        fontFamily: FontFamily.mapleStoryLight),
                                  )
                                ],
                              ),
                            ),
                          ))
                    ],
                  ),
                ],
              )
            ],
          )),
    );
  }
}
