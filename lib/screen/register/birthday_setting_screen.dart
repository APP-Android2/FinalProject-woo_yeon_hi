import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:woo_yeon_hi/screen/register/home_preset_setting_screen.dart';
import 'package:woo_yeon_hi/screen/register/register_screen.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

import '../../style/color.dart';
import '../../style/font.dart';
import '../../style/text_style.dart';
import 'nickname_setting_screen.dart';

class BirthdaySettingScreen extends StatefulWidget {
  const BirthdaySettingScreen({super.key});

  @override
  State<BirthdaySettingScreen> createState() => _BirthdaySettingScreenState();
}

class _BirthdaySettingScreenState extends State<BirthdaySettingScreen> {
  var host = true;
  DateTime _selectedDate = DateTime.now();
  DateTime birthday = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: ColorFamily.cream,
            padding: EdgeInsets.all(20),
            child: Stack(children: [
              ListView(children: [
                Column(children: [
                  Container(
                      height: 750,
                      child: Column(
                          children: [
                        Container(
                            height: 700,
                            child: Column(children: [
                              Padding(padding: EdgeInsets.only(top: 60)),
                              host
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
                              host
                                  ? Container(
                                      child: Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                      showMaterialModalBottomSheet(
                                          backgroundColor: ColorFamily.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(20),
                                                  topLeft: Radius.circular(20))),
                                          context: context,
                                          builder: (context) => Container(
                                            height: 410,
                                                  child: Column(children: [
                                                Container(
                                                  height: 350,
                                                  child: ScrollDatePicker(
                                                    options: DatePickerOptions(
                                                        isLoop: false),
                                                    selectedDate: _selectedDate,
                                                    locale: Locale('ko'),
                                                    scrollViewOptions:
                                                        DatePickerScrollViewOptions(
                                                            year:
                                                                ScrollViewDetailOptions(
                                                              textStyle:
                                                                  TextStyleFamily
                                                                      .passwordTextStyle,
                                                              selectedTextStyle:
                                                                  TextStyleFamily
                                                                      .passwordTextStyle,
                                                              label: '년',
                                                              margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      right:
                                                                          50),
                                                            ),
                                                            month:
                                                                ScrollViewDetailOptions(
                                                              textStyle:
                                                                  TextStyleFamily
                                                                      .passwordTextStyle,
                                                              selectedTextStyle:
                                                                  TextStyleFamily
                                                                      .passwordTextStyle,
                                                              label: '월',
                                                              margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      right:
                                                                          50),
                                                            ),
                                                            day:
                                                                ScrollViewDetailOptions(
                                                              textStyle:
                                                                  TextStyleFamily
                                                                      .passwordTextStyle,
                                                              selectedTextStyle:
                                                                  TextStyleFamily
                                                                      .passwordTextStyle,
                                                              label: '일',
                                                            )),
                                                    onDateTimeChanged:
                                                        (DateTime value) {
                                                      setState(() {
                                                        birthday = value;
                                                      });
                                                    },
                                                  ),
                                                ),
                                                Material(
                                                  color: ColorFamily.beige,
                                                  elevation: 0.5,
                                                  shadowColor: Colors.black,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                  ),
                                                  child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                         _selectedDate = birthday;
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                      child: Container(
                                                        width: 380,
                                                          height: 40,
                                                          child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                              "확인",
                                                              style: TextStyleFamily
                                                                  .normalTextStyle,
                                                            ),
                                                          ))),
                                                ),
                                                    Padding(padding: EdgeInsets.only(top: 20))
                                              ])));
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
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      DateFormat('yyyy. M. d.')
                                                          .format(
                                                          _selectedDate),
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
                        //
                        //   )
                        // )
                        //     Container(
                        //       height: 350,
                        //       child:
                        //           ScrollDatePicker(
                        //             options: DatePickerOptions(isLoop: false),
                        //             selectedDate: _selectedDate,
                        //             locale: Locale('ko'),
                        //             scrollViewOptions:
                        //                 DatePickerScrollViewOptions(
                        //                     year:
                        //                         ScrollViewDetailOptions(
                        //                           textStyle: TextStyleFamily.passwordTextStyle,
                        //                       selectedTextStyle: TextStyleFamily.passwordTextStyle,
                        //                       label: '년',
                        //                       margin:
                        //                           const EdgeInsets
                        //                               .only(
                        //                               right: 50),
                        //                     ),
                        //                     month:
                        //                         ScrollViewDetailOptions(
                        //                           textStyle: TextStyleFamily.passwordTextStyle,
                        //                           selectedTextStyle: TextStyleFamily.passwordTextStyle,
                        //                       label: '월',
                        //                       margin:
                        //                           const EdgeInsets
                        //                               .only(
                        //                               right: 50),
                        //                     ),
                        //                     day:
                        //                         ScrollViewDetailOptions(
                        //                           textStyle: TextStyleFamily.passwordTextStyle,
                        //                           selectedTextStyle: TextStyleFamily.passwordTextStyle,
                        //                       label: '일',
                        //                     )),
                        //             onDateTimeChanged:
                        //                 (DateTime value) {
                        //               setState(() {
                        //                 _selectedDate = value;
                        //               });
                        //             },
                        //           ),
                        // Material(
                        //   color: ColorFamily.beige,
                        //   elevation: 0.5,
                        //   shadowColor: Colors.black,
                        //   shape: RoundedRectangleBorder(
                        //     borderRadius:
                        //     BorderRadius.circular(20.0),
                        //   ),
                        //   child: InkWell(
                        //       onTap: () {
                        //         Navigator.pop(context);
                        //       },
                        //       borderRadius:
                        //       BorderRadius.circular(20.0),
                        //       child: Container(
                        //         height: 40,
                        //         padding: EdgeInsets.symmetric(horizontal: 20),
                        //           child: Container(
                        //             alignment: Alignment.center,
                        //             child: Text(
                        //               "확인",
                        //               style: TextStyleFamily.normalTextStyle,
                        //             ),
                        //           ))),
                        // ),
                        //               ],
                        //             ),
                        //           )
                        //
                        //   ),);
                        // },

                        // ),
                        // ),
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
                                      borderRadius: BorderRadius.circular(20.0),
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
                                                  HomePresetSettingScreen()));
                                    },
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Container(
                                        height: 40,
                                        width: 120,
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "다음",
                                            style:
                                                TextStyleFamily.normalTextStyle,
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
              ]),
            ],
            ),
        ),
    );
  }
}
