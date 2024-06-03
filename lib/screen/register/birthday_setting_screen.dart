import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:woo_yeon_hi/screen/register/home_preset_setting_screen.dart';
import 'package:woo_yeon_hi/screen/register/register_screen.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;

import '../../style/color.dart';
import '../../style/font.dart';
import '../../style/text_style.dart';
import 'nickname_setting_screen.dart';

class BirthdaySettingScreen extends StatefulWidget {
  final bool isHost;

  BirthdaySettingScreen({super.key, required this.isHost});

  @override
  State<BirthdaySettingScreen> createState() => _BirthdaySettingScreenState();
}

class _BirthdaySettingScreenState extends State<BirthdaySettingScreen> {
  DateTime _selectedDate = DateTime.now();
  DateTime _birthday = DateTime.now();

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
                              child: Column(children: [
                                Padding(padding: EdgeInsets.only(top: 60)),
                                widget.isHost
                                    ? Container(
                                        child: Text(
                                          "4 / 5",
                                          style: TextStyle(
                                              fontFamily:
                                                  FontFamily.mapleStoryBold,
                                              fontSize: 15,
                                              color: ColorFamily.pink),
                                        ),
                                      )
                                    : Container(
                                        child: Text(
                                          "3 / 4",
                                          style: TextStyle(
                                              fontFamily:
                                                  FontFamily.mapleStoryBold,
                                              fontSize: 15,
                                              color: ColorFamily.pink),
                                        ),
                                      ),
                                Padding(padding: EdgeInsets.only(top: 20)),
                                widget.isHost
                                    ? Container(
                                        child: Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset("lib/assets/icons/heart_fill.svg", height: 24),
                                            SvgPicture.asset("lib/assets/icons/triple_right_arrow.svg", height: 24),
                                            SvgPicture.asset("lib/assets/icons/heart_fill.svg", height: 24),
                                            SvgPicture.asset("lib/assets/icons/triple_right_arrow.svg", height: 24),
                                            SvgPicture.asset("lib/assets/icons/heart_fill.svg", height: 24),
                                            SvgPicture.asset("lib/assets/icons/triple_right_arrow.svg", height: 24),
                                            SvgPicture.asset("lib/assets/icons/heart_fill.svg", height: 24),
                                            SvgPicture.asset("lib/assets/icons/triple_right_arrow.svg", height: 24),
                                            SvgPicture.asset("lib/assets/icons/heart_outlined.svg", height: 24),
                                          ],
                                        ),
                                      ))
                                    : Container(
                                        child: Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset("lib/assets/icons/heart_fill.svg", height: 24),
                                            SvgPicture.asset("lib/assets/icons/triple_right_arrow.svg", height: 24),
                                            SvgPicture.asset("lib/assets/icons/heart_fill.svg", height: 24),
                                            SvgPicture.asset("lib/assets/icons/triple_right_arrow.svg", height: 24),
                                            SvgPicture.asset("lib/assets/icons/heart_fill.svg", height: 24),
                                            SvgPicture.asset("lib/assets/icons/triple_right_arrow.svg", height: 24),
                                            SvgPicture.asset("lib/assets/icons/heart_outlined.svg", height: 24),
                                          ],
                                        ),
                                      )),
                                Padding(padding: EdgeInsets.only(top: 50)),
                                Container(
                                  child: Text(
                                    "본인의 생년월일을 등록해주세요",
                                    style: TextStyleFamily.smallTitleTextStyle,
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
                                Padding(padding: EdgeInsets.only(top: 160)),
                                Material(
                                    color: ColorFamily.cream,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: InkWell(
                                      splashColor: ColorFamily.cream,
                                      onTap: () {
                                        picker.DatePicker.showDatePicker(context,
                                        showTitleActions: true,
                                        minTime: DateTime(1900, 1, 1),
                                        maxTime: DateTime.now(),
                                        theme: picker.DatePickerTheme(
                                        titleHeight: 60,
                                        containerHeight: 300,
                                        itemHeight: 50,
                                        headerColor: ColorFamily.white,
                                        backgroundColor: ColorFamily.white,
                                        itemStyle: TextStyleFamily.smallTitleTextStyle,
                                        cancelStyle: TextStyle(color: ColorFamily.black,fontSize: 18,fontFamily: FontFamily.mapleStoryLight),
                                        doneStyle: TextStyle(color: ColorFamily.black,fontSize: 18,fontFamily: FontFamily.mapleStoryLight)),
                                        // onChanged: (date) {
                                        //   print('change $date in time zone ' +
                                        //    date.timeZoneOffset.inHours.toString());
                                        // },
                                        onConfirm: (date) {
                                          setState(() {
                                            _selectedDate = date;
                                            _birthday = _selectedDate;
                                          });
                                        },
                                        // onCancel: (){},
                                        currentTime: DateTime.now(), locale: picker.LocaleType.ko);
                                      },
                                      child: Container(
                                        child: Column(
                                          children: [
                                            Container(
                                                height: 40,
                                                width: 250,
                                                child: Stack(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          right: 20),
                                                      child: SvgPicture.asset(
                                                          "lib/assets/icons/calendar.svg"),
                                                      height: 24,
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          right: 30),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        textAlign:
                                                            TextAlign.center,
                                                        DateFormat(
                                                                'yyyy. M. d.')
                                                            .format(
                                                                _birthday),
                                                        style: TextStyle(
                                                            fontFamily: FontFamily
                                                                .mapleStoryLight,
                                                            fontSize: 20,
                                                            color: ColorFamily
                                                                .black),
                                                      ),
                                                    )
                                                  ],
                                                )),
                                            Container(
                                                padding:
                                                    EdgeInsets.only(left: 10),
                                                width: 260,
                                                child: Divider(
                                                  color: ColorFamily.black,
                                                  thickness: 0.5,
                                                ))
                                          ],
                                        ),
                                      ),
                                    )),
                              ])),
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
                                                        NickNameSettingScreen(isHost: widget.isHost)));
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
                                                  style: TextStyleFamily
                                                      .normalTextStyle,
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
                                                    HomePresetSettingScreen(isHost: widget.isHost)));
                                      },
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Container(
                                          height: 40,
                                          width: 120,
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
            ]),
          ],
        ),
      ),
    );
  }
}
