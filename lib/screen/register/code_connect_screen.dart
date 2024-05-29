import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woo_yeon_hi/screen/register/d_day_setting_screen.dart';
import 'package:woo_yeon_hi/screen/register/register_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';

import '../../style/text_style.dart';

class CodeConnectScreen extends StatefulWidget {
  const CodeConnectScreen({super.key});

  @override
  State<CodeConnectScreen> createState() => _ConnectCodeScreenState();
}

class _ConnectCodeScreenState extends State<CodeConnectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: ColorFamily.cream,
          padding: EdgeInsets.all(20),
          child: Stack(
            children: [
              ListView(
                children: [
                  Column(
                    children: [
                      Container(
                          height: 750,
                          child: Column(children: [
                            Container(
                                height: 700,
                                child: Column(
                                  children: [
                                    Padding(padding: EdgeInsets.only(top: 60)),
                                    Container(
                                      child: Text(
                                        "1 / 5",
                                        style: TextStyle(
                                            fontFamily:
                                                FontFamily.mapleStoryBold,
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
                                        "연결코드를 생성하여 연인을 초대하세요",
                                        style: TextStyleFamily.smallTitleTextStyle,
                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.only(top: 30)),
                                    // 연결코드 생성 버튼 클릭시 노출
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(left: 40)),
                                          Text(
                                            "1f23gh",
                                            style: TextStyle(
                                                fontFamily:
                                                    FontFamily.mapleStoryLight,
                                                fontSize: 24,
                                                color: ColorFamily.black),
                                          ),
                                          IconButton(
                                              onPressed: () {},
                                              icon: SvgPicture.asset(
                                                  "lib/assets/icons/send.svg"))
                                        ],
                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.only(top: 30)),
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Material(
                                          color: ColorFamily.beige,
                                          elevation: 0.5,
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
                                                            DdaySettingScreen()));
                                              },
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              child: Container(
                                                  height: 40,
                                                  width: 160,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      // "연결코드 생성",
                                                      "상대 연결 확인",
                                                      style: TextStyleFamily.normalTextStyle,
                                                    ),
                                                  ))),
                                        ),
                                        Container(
                                          alignment:
                                              Alignment.centerRight,
                                          padding: EdgeInsets.only(right: 30),
                                          child: Column(
                                            children: [
                                              Text("코드 유효시간",
                                                  style: TextStyle(
                                                      color: ColorFamily.pink,
                                                      fontSize: 12,
                                                      fontFamily: FontFamily
                                                          .mapleStoryLight)),
                                              Text("04:59",
                                                  style: TextStyle(
                                                      color: ColorFamily.pink,
                                                      fontSize: 12,
                                                      fontFamily: FontFamily
                                                          .mapleStoryLight))
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Padding(padding: EdgeInsets.only(top: 80)),
                                    Container(
                                      child: Text(
                                        "초대를 받았다면 상대의 연결코드를 입력해주세요",
                                        style: TextStyleFamily.smallTitleTextStyle,
                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.only(top: 20)),
                                    Container(
                                      width: 160,
                                      child: TextField(
                                        decoration: InputDecoration(
                                          counter: SizedBox(),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: ColorFamily.black))),
                                        cursorColor: ColorFamily.black,
                                        maxLength: 6,
                                        keyboardType: TextInputType.text,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[a-zA-Z0-9]')),
                                        ],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: ColorFamily.black,
                                            fontSize: 24,
                                            fontFamily:
                                                FontFamily.mapleStoryLight),
                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.only(top: 30)),
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Material(
                                          color: ColorFamily.beige,
                                          elevation: 0.5,
                                          shadowColor: Colors.black,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          child: InkWell(
                                              onTap: () {},
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              child: Container(
                                                  height: 40,
                                                  width: 160,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "연결하기",
                                                      style: TextStyleFamily.normalTextStyle,
                                                    ),
                                                  ))),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                          ])),
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
                                    style: TextStyleFamily.normalTextStyle,
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
