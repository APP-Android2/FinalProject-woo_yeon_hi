import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/screen/register/d_day_setting_screen.dart';
import 'package:woo_yeon_hi/screen/register/nickname_setting_screen.dart';
import 'package:woo_yeon_hi/screen/register/register_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

import '../../model/enums.dart';
import '../../model/user_model.dart';
import '../../style/text_style.dart';

class CodeConnectScreen extends StatefulWidget {
  const CodeConnectScreen({super.key});

  @override
  State<CodeConnectScreen> createState() => _ConnectCodeScreenState();
}

class _ConnectCodeScreenState extends State<CodeConnectScreen> {
  bool _isCodeGenerated = false;
  bool _isCodeExpired = false;
  String _codeText = "";
  String _randomCode = getRandomString(8);
  dynamic codeTextEditController;

  dynamic userProvider;

  @override
  void initState() {
    super.initState();

    userProvider = Provider.of<UserModel>(context, listen: false);
    codeTextEditController = TextEditingController();
  }

  @override
  void dispose() {
    codeTextEditController.dispose();
    super.dispose();
  }

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
                            height: deviceHeight - 140,
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
                                SizedBox(height: deviceHeight * 0.05),
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
                                          child: _isCodeExpired
                                              ? const Text(
                                                  "만료된 코드입니다. 다시 생성해주세요.",
                                                  style: TextStyle(
                                                      color: ColorFamily.pink,
                                                      fontSize: 14,
                                                      fontFamily: FontFamily
                                                          .mapleStoryLight))
                                              : Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const Text("코드 유효시간",
                                                        style: TextStyle(
                                                            color: ColorFamily
                                                                .pink,
                                                            fontSize: 14,
                                                            fontFamily: FontFamily
                                                                .mapleStoryLight)),
                                                    const SizedBox(width: 10),
                                                    TimerCountdown(
                                                        format:
                                                            CountDownTimerFormat
                                                                .minutesSeconds,
                                                        enableDescriptions:
                                                            false,
                                                        timeTextStyle: const TextStyle(
                                                            color: ColorFamily
                                                                .pink,
                                                            fontSize: 14,
                                                            fontFamily: FontFamily
                                                                .mapleStoryLight),
                                                        colonsTextStyle:
                                                            const TextStyle(
                                                                color:
                                                                    ColorFamily
                                                                        .pink,
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    FontFamily
                                                                        .mapleStoryLight),
                                                        spacerWidth: 5,
                                                        endTime:
                                                            DateTime.now().add(
                                                          const Duration(
                                                              minutes: 5,
                                                              seconds: 00),
                                                        ),
                                                        onEnd: () {
                                                          //TODO 생성된 코드를 서버에서 제거
                                                          setState(() {
                                                            _isCodeExpired =
                                                                true;
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
                                                //TODO 생성된 코드를 서버에 저장
                                                _isCodeGenerated = true;
                                              });
                                            },
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            child: Container(
                                              height: deviceHeight * 0.045,
                                              width: deviceWidth * 0.4,
                                              alignment: Alignment.center,
                                              child: const Text(
                                                "연결코드 생성",
                                                style: TextStyleFamily
                                                    .normalTextStyle,
                                              ),
                                            ))
                                        : InkWell(
                                            onTap: () {
                                              if (_isCodeExpired) {
                                                setState(() {
                                                  _randomCode =
                                                      getRandomString(8);
                                                  _codeText = _randomCode;
                                                  //TODO 재생성된 코드를 서버에 저장
                                                  _isCodeExpired = false;
                                                });
                                              } else {
                                                //TODO 해당 코드로 연결한 상대가 있는지 여부 파악(서버데이터)
                                                //없을 시 토스트메시지 노출
                                                Fluttertoast.showToast(
                                                    msg: "해당 코드로 연결된 상대가 없습니다.",
                                                    toastLength: Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor:
                                                    ColorFamily.black,
                                                    textColor: ColorFamily.white,
                                                    fontSize: 14.0);

                                                //있을 시 해당 코드 만료 후 호스트화면 이동
                                                //TODO 생성된 코드를 서버에서 삭제
                                                Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const DdaySettingScreen(
                                                                isHost: true)),
                                                    (route) => false);
                                              }
                                            },
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            child: Container(
                                                height: deviceHeight / 21,
                                                width: deviceWidth / 3,
                                                alignment: Alignment.center,
                                                child: _isCodeExpired
                                                    ? const Text("연결코드 재생성",
                                                        style: TextStyleFamily
                                                            .normalTextStyle)
                                                    : const Text("상대 연결 확인",
                                                        style: TextStyleFamily
                                                            .normalTextStyle))),
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
                                  child: TextFormField(
                                    controller: codeTextEditController,
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
                                        if (codeTextEditController.text ==
                                            "TEST") {
                                          //TODO loverUserIdx에 해당코드를 생성한 userIdx를 저장
                                          //게스트화면 이동
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const NickNameSettingScreen(
                                                          isHost: false)),
                                              (route) => false);
                                        } else {
                                          Fluttertoast.showToast(
                                              msg: "유효하지 않은 연결코드입니다.",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor:
                                                  ColorFamily.black,
                                              textColor: ColorFamily.white,
                                              fontSize: 14.0);
                                        }
                                      },
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Container(
                                        height: deviceHeight * 0.045,
                                        width: deviceWidth * 0.4,
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
                        signOut();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterScreen()),
                            (route) => false);
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

  void signOut() async {
    switch (userProvider.loginType) {
      case LoginType.google:
        await GoogleSignIn().signOut();
        break;
      case LoginType.kakao:
        try {
          await UserApi.instance.logout();
          print('로그아웃 성공, SDK에서 토큰 삭제');
        } catch (error) {
          print('로그아웃 실패, SDK에서 토큰 삭제 $error');
        }
        break;
      case LoginType.none:
        break;
    }
    setState(() {
      userProvider.loginType = LoginType.none;
    });
  }
}

const _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
