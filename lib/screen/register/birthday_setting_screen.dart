import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/model/user_model.dart';
import 'package:woo_yeon_hi/screen/register/home_preset_setting_screen.dart';
import 'package:woo_yeon_hi/screen/login/login_screen.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:woo_yeon_hi/utils.dart';

import '../../dao/user_dao.dart';
import '../../style/color.dart';
import '../../style/font.dart';
import '../../style/text_style.dart';

class BirthdaySettingScreen extends StatefulWidget {
  final bool isHost;

  const BirthdaySettingScreen({super.key, required this.isHost});

  @override
  State<BirthdaySettingScreen> createState() => _BirthdaySettingScreenState();
}

class _BirthdaySettingScreenState extends State<BirthdaySettingScreen> {

  DateTime _selectedDate = DateTime.now();
  late DateTime userBirth;

  dynamic userProvider;

  @override
  void initState() {
    super.initState();
    userProvider = Provider.of<UserModel>(context, listen: false);
    userBirth = stringToDate(userProvider.userBirth);
  }

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
                                    ? const Text(
                                      "4 / 5",
                                      style: TextStyle(
                                          fontFamily:
                                              FontFamily.mapleStoryBold,
                                          fontSize: 15,
                                          color: ColorFamily.pink),
                                    )
                                    : const Text(
                                      "3 / 4",
                                      style: TextStyle(
                                          fontFamily:
                                              FontFamily.mapleStoryBold,
                                          fontSize: 15,
                                          color: ColorFamily.pink),
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
                                            userBirth = _selectedDate;
                                            userProvider.userBirth = dateToString(userBirth);
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
                                                    dateToString(userBirth),
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
                                    Material(
                                        color: ColorFamily.white,
                                        elevation: 0.5,
                                        shadowColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
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
                                      ),
                                Material(
                                  color: ColorFamily.beige,
                                  elevation: 0.5,
                                  shadowColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        userProvider.userBirth = dateToString(userBirth);
                                      });
                                      Navigator.push(context, MaterialPageRoute(
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
                          signOut();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
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

  void signOut() async {
    switch (userProvider.loginType) {
      case 1:
        await GoogleSignIn().signOut();
        break;
      case 2:
        try {
          await UserApi.instance.logout();
          print('로그아웃 성공, SDK에서 토큰 삭제');
        } catch (error) {
          print('로그아웃 실패, SDK에서 토큰 삭제 $error');
        }
        break;
      case 0:
        break;
    }
    deleteUserData(userProvider.userIdx);
    setState(() {
      userProvider.loginType = 0;
    });
  }
}
