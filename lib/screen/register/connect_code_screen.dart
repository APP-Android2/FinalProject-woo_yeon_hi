import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';

class ConnectCodeScreen extends StatefulWidget {
  const ConnectCodeScreen({super.key});

  @override
  State<ConnectCodeScreen> createState() => _ConnectCodeScreenState();
}

class _ConnectCodeScreenState extends State<ConnectCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        child: Stack(
          children: [
            ListView(
              children: [
                Column(
                  children: [
                    Padding(padding: EdgeInsets.only(top: 60)),
                    Container(
                      child: Text(
                        "1 / 5",
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "lib/assets/images/heart_fill.png",
                                height: 24,
                              ),
                              Padding(padding: EdgeInsets.only(right: 3)),
                              Image.asset(
                                "lib/assets/images/triple_right_arrow.png",
                                height: 24,
                              ),
                              Padding(padding: EdgeInsets.only(right: 3)),
                              Image.asset(
                                "lib/assets/images/heart_outlined.png",
                                height: 24,
                              ),
                              Padding(padding: EdgeInsets.only(right: 3)),
                              Image.asset(
                                "lib/assets/images/triple_right_arrow.png",
                                height: 24,
                              ),
                              Padding(padding: EdgeInsets.only(right: 3)),
                              Image.asset(
                                "lib/assets/images/heart_outlined.png",
                                height: 24,
                              ),
                              Padding(padding: EdgeInsets.only(right: 3)),
                              Image.asset(
                                "lib/assets/images/triple_right_arrow.png",
                                height: 24,
                              ),
                              Padding(padding: EdgeInsets.only(right: 3)),
                              Image.asset(
                                "lib/assets/images/heart_outlined.png",
                                height: 24,
                              ),
                              Padding(padding: EdgeInsets.only(right: 3)),
                              Image.asset(
                                "lib/assets/images/triple_right_arrow.png",
                                height: 24,
                              ),
                              Padding(padding: EdgeInsets.only(right: 3)),
                              Image.asset(
                                "lib/assets/images/heart_outlined.png",
                                height: 24,
                              ),
                            ],
                          ),
                        )),
                    Padding(padding: EdgeInsets.only(top: 80)),
                    Container(
                      child: Text(
                        "연결코드를 생성하여 연인을 초대하세요",
                        style: TextStyle(
                            color: ColorFamily.black,
                            fontSize: 15,
                            fontFamily: FontFamily.mapleStoryLight),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 30)),
                    // 연결코드 생성 버튼 클릭시 노출
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(padding: EdgeInsets.only(left: 40)),
                          Text(
                            "1f23gh",
                            style: TextStyle(
                                fontFamily: FontFamily.mapleStoryLight,
                                fontSize: 24,
                                color: ColorFamily.black),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon:
                              SvgPicture.asset("lib/assets/icons/send.svg"))
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 30)),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Material(
                          color: ColorFamily.beige,
                          elevation: 1.0,
                          shadowColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(20.0),
                              child: Container(
                                  height: 40,
                                  width: 200,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      // "연결코드 생성",
                                      "상대 연결 확인",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily:
                                          FontFamily.mapleStoryLight),
                                    ),
                                  ))),
                        ),
                        Container(
                          alignment: AlignmentDirectional.centerEnd,
                          padding: EdgeInsets.only(right: 20),
                          child: Column(
                            children: [
                              Text("코드 유효시간",
                                  style: TextStyle(
                                      color: ColorFamily.pink,
                                      fontSize: 12,
                                      fontFamily: FontFamily.mapleStoryLight)),
                              Text("4:59",
                                  style: TextStyle(
                                      color: ColorFamily.pink,
                                      fontSize: 12,
                                      fontFamily: FontFamily.mapleStoryLight))
                            ],
                          ),
                        )
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(top: 80)),
                    Container(
                      child: Text(
                        "초대를 받았다면 상대의 연결코드를 입력해주세요",
                        style: TextStyle(
                            color: ColorFamily.black,
                            fontSize: 15,
                            fontFamily: FontFamily.mapleStoryLight),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 30)),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 100),
                      child: TextField(
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                BorderSide(color: ColorFamily.black))),
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
                            fontFamily: FontFamily.mapleStoryLight),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 30)),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Material(
                          color: ColorFamily.beige,
                          elevation: 1.0,
                          shadowColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(20.0),
                              child: Container(
                                  height: 40,
                                  width: 200,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      // "연결코드 생성",
                                      "연결하기",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily:
                                          FontFamily.mapleStoryLight),
                                    ),
                                  ))),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 54, 16, 0),
                          child: TextButton(
                            style: ButtonStyle(overlayColor: MaterialStateProperty.all<Color>(ColorFamily.beige)),
                            onPressed: () {},
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
        ));
  }
}
