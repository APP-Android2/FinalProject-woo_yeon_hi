import 'package:flutter/material.dart';
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

  const BirthdaySettingScreen({super.key, required this.isHost});

  @override
  State<BirthdaySettingScreen> createState() => _BirthdaySettingScreenState();
}

class _BirthdaySettingScreenState extends State<BirthdaySettingScreen> {
  DateTime _selectedDate = DateTime.now();
  DateTime _birthday = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            color: ColorFamily.cream,
            padding: const EdgeInsets.all(20),
            child: Column(children: [
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
                              child: Column(children: [
                                SizedBox(height: deviceHeight * 0.1),
                                widget.isHost
                                    ? Container(
                                        child: const Text(
                                          "4 / 5",
                                          style: TextStyle(
                                              fontFamily:
                                                  FontFamily.mapleStoryBold,
                                              fontSize: 15,
                                              color: ColorFamily.pink),
                                        ),
                                      )
                                    : Container(
                                        child: const Text(
                                          "3 / 4",
                                          style: TextStyle(
                                              fontFamily:
                                                  FontFamily.mapleStoryBold,
                                              fontSize: 15,
                                              color: ColorFamily.pink),
                                        ),
                                      ),
                                const SizedBox(height: 20),
                                widget.isHost
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                              "lib/assets/icons/heart_fill.svg",
                                              height: 24),
                                          SvgPicture.asset(
                                              "lib/assets/icons/triple_right_arrow.svg",
                                              height: 24),
                                          SvgPicture.asset(
                                              "lib/assets/icons/heart_fill.svg",
                                              height: 24),
                                          SvgPicture.asset(
                                              "lib/assets/icons/triple_right_arrow.svg",
                                              height: 24),
                                          SvgPicture.asset(
                                              "lib/assets/icons/heart_fill.svg",
                                              height: 24),
                                          SvgPicture.asset(
                                              "lib/assets/icons/triple_right_arrow.svg",
                                              height: 24),
                                          SvgPicture.asset(
                                              "lib/assets/icons/heart_fill.svg",
                                              height: 24),
                                          SvgPicture.asset(
                                              "lib/assets/icons/triple_right_arrow.svg",
                                              height: 24),
                                          SvgPicture.asset(
                                              "lib/assets/icons/heart_outlined.svg",
                                              height: 24),
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                              "lib/assets/icons/heart_fill.svg",
                                              height: 24),
                                          SvgPicture.asset(
                                              "lib/assets/icons/triple_right_arrow.svg",
                                              height: 24),
                                          SvgPicture.asset(
                                              "lib/assets/icons/heart_fill.svg",
                                              height: 24),
                                          SvgPicture.asset(
                                              "lib/assets/icons/triple_right_arrow.svg",
                                              height: 24),
                                          SvgPicture.asset(
                                              "lib/assets/icons/heart_fill.svg",
                                              height: 24),
                                          SvgPicture.asset(
                                              "lib/assets/icons/triple_right_arrow.svg",
                                              height: 24),
                                          SvgPicture.asset(
                                              "lib/assets/icons/heart_outlined.svg",
                                              height: 24),
                                        ],
                                      ),
                                SizedBox(height: deviceHeight * 0.05),
                                const Text(
                                  "본인의 생년월일을 등록해주세요",
                                  style: TextStyleFamily.smallTitleTextStyle,
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  "기념일로 알려드릴게요 >.<",
                                  style: TextStyle(
                                      color: ColorFamily.gray,
                                      fontSize: 12,
                                      fontFamily: FontFamily.mapleStoryLight),
                                ),
                                SizedBox(height: deviceHeight * 0.2),
                                Material(
                                    color: ColorFamily.cream,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: InkWell(
                                      splashColor: ColorFamily.cream,
                                      onTap: () {
                                        picker.DatePicker.showDatePicker(
                                            context,
                                            showTitleActions: true,
                                            minTime: DateTime(1900, 1, 1),
                                            maxTime: DateTime.now(),
                                            theme: const picker.DatePickerTheme(
                                                titleHeight: 60,
                                                containerHeight: 300,
                                                itemHeight: 50,
                                                headerColor: ColorFamily.white,
                                                backgroundColor:
                                                    ColorFamily.white,
                                                itemStyle: TextStyleFamily
                                                    .smallTitleTextStyle,
                                                cancelStyle: TextStyle(
                                                    color: ColorFamily.black,
                                                    fontSize: 18,
                                                    fontFamily: FontFamily
                                                        .mapleStoryLight),
                                                doneStyle: TextStyle(
                                                    color: ColorFamily.black,
                                                    fontSize: 18,
                                                    fontFamily: FontFamily
                                                        .mapleStoryLight)),
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
                                            currentTime: DateTime.now(),
                                            locale: picker.LocaleType.ko);
                                      },
                                      child: Column(
                                        children: [
                                          SizedBox(
                                              height: 40,
                                              width: 200,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const SizedBox(
                                                      height: 20, width: 20),
                                                  Text(
                                                    textAlign: TextAlign.center,
                                                    DateFormat('yyyy. M. d.')
                                                        .format(_birthday),
                                                    style: const TextStyle(
                                                        fontFamily: FontFamily
                                                            .mapleStoryLight,
                                                        fontSize: 20,
                                                        color:
                                                            ColorFamily.black),
                                                  ),
                                                  SvgPicture.asset(
                                                      "lib/assets/icons/calendar.svg",
                                                      height: 24),
                                                ],
                                              )),
                                          const SizedBox(
                                              width: 210,
                                              child: Divider(
                                                color: ColorFamily.black,
                                                thickness: 0.5,
                                              ))
                                        ],
                                      ),
                                    )),
                              ])),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                widget.isHost
                                    ? Material(
                                        color: ColorFamily.white,
                                        elevation: 0.5,
                                        shadowColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: InkWell(
                                            onTap: () {
                                              // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                                              //     builder: (context) =>
                                              //     const NickNameSettingScreen(
                                              //         isHost: true)), (route) => false);

                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          NickNameSettingScreen(
                                                              isHost: widget
                                                                  .isHost)));
                                            },
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            child: SizedBox(
                                                height: deviceHeight * 0.045,
                                                width: deviceWidth * 0.4,
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  child: const Text(
                                                    "이전",
                                                    style: TextStyleFamily
                                                        .normalTextStyle,
                                                  ),
                                                ))),
                                      )
                                    : SizedBox(
                                        height: deviceHeight * 0.045,
                                        width: deviceWidth * 0.4),
                                Material(
                                  color: ColorFamily.beige,
                                  elevation: 0.5,
                                  shadowColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomePresetSettingScreen(
                                                      isHost: widget.isHost)));
                                    },
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: SizedBox(
                                        height: deviceHeight * 0.045,
                                        width: deviceWidth * 0.4,
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: const Text(
                                            "다음",
                                            style:
                                                TextStyleFamily.normalTextStyle,
                                          ),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ])),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
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
                ),
              ),
            ])));
  }
}
