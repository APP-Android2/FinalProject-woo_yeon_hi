import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({super.key});

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.all(20),
            color: ColorFamily.cream,
            child: ListView(children: [
              Container(
                  height: 380,
                  child: Column(children: [
                    Padding(padding: EdgeInsets.only(top: 100)),
                    Container(
                      padding: EdgeInsets.only(left: 40),
                      alignment: Alignment.centerLeft,
                      child: Text("로그인 계정 정보",
                          style: TextStyle(
                              fontFamily: FontFamily.mapleStoryLight,
                              fontSize: 14,
                              color: ColorFamily.black)),
                    ),
                    Padding(padding: EdgeInsets.only(top: 20)),
                    Material(
                        borderRadius: BorderRadius.circular(20),
                        color: ColorFamily.white,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.all(3),
                          height: 60,
                          width: 350,
                          child: Row(
                            children: [
                              Container(
                                  padding: EdgeInsets.fromLTRB(10, 2, 0, 0),
                                  child: Text("구글 로그인",
                                      style: TextStyle(
                                          color: ColorFamily.black,
                                          fontFamily:
                                              FontFamily.mapleStoryLight,
                                          fontSize: 12))),
                              Container(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text("googlegoogle1234@gmail.com",
                                      style: TextStyle(
                                          color: ColorFamily.black,
                                          fontFamily:
                                              FontFamily.mapleStoryLight,
                                          fontSize: 14))),
                            ],
                          ),
                        )),
                    Padding(padding: EdgeInsets.only(top: 30)),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 40),
                            alignment: Alignment.centerLeft,
                            child: Text("인증번호 입력",
                                style: TextStyle(
                                    fontFamily: FontFamily.mapleStoryLight,
                                    fontSize: 14,
                                    color: ColorFamily.black)),
                          ),
                          Padding(padding: EdgeInsets.only(top: 20)),
                          Row(
                            children: [
                              Container(
                                height: 40,
                                width: 250,
                                padding: EdgeInsets.only(left: 40),
                                child: TextField(
                                  decoration: InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: ColorFamily.black))),
                                  cursorColor: ColorFamily.black,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: ColorFamily.black,
                                      fontSize: 20,
                                      fontFamily: FontFamily.mapleStoryLight),
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(right: 30)),
                              Material(
                                color: ColorFamily.beige,
                                borderRadius: BorderRadius.circular(20),
                                elevation: 0.5,
                                child: Container(
                                  height: 40,
                                  width: 100,
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "인증 요청",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily:
                                              FontFamily.mapleStoryLight,
                                          color: ColorFamily.black),
                                    ),
                                  ),
                                  // TextButton(
                                  //   onPressed: () {},
                                  //   child: Text(
                                  //     "재전송",
                                  //     style: TextStyle(
                                  //         fontSize: 14,
                                  //         fontFamily: FontFamily.mapleStoryLight,
                                  //         color: ColorFamily.black),
                                  //   ),
                                  // ),
                                ),
                              )
                            ],
                          ),
                          Padding(padding: EdgeInsets.only(top: 10)),
                          Container(
                              padding: EdgeInsets.only(left: 250),
                              child: Text("04:59",
                                  style: TextStyle(
                                      color: ColorFamily.black,
                                      fontFamily: FontFamily.mapleStoryLight,
                                      fontSize: 12)))
                        ])
                  ])),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Material(
                  color: ColorFamily.beige,
                  elevation: 0.5,
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                      height: 40,
                      alignment: Alignment.center,
                      child: Text(
                        // "연결코드 생성",
                        "확인",
                        style: TextStyle(
                            fontSize: 15, fontFamily: FontFamily.mapleStoryLight),
                      ),
                    ),
                  ),
                ),
              ),
            ])));
  }
}
