import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/widget/login/password_reset_top_app_bar.dart';

import '../../style/text_style.dart';

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({super.key});

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PasswordResetTopAppBar(),
        body: Container(
            padding: EdgeInsets.all(20),
            color: ColorFamily.cream,
            child: ListView(children: [
              Container(
                  height: 300,
                  child: Column(children: [
                    Padding(padding: EdgeInsets.only(top: 50)),
                    Container(
                      padding: EdgeInsets.only(left: 30),
                      alignment: Alignment.centerLeft,
                      child: Text("로그인 계정 정보",
                          style: TextStyleFamily.smallTitleTextStyle),
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Material(
                          borderRadius: BorderRadius.circular(20),
                          color: ColorFamily.white,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.all(3),
                            height: 60,
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
                                        style:
                                            TextStyleFamily.normalTextStyle)),
                              ],
                            ),
                          )),
                    ),
                    Padding(padding: EdgeInsets.only(top: 30)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 30),
                          alignment: Alignment.centerLeft,
                          child: Text("인증번호 입력",
                              style: TextStyleFamily.smallTitleTextStyle),
                        ),
                        Padding(padding: EdgeInsets.only(top: 20)),
                        Container(
                          child: Row(children: <Widget>[
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(left: 30),
                                height: 40,
                                child: TextField(
                                  decoration: InputDecoration(
                                    counter: SizedBox(),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: ColorFamily.black))),
                                  cursorColor: ColorFamily.black,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  maxLength: 6,
                                  style: TextStyle(
                                      color: ColorFamily.black,
                                      fontSize: 20,
                                      fontFamily: FontFamily.mapleStoryLight),
                                ),
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(right: 10)),
                            Container(
                              padding: EdgeInsets.only(right: 20),
                              alignment: Alignment.centerRight,
                              child: Material(
                                color: ColorFamily.beige,
                                borderRadius: BorderRadius.circular(20),
                                elevation: 0.5,
                                child: Container(
                                  height: 40,
                                  width: 120,
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "인증 요청",
                                      style: TextStyleFamily.normalTextStyle,
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
                              ),
                            )
                          ]),
                        )
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(right: 60),
                        child: Text("04:59",
                            style: TextStyle(
                                color: ColorFamily.black,
                                fontFamily: FontFamily.mapleStoryLight,
                                fontSize: 12)))
                  ])),
              Padding(padding: EdgeInsets.only(top: 20)),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
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
                        "확인",
                        style: TextStyleFamily.normalTextStyle,
                      ),
                    ),
                  ),
                ),
              ),
            ])));
  }
}
