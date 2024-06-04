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
  bool _iscodeGenerated = false;
  String _codeText = "연결코드 생성";
  String _randomCode = getRandomString(8);


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).unfocus();
    });
  }

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
                                    )),
                                    Padding(padding: EdgeInsets.only(top: 50)),
                                    Container(
                                      child: Text(
                                        "연결코드를 생성하여 연인을 초대하세요",
                                        style:
                                            TextStyleFamily.smallTitleTextStyle,
                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.only(top: 30)),
                                    Container(
                                      height: 48,
                                      width: 340,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              !_iscodeGenerated
                                                  ? setState(() {
                                                      _codeText = _randomCode;
                                                      _iscodeGenerated = true;
                                                    })
                                                  : null;
                                            },
                                            child: Text(
                                              "$_codeText",
                                              style: TextStyle(
                                                  fontFamily: FontFamily
                                                      .mapleStoryLight,
                                                  fontSize: 22,
                                                  color: ColorFamily.black),
                                            ),
                                          ),
                                          _iscodeGenerated
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 50),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: IconButton(
                                                        onPressed: () {
                                                          Share.share(
                                                              '$_randomCode');
                                                        },
                                                        icon: SvgPicture.asset(
                                                            'lib/assets/icons/send.svg')),
                                                  ),
                                                )
                                              : const SizedBox()
                                        ],
                                      ),
                                    ),
                                    _iscodeGenerated
                                    ? Container(
                                      height: 25,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text("코드 유효시간",
                                              style: TextStyle(
                                                  color: ColorFamily.pink,
                                                  fontSize: 14,
                                                  fontFamily: FontFamily
                                                      .mapleStoryLight)),
                                          SizedBox(width: 10),
                                          TimerCountdown(
                                              format: CountDownTimerFormat.minutesSeconds,
                                              enableDescriptions: false,
                                              timeTextStyle: TextStyle(color: ColorFamily.pink, fontSize: 14, fontFamily: FontFamily.mapleStoryLight),
                                              colonsTextStyle: TextStyle(color: ColorFamily.pink, fontSize: 14, fontFamily: FontFamily.mapleStoryLight),
                                              spacerWidth: 5,
                                              endTime: DateTime.now().add(
                                                Duration(
                                                  minutes: 5,
                                                  seconds: 00,
                                                ),
                                              ),
                                              onEnd: () {
                                                setState(() {
                                                  _randomCode = "$_randomCode+a";
                                                });
                                              }
                                          )
                                        ],
                                      ),
                                    )
                                    : SizedBox(height: 25),
                                    Padding(padding: EdgeInsets.only(top: 20)),
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
                                                //TODO 해당 코드로 연결한 상대가 있는지 여부 파악
                                                //없을 시 토스트메시지 노출("연결된 상대가 없습니다.")
                                                //있을 시 해당 코드 만료 후,
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            DdaySettingScreen(isHost: true)));
                                              },
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              child: Container(
                                                  height: 40,
                                                  width: 160,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "상대 연결 확인",
                                                      style: TextStyleFamily
                                                          .normalTextStyle,
                                                    ),
                                                  ))),
                                        ),
                                        //TODO 연결코드 생성을 누르면 노출되고 타이머 시작
                                      ],
                                    ),
                                    Padding(padding: EdgeInsets.only(top: 80)),
                                    Container(
                                      child: Text(
                                        "초대를 받았다면 상대의 연결코드를 입력해주세요",
                                        style:
                                            TextStyleFamily.smallTitleTextStyle,
                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.only(top: 20)),
                                    Container(
                                      width: 160,
                                      child: TextField(
                                        onTapOutside: (event) {
                                          FocusScope.of(context).unfocus();
                                        },
                                        decoration: InputDecoration(
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
                                        style: TextStyle(
                                            color: ColorFamily.black,
                                            fontSize: 22,
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
                                              onTap: () {
                                                //TODO 입력값이 현재 유효한지 체크
                                                //유효하지 않다면 토스트메시지 출력("해당 코드는 유효하지 않은 코드입니다.")
                                                //유효하다면
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            NickNameSettingScreen(isHost: false)));
                                              },
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              child: Container(
                                                  height: 40,
                                                  width: 160,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "연결하기",
                                                      style: TextStyleFamily
                                                          .normalTextStyle,
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
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => RegisterScreen()));
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

const _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

TimerCountdown timerCountdown(BuildContext context, String code) {
  return TimerCountdown(
    format: CountDownTimerFormat.minutesSeconds,
    enableDescriptions: false,
    timeTextStyle: TextStyle(color: ColorFamily.pink, fontSize: 14, fontFamily: FontFamily.mapleStoryLight),
    colonsTextStyle: TextStyle(color: ColorFamily.pink, fontSize: 14, fontFamily: FontFamily.mapleStoryLight),
    spacerWidth: 5,
    endTime: DateTime.now().add(
      Duration(
        minutes: 5,
        seconds: 00,
      ),
    ),
    onEnd: () {}
  );
}
