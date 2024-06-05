import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woo_yeon_hi/screen/register/d_day_setting_screen.dart';
import 'package:woo_yeon_hi/screen/register/nickname_setting_screen.dart';
import 'package:woo_yeon_hi/screen/register/register_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

import '../../style/text_style.dart';

class CodeConnectScreen extends StatefulWidget {
  const CodeConnectScreen({super.key});

  @override
  State<CodeConnectScreen> createState() => _ConnectCodeScreenState();
}

class _ConnectCodeScreenState extends State<CodeConnectScreen> {
  bool _isCodeGenerated = false;
  String _codeText = "";
  String _randomCode = getRandomString(8);

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Container(
      color: ColorFamily.cream,
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
              height: deviceHeight - 40,
              width: deviceWidth - 40,
              child: Column(
                children: [
                  SizedBox(
                      height: deviceHeight - 90,
                      width: deviceWidth - 40,
                      child: Column(children: [
                        SizedBox(
                            height: deviceHeight - 170,
                            width: deviceWidth - 40,
                            child: Column(
                              children: [
                                SizedBox(height: deviceHeight * 0.1),
                                const Text(
                                  "1 / 5",
                                  style: TextStyle(
                                      fontFamily: FontFamily.mapleStoryBold,
                                      fontSize: 15,
                                      color: ColorFamily.pink),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                        'lib/assets/icons/heart_fill.svg',
                                        height: 24),
                                    SvgPicture.asset(
                                        'lib/assets/icons/triple_right_arrow.svg',
                                        height: 24),
                                    SvgPicture.asset(
                                        'lib/assets/icons/heart_outlined.svg',
                                        height: 24),
                                    SvgPicture.asset(
                                        'lib/assets/icons/triple_right_arrow.svg',
                                        height: 24),
                                    SvgPicture.asset(
                                        'lib/assets/icons/heart_outlined.svg',
                                        height: 24),
                                    SvgPicture.asset(
                                        'lib/assets/icons/triple_right_arrow.svg',
                                        height: 24),
                                    SvgPicture.asset(
                                        'lib/assets/icons/heart_outlined.svg',
                                        height: 24),
                                    SvgPicture.asset(
                                        'lib/assets/icons/triple_right_arrow.svg',
                                        height: 24),
                                    SvgPicture.asset(
                                        'lib/assets/icons/heart_outlined.svg',
                                        height: 24),
                                  ],
                                ),
                                SizedBox(height: deviceHeight *0.07),
                                const Text(
                                  "연결코드를 생성하여 연인을 초대하세요",
                                  style: TextStyleFamily.smallTitleTextStyle,
                                ),
                                !_isCodeGenerated
                                    ? const SizedBox()
                                    : Padding(
                                        padding: const EdgeInsets.only(top: 30),
                                        child: SizedBox(
                                          height: 50,
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Text(_codeText,
                                                  style: const TextStyle(
                                                      color: ColorFamily.black,
                                                      fontSize: 22,
                                                      fontFamily: FontFamily
                                                          .mapleStoryLight)),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 200),
                                                child: IconButton(
                                                    onPressed: () {
                                                      Share.share(_randomCode);
                                                    },
                                                    icon: SvgPicture.asset(
                                                        'lib/assets/icons/send.svg')),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                _isCodeGenerated
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: SizedBox(
                                          height: 25,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text("코드 유효시간",
                                                  style: TextStyle(
                                                      color: ColorFamily.pink,
                                                      fontSize: 14,
                                                      fontFamily: FontFamily
                                                          .mapleStoryLight)),
                                              const SizedBox(width: 10),
                                              TimerCountdown(
                                                  format: CountDownTimerFormat
                                                      .minutesSeconds,
                                                  enableDescriptions: false,
                                                  timeTextStyle:
                                                      const TextStyle(
                                                          color:
                                                              ColorFamily.pink,
                                                          fontSize: 14,
                                                          fontFamily: FontFamily
                                                              .mapleStoryLight),
                                                  colonsTextStyle:
                                                      const TextStyle(
                                                          color:
                                                              ColorFamily.pink,
                                                          fontSize: 14,
                                                          fontFamily: FontFamily
                                                              .mapleStoryLight),
                                                  spacerWidth: 5,
                                                  endTime: DateTime.now().add(
                                                    const Duration(
                                                        minutes: 5,
                                                        seconds: 00),
                                                  ),
                                                  onEnd: () {
                                                    setState(() {
                                                      _randomCode =
                                                          "$_randomCode+a";
                                                    });
                                                  })
                                            ],
                                          ),
                                        ))
                                    : const SizedBox(height: 25),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Material(
                                    color: ColorFamily.beige,
                                    elevation: 0.5,
                                    shadowColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: !_isCodeGenerated
                                        ? InkWell(
                                            onTap: () {
                                              setState(() {
                                                _codeText = _randomCode;
                                                _isCodeGenerated = true;
                                              });
                                            },
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            child: Container(
                                              height: deviceHeight*0.045,
                                              width: deviceWidth*0.4,
                                              alignment: Alignment.center,
                                              child: const Text(
                                                "연결코드 생성",
                                                style: TextStyleFamily
                                                    .normalTextStyle,
                                              ),
                                            ))
                                        : InkWell(
                                            onTap: () {
                                              //TODO 해당 코드로 연결한 상대가 있는지 여부 파악
                                              //없을 시 토스트메시지 노출("연결된 상대가 없습니다.")
                                              //있을 시 해당 코드 만료 후,
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DdaySettingScreen(
                                                              isHost: true)));
                                            },
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            child: Container(
                                              height: deviceHeight/21,
                                              width: deviceWidth/3,
                                              alignment: Alignment.center,
                                              child: const Text(
                                                "상대 연결 확인",
                                                style: TextStyleFamily
                                                    .normalTextStyle,
                                              ),
                                            )),
                                  ),
                                ),
                                SizedBox(height: deviceHeight / 12),
                                const Text(
                                  "초대를 받았다면 상대의 연결코드를 입력해주세요",
                                  style: TextStyleFamily.smallTitleTextStyle,
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: 160,
                                  child: TextField(
                                    onTapOutside: (event) {
                                      FocusScope.of(context).unfocus();
                                    },
                                    decoration: const InputDecoration(
                                        counter: SizedBox(),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: ColorFamily.black))),
                                    cursorColor: ColorFamily.black,
                                    maxLength: 8,
                                    keyboardType: TextInputType.text,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[a-zA-Z0-9]')),
                                    ],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: ColorFamily.black,
                                        fontSize: 22,
                                        fontFamily: FontFamily.mapleStoryLight),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                Material(
                                  color: ColorFamily.beige,
                                  elevation: 0.5,
                                  shadowColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: InkWell(
                                      onTap: () {
                                        //TODO 입력값이 현재 유효한지 체크
                                        //유효하지 않다면 토스트메시지 출력("해당 코드는 유효하지 않은 코드입니다.")
                                        //유효하다면
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    NickNameSettingScreen(
                                                        isHost: false)));
                                      },
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Container(
                                        height: deviceHeight*0.045,
                                        width: deviceWidth*0.4,
                                        alignment: Alignment.center,
                                        child: const Text(
                                          "연결하기",
                                          style:
                                              TextStyleFamily.normalTextStyle,
                                        ),
                                      )),
                                ),
                              ],
                            )),
                      ])),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterScreen()));
                      },
                      child: const Text(
                        "로그아웃",
                        style: TextStyleFamily.normalTextStyle,
                      ),
                    ),
                  )
                ],
              )),
        ],
      )),
    ));
  }
}

const _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
