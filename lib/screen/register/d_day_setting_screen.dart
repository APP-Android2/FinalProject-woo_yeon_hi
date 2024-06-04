import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:woo_yeon_hi/screen/register/nickname_setting_screen.dart';
import 'package:woo_yeon_hi/screen/register/register_screen.dart';
import 'package:woo_yeon_hi/style/text_style.dart';

import '../../style/color.dart';
import '../../style/font.dart';
import '../../widget/register/d_day_setting_calendar.dart';

class DdaySettingScreen extends StatefulWidget {
  final bool isHost;

  DdaySettingScreen({super.key, required this.isHost});

  @override
  State<StatefulWidget> createState() => _DdaySettingScreen();
  }

class _DdaySettingScreen extends State<DdaySettingScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: ColorFamily.cream,
          padding: EdgeInsets.all(20),
          child: Stack(
            children: [
              ListView(
                children: [Column(
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
                                Container(
                                  child: Text(
                                    "2 / 5",
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
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset("lib/assets/icons/heart_fill.svg", height: 24),
                                          SvgPicture.asset("lib/assets/icons/triple_right_arrow.svg", height: 24),
                                          SvgPicture.asset("lib/assets/icons/heart_fill.svg", height: 24),
                                          SvgPicture.asset("lib/assets/icons/triple_right_arrow.svg", height: 24),
                                          SvgPicture.asset("lib/assets/icons/heart_outlined.svg", height: 24),
                                          SvgPicture.asset("lib/assets/icons/triple_right_arrow.svg", height: 24),
                                          SvgPicture.asset("lib/assets/icons/heart_outlined.svg", height: 24),
                                          SvgPicture.asset("lib/assets/icons/triple_right_arrow.svg", height: 24),
                                          SvgPicture.asset("lib/assets/icons/heart_outlined.svg", height: 24),
                                        ],
                                      ),
                                    )),
                                Padding(padding: EdgeInsets.only(top: 50)),
                                Container(
                                  child: Text(
                                    "연인이 된 날을 선택해주세요!",
                                    style: TextStyleFamily
                                        .smallTitleTextStyle,
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(top: 30)),
                                Container(
                                  width: 360,
                                  child: DdaySettingCalendar()
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: <Widget>[
                                Padding(padding: EdgeInsets.only(left: 50)),
                                Expanded(
                                  child: Container(height: 40, width: 150),
                                ),
                                Padding(padding: EdgeInsets.only(left: 20)),
                                Expanded(
                                  child: Material(
                                    color: ColorFamily.beige,
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
                                                    NickNameSettingScreen(isHost: widget.isHost)));
                                      },
                                      borderRadius:
                                      BorderRadius.circular(20.0),
                                      child: Container(
                                          height: 40,
                                          width: 150,
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "다음",
                                              style: TextStyleFamily
                                                  .normalTextStyle,
                                            ),
                                          )),
                                    ),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(left: 50)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
                              Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          RegisterScreen()));
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
              ])
            ],
          )),
    );
  }
}