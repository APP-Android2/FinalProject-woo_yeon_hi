import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/style/text_style.dart';
import 'package:woo_yeon_hi/widget/more/account_delete_top_app_bar.dart';

class AccountDeleteScreen extends StatefulWidget {
  const AccountDeleteScreen({super.key});

  @override
  State<AccountDeleteScreen> createState() => _AccountDeleteScreenState();
}

class _AccountDeleteScreenState extends State<AccountDeleteScreen> {

  bool isAgreed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AccountDeleteTopAppBar(),
      body: Container(
        padding: EdgeInsets.all(20),
        color: ColorFamily.cream,
        child: Column(
          children: [
            SizedBox(height: 30),
            Image.asset(
              'lib/assets/images/warning.png',
              height: 80,
            ),
            SizedBox(height: 30),
            Text("계정을 삭제하면", style: TextStyleFamily.smallTitleTextStyle),
            Text("모든 데이터와 설정이 초기화됩니다.",
                style: TextStyleFamily.smallTitleTextStyle),
            SizedBox(height: 30),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("계정 삭제",
                  style: TextStyle(
                      fontSize: 15,
                      color: ColorFamily.pink,
                      fontFamily: FontFamily.mapleStoryLight)),
              Text("를 누르면 자동으로 로그아웃되며,",
                  style: TextStyleFamily.smallTitleTextStyle)
            ]),
            Text("다시 로그인 시 새롭게 커플 연결이 가능합니다.", style: TextStyleFamily.smallTitleTextStyle),
            SizedBox(height: 30),
            Text("삭제 취소를 원할 경우, 삭제일로부터 30일 이내에",
                style: TextStyle(
                fontSize: 12,
                color: ColorFamily.black,
                fontFamily: FontFamily.mapleStoryLight)),
            Text("해당 계정으로 로그인 시 취소가 가능합니다.",
                style: TextStyle(
                    fontSize: 12,
                    color: ColorFamily.black,
                    fontFamily: FontFamily.mapleStoryLight)),
            SizedBox(height: 50),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 30),
                  Text("위의 내용을 확인하였으며 동의합니다.",
                    style: TextStyle(
                        fontSize: 15,
                        color: ColorFamily.black,
                        fontFamily: FontFamily.mapleStoryLight)),
                  Checkbox(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                    checkColor: ColorFamily.white,
                    activeColor: ColorFamily.pink,
                    value: isAgreed,
                    onChanged: (bool? value) {
                      setState(() {
                        isAgreed = value!;
                      });},
                  ),
            ]),
            SizedBox(height: 50),
            Material(
              color: ColorFamily.pink,
              elevation: 1,
              shadowColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(20.0),
              ),
              child: InkWell(
                  onTap: () {
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
                  },
                  borderRadius:
                  BorderRadius.circular(20.0),
                  child: Container(
                      height: 40,
                      width: 160,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          "계정 삭제",
                          style: TextStyle(fontFamily: FontFamily.mapleStoryLight, color: ColorFamily.black, fontSize: 14),
                        ),
                      ))),
            ),
          ],
        ),
      ),
    );
  }
}
