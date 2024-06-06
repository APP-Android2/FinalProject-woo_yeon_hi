import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/style/text_style.dart';
import 'package:woo_yeon_hi/widget/more/account_delete_top_app_bar.dart';

import '../register/register_screen.dart';

class AccountDeleteScreen extends StatefulWidget {
  const AccountDeleteScreen({super.key});

  @override
  State<AccountDeleteScreen> createState() => _AccountDeleteScreenState();
}

class _AccountDeleteScreenState extends State<AccountDeleteScreen> {

  bool isAgreed = false;

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const AccountDeleteTopAppBar(),
      body: Container(
        width: deviceWidth,
        height: deviceHeight,
        padding: const EdgeInsets.all(20),
        color: ColorFamily.cream,
        child: Column(
          children: [
            SizedBox(height: deviceHeight*0.05),
            Image.asset(
              'lib/assets/images/warning.png',
              height: 80,
            ),
            const SizedBox(height: 30),
            const Text("계정을 삭제하면", style: TextStyleFamily.smallTitleTextStyle),
            const Text("모든 데이터와 설정이 초기화됩니다.",
                style: TextStyleFamily.smallTitleTextStyle),
            const SizedBox(height: 30),
            const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("계정 삭제",
                  style: TextStyle(
                      fontSize: 15,
                      color: ColorFamily.pink,
                      fontFamily: FontFamily.mapleStoryLight)),
              Text("를 누르면 자동으로 로그아웃되며,",
                  style: TextStyleFamily.smallTitleTextStyle)
            ]),
            const Text("동일 계정으로는 30일 이내에 재가입이 불가능합니다.", style: TextStyleFamily.smallTitleTextStyle),
            const SizedBox(height: 30),
            const Text("만약 계정 삭제 취소를 원하는 경우,",
                style: TextStyle(
                fontSize: 12,
                color: ColorFamily.black,
                fontFamily: FontFamily.mapleStoryLight)),
            const Text("삭제일로부터 30일 이내에 해당 계정으로 로그인해주세요.",
                style: TextStyle(
                    fontSize: 12,
                    color: ColorFamily.black,
                    fontFamily: FontFamily.mapleStoryLight)),
            const SizedBox(height: 50),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 30),
                  const Text("위의 내용을 확인하였으며 동의합니다.",
                    style: TextStyle(
                        fontSize: 15,
                        color: ColorFamily.black,
                        fontFamily: FontFamily.mapleStoryLight)),
                  Checkbox(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                    side: const BorderSide(color: ColorFamily.black, width: 1.5),
                    checkColor: ColorFamily.white,
                    activeColor: ColorFamily.pink,
                    value: isAgreed,
                    onChanged: (bool? value) {
                      setState(() {
                        isAgreed = value!;
                      });},
                  ),
            ]),
            const SizedBox(height: 50),
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
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const RegisterScreen()),
                          (Route<dynamic> route) => false);
                  },
                  borderRadius:
                  BorderRadius.circular(20.0),
                  child: SizedBox(
                      height: 40,
                      width: deviceWidth*0.6,
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "계정 삭제",
                          style: TextStyleFamily.normalTextStyle,
                        ),
                      ))),
            ),
          ],
        ),
      ),
    );
  }
}
