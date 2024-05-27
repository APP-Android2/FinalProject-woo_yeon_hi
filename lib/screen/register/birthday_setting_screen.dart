import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woo_yeon_hi/screen/register/home_preset_setting_screen.dart';
import 'package:woo_yeon_hi/screen/register/register_screen.dart';

import '../../style/color.dart';
import '../../style/font.dart';
import 'nickname_setting_screen.dart';

class BirthdaySettingScreen extends StatefulWidget {
  const BirthdaySettingScreen({super.key});

  @override
  State<BirthdaySettingScreen> createState() => _BirthdaySettingScreenState();
}

class _BirthdaySettingScreenState extends State<BirthdaySettingScreen> {
  var host = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorFamily.cream,
        padding: EdgeInsets.all(20),
        child: Stack(
          children: [
            ListView(children: [
              Column(
                children: [
                  Container(
                      height: 750,
                      child: Column(
                        children: [
                          Container(
                            height: 700,
                            child: Column(
                              children: [
                                Padding(padding: EdgeInsets.only(top: 60)),
                                host
                                ? Container(
                                  child: Text(
                                    "4 / 5",
                                    style: TextStyle(
                                        fontFamily: FontFamily.mapleStoryBold,
                                        fontSize: 15,
                                        color: ColorFamily.pink),
                                  ),
                                )
                                    : Container(
                                  child: Text(
                                    "3 / 4",
                                    style: TextStyle(
                                        fontFamily: FontFamily.mapleStoryBold,
                                        fontSize: 15,
                                        color: ColorFamily.pink),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(top: 20)),
                                host
                                ? Container(
                                    child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                        "lib/assets/images/heart_fill.png",
                                        height: 24,
                                      ),
                                      Image.asset(
                                        "lib/assets/images/triple_right_arrow.png",
                                        height: 24,
                                      ),
                                      Image.asset(
                                        "lib/assets/images/heart_fill.png",
                                        height: 24,
                                      ),
                                      Image.asset(
                                        "lib/assets/images/triple_right_arrow.png",
                                        height: 24,
                                      ),
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
                                    ],
                                  ),
                                ))
                                : Container(
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
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
                                            "lib/assets/images/heart_fill.png",
                                            height: 24,
                                          ),
                                          Image.asset(
                                            "lib/assets/images/triple_right_arrow.png",
                                            height: 24,
                                          ),
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
                                        ],
                                      ),
                                    )),
                                Padding(padding: EdgeInsets.only(top: 50)),
                                Container(
                                  child: Text(
                                    "본인의 생년월일을 등록해주세요",
                                    style: TextStyle(
                                        color: ColorFamily.black,
                                        fontSize: 15,
                                        fontFamily: FontFamily.mapleStoryLight),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(top: 10)),
                                Container(
                                  height: 15,
                                  child: Text(
                                    "기념일로 알려드릴게요 >.<",
                                    style: TextStyle(
                                        color: ColorFamily.gray,
                                        fontSize: 12,
                                        fontFamily: FontFamily.mapleStoryLight),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(top: 150)),
                                Container(
                                  width: 250,
                                  child: TextField(
                                    decoration: InputDecoration(
                                        hintText: "",
                                        suffixIconConstraints: BoxConstraints(
                                            minHeight: 24, minWidth: 24),
                                        suffixIcon: SvgPicture.asset(
                                            "lib/assets/icons/calendar.svg"),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: ColorFamily.black))),
                                    cursorColor: ColorFamily.black,
                                    textAlign: TextAlign.center,
                                    onTap: () {
                                      print('텍스트필드를 터치하면 캘린더 위젯을 띄웁니다.');
                                    },
                                    readOnly: true,
                                    style: TextStyle(
                                        color: ColorFamily.black,
                                        fontSize: 20,
                                        fontFamily: FontFamily.mapleStoryLight),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: <Widget>[
                                Padding(padding: EdgeInsets.only(left: 50)),
                                Expanded(
                                  child: Container(
                                    child: Material(
                                      color: ColorFamily.white,
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
                                                        NickNameSettingScreen()));
                                          },
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          child: Container(
                                              height: 40,
                                              width: 120,
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "이전",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontFamily: FontFamily
                                                          .mapleStoryLight),
                                                ),
                                              ))),
                                    ),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(left: 20)),
                                Expanded(
                                  child: Material(
                                    color: ColorFamily.beige,
                                    elevation: 0.5,
                                    shadowColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomePresetSettingScreen()));
                                      },
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Container(
                                          height: 40,
                                          width: 120,
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              // "연결코드 생성",
                                              "다음",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontFamily: FontFamily
                                                      .mapleStoryLight),
                                            ),
                                          )),
                                    ),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(right: 50)),
                              ],
                            ),
                          ),
                        ],
                      )),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 16, 16, 0),
                        child: TextButton(
                          style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all<Color>(
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
            ]),
          ],
        ),
      ),
    );
  }
}
