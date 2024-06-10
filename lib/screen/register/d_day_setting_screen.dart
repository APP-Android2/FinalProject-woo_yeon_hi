import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/screen/register/nickname_setting_screen.dart';
import 'package:woo_yeon_hi/screen/register/register_screen.dart';
import 'package:woo_yeon_hi/style/text_style.dart';

import '../../model/enums.dart';
import '../../model/user_model.dart';
import '../../style/color.dart';
import '../../style/font.dart';
import '../../widget/register/d_day_setting_calendar.dart';

class DdaySettingScreen extends StatefulWidget {
  final bool isHost;

  const DdaySettingScreen({super.key, required this.isHost});

  @override
  State<StatefulWidget> createState() => _DdaySettingScreen();
}

class _DdaySettingScreen extends State<DdaySettingScreen> {
  dynamic userProvider;

  @override
  void initState() {
    super.initState();

    userProvider = Provider.of<UserModel>(context, listen: false);
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
                          child: Column(
                            children: [
                              SizedBox(
                                height: deviceHeight - 140,
                                width: deviceWidth - 40,
                                child: Column(
                                  children: [
                                    SizedBox(height: deviceHeight * 0.1),
                                    const Text(
                                      "2 / 5",
                                      style: TextStyle(
                                          fontFamily: FontFamily.mapleStoryBold,
                                          fontSize: 15,
                                          color: ColorFamily.pink),
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
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
                                      ],
                                    ),
                                    SizedBox(height: deviceHeight * 0.05),
                                    const Text(
                                      "연인이 된 날을 선택해주세요!",
                                      style:
                                          TextStyleFamily.smallTitleTextStyle,
                                    ),
                                    const SizedBox(height: 30),
                                    const DdaySettingCalendar()
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                        height: deviceHeight * 0.045,
                                        width: deviceWidth * 0.4),
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
                                            Navigator.of(context).push(MaterialPageRoute(
                                                builder: (context) =>
                                                NickNameSettingScreen(
                                                                 isHost:
                                                                     widget.isHost)));
                                            // Navigator.pushAndRemoveUntil(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (context) =>
                                            //             NickNameSettingScreen(
                                            //                 isHost:
                                            //                     widget.isHost)),
                                            //     (route) => false);
                                          },
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          child: Container(
                                            height: deviceHeight * 0.045,
                                            width: deviceWidth * 0.4,
                                            alignment: Alignment.center,
                                            child: const Text(
                                              "다음",
                                              style: TextStyleFamily
                                                  .normalTextStyle,
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            signOut();
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterScreen()),
                                (route) => false);
                          },
                          child: const Text(
                            "로그아웃",
                            style: TextStyleFamily.normalTextStyle,
                          ),
                        ),
                      )
                    ],
                  ))
            ])));
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
