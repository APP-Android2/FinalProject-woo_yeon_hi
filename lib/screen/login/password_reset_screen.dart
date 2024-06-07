import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
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
  String loginAccount = "kakao1234@google.com";

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: const PasswordResetTopAppBar(),
        body: Container(
            width: deviceWidth,
            height: deviceHeight,
            padding: const EdgeInsets.all(20),
            color: ColorFamily.cream,
            child: SingleChildScrollView(
              child: Column(children: [
                SizedBox(height: deviceHeight * 0.02),
                Container(
                  padding: const EdgeInsets.only(left: 30),
                  alignment: Alignment.centerLeft,
                  child: const Text("로그인 계정 정보",
                      style: TextStyleFamily.smallTitleTextStyle),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: deviceWidth - 80,
                  child: Material(
                      borderRadius: BorderRadius.circular(20),
                      color: ColorFamily.white,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(3),
                        height: deviceHeight * 0.065,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(10, 2, 0, 0),
                              child: Text("구글 로그인",
                                  style: TextStyle(
                                      color: ColorFamily.black,
                                      fontFamily: FontFamily.mapleStoryLight,
                                      fontSize: 12)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(loginAccount,
                                  style: TextStyleFamily.normalTextStyle),
                            ),
                          ],
                        ),
                      )),
                ),
                const SizedBox(height: 50),
                Container(
                  padding: const EdgeInsets.only(left: 30),
                  alignment: Alignment.centerLeft,
                  child: const Text("인증번호 입력",
                      style: TextStyleFamily.smallTitleTextStyle),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: deviceWidth - 80,
                  child: Row(children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 10),
                        height: deviceHeight * 0.045,
                        child: const TextField(
                          decoration: InputDecoration(
                              counter: SizedBox(),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: ColorFamily.black))),
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
                    const SizedBox(width: 10),
                    Material(
                      color: ColorFamily.beige,
                      borderRadius: BorderRadius.circular(20),
                      elevation: 0.5,
                      child: SizedBox(
                        height: deviceHeight * 0.045,
                        width: deviceWidth * 0.3,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
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
                    )
                  ]),
                ),
                SizedBox(
                  width: deviceWidth - 80,
                  child: Row(children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 10),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      alignment: Alignment.center,
                      height: deviceHeight * 0.045,
                      width: deviceWidth * 0.3,
                      child: TimerCountdown(
                          format: CountDownTimerFormat.minutesSeconds,
                          enableDescriptions: false,
                          timeTextStyle: const TextStyle(
                              color: ColorFamily.black,
                              fontSize: 12,
                              fontFamily: FontFamily.mapleStoryLight),
                          colonsTextStyle: const TextStyle(
                              color: ColorFamily.black,
                              fontSize: 12,
                              fontFamily: FontFamily.mapleStoryLight),
                          spacerWidth: 2,
                          endTime: DateTime.now().add(
                            const Duration(minutes: 5, seconds: 00),
                          ),
                          onEnd: () {}),
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
                  ]),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: deviceWidth - 80,
                  height: deviceHeight * 0.045,
                  child: Material(
                    color: ColorFamily.beige,
                    elevation: 0.5,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: InkWell(
                      onTap: () {
                        //인증번호 유효성 확인 후, 앱 잠금 초기화(잠금 비활성 및 비밀번호 데이터 삭제) 한 뒤,
                        //화면 이동(메인 스크린)
                      },
                      borderRadius: BorderRadius.circular(20.0),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "확인",
                          style: TextStyleFamily.normalTextStyle,
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            )));
  }
}
