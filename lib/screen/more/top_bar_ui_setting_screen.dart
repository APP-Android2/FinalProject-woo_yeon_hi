import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/style/text_style.dart';

import '../../dao/user_dao.dart';
import '../../model/user_model.dart';

class TopBarUiSettingScreen extends StatefulWidget {
  const TopBarUiSettingScreen({super.key});

  @override
  State<TopBarUiSettingScreen> createState() => _TopBarUiSettingScreenState();
}

class _TopBarUiSettingScreenState extends State<TopBarUiSettingScreen> {
  static const storage = FlutterSecureStorage();

  late String userAccount = "";
  late int topBarType = 0;
  late bool topBarActivate = false;

  late int topBarIndex = 0;
  late bool switchValue = false;
  bool _isLoading = true; // Loading 상태를 나타내는 변수

  @override
  void initState(){
    super.initState();

    _asyncMethod();
    topBarIndex = topBarType;
  }

  Future<void> _asyncMethod() async {
    userAccount = (await storage.read(key: "loginAccount"))!;
    topBarType = await getSpecificUserData(userAccount, 'top_bar_type');
    topBarActivate = await getSpecificUserData(userAccount, 'top_bar_activate');

    setState(() {
      topBarIndex = topBarType; // homePresetType을 가져온 후에 presetIndex 설정
      switchValue = topBarActivate; // homePresetType을 가져온 후에 presetIndex 설정
      _isLoading = false; // 데이터 로드가 완료되면 로딩 상태를 false로 설정
    });
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery
        .of(context)
        .size
        .width;
    var deviceHeight = MediaQuery
        .of(context)
        .size
        .height;

    if (_isLoading) {
      // 로딩 중인 상태를 표시
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          surfaceTintColor: ColorFamily.cream,
          backgroundColor: ColorFamily.cream,
          centerTitle: true,
          title: const Text(
            "상단바 스타일",
            style: TextStyleFamily.appBarTitleLightTextStyle,
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset('lib/assets/icons/arrow_back.svg'),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                await updateUserData(userAccount, 'top_bar_type', topBarIndex);
                Navigator.pop(context);
                Fluttertoast.showToast(
                    msg: "상단바 스타일이 변경되었습니다.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: ColorFamily.black,
                    textColor: ColorFamily.white,
                    fontSize: 14.0
                );
              },
              icon: SvgPicture.asset('lib/assets/icons/done.svg'),
            )
          ],
        ),
        body: Container(
          width: deviceWidth,
          height: deviceHeight,
          padding: const EdgeInsets.all(20),
          color: ColorFamily.cream,
          child: Column(
            children: [
              Material(
                elevation: 1,
                borderRadius: BorderRadius.circular(20),
                borderOnForeground: true,
                child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      setState(() {
                        topBarIndex = 0;
                      });
                    },
                    child: Container(
                      width: deviceWidth - 60,
                      height: deviceHeight * 0.07,
                      decoration: topBarIndex == 0
                          ? BoxDecoration(
                          color: ColorFamily.white,
                          border:
                          Border.all(color: ColorFamily.pink, width: 1),
                          borderRadius: BorderRadius.circular(20))
                          : BoxDecoration(
                          color: ColorFamily.white,
                          border:
                          Border.all(color: Colors.transparent, width: 1),
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(width: 80),
                          const Text("100일",
                              style: TextStyleFamily.smallTitleTextStyle),
                          Padding(
                            padding: const EdgeInsets.only(right: 50),
                            child: Image.asset(
                                "lib/assets/images/top_bar_heart_36px.png",
                                width: 30,
                                height: 33),
                          ),
                        ],
                      ),
                    )),
              ),
              const SizedBox(height: 20),
              Material(
                elevation: 1,
                borderRadius: BorderRadius.circular(20),
                borderOnForeground: true,
                child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      setState(() {
                        topBarIndex = 1;
                      });
                    },
                    child: Container(
                      width: deviceWidth - 60,
                      height: deviceHeight * 0.07,
                      decoration: topBarIndex == 1
                          ? BoxDecoration(
                          color: ColorFamily.white,
                          border:
                          Border.all(color: ColorFamily.pink, width: 1),
                          borderRadius: BorderRadius.circular(20))
                          : BoxDecoration(
                          color: ColorFamily.white,
                          border:
                          Border.all(color: Colors.transparent, width: 1),
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(width: 80),
                          const Text("+100",
                              style: TextStyleFamily.smallTitleTextStyle),
                          Padding(
                            padding: const EdgeInsets.only(right: 50),
                            child: Image.asset(
                                "lib/assets/images/top_bar_heart_36px.png",
                                width: 30,
                                height: 33),
                          ),
                        ],
                      ),
                    )),
              ),
              const SizedBox(height: 20),
              Material(
                elevation: 1,
                borderRadius: BorderRadius.circular(20),
                borderOnForeground: true,
                child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      setState(() {
                        topBarIndex = 2;
                      });
                    },
                    child: Container(
                      width: deviceWidth - 60,
                      height: deviceHeight * 0.14,
                      decoration: topBarIndex == 2
                          ? BoxDecoration(
                          color: ColorFamily.white,
                          border:
                          Border.all(color: ColorFamily.pink, width: 1),
                          borderRadius: BorderRadius.circular(20))
                          : BoxDecoration(
                          color: ColorFamily.white,
                          border:
                          Border.all(color: Colors.transparent, width: 1),
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 40),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100.0),
                                child: Image.asset(
                                    'lib/assets/images/default_profile.png',
                                    fit: BoxFit.cover,
                                    width: 80,
                                    height: 80),
                              )),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 10),
                                Image.asset(
                                    "lib/assets/images/top_bar_heart_36px.png",
                                    width: 30,
                                    height: 33),
                                const SizedBox(height: 10),
                                const Text("100일",
                                    style: TextStyleFamily.smallTitleTextStyle),
                              ]),
                          Padding(
                            padding: const EdgeInsets.only(right: 40),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.0),
                              child: Image.asset(
                                  'lib/assets/images/default_profile.png',
                                  fit: BoxFit.cover,
                                  width: 80,
                                  height: 80),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
              const SizedBox(height: 20),
              Material(
                elevation: 1,
                borderRadius: BorderRadius.circular(20),
                borderOnForeground: true,
                child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      setState(() {
                        topBarIndex = 3;
                      });
                    },
                    child: Container(
                      width: deviceWidth - 60,
                      height: deviceHeight * 0.14,
                      decoration: topBarIndex == 3
                          ? BoxDecoration(
                          color: ColorFamily.white,
                          border:
                          Border.all(color: ColorFamily.pink, width: 1),
                          borderRadius: BorderRadius.circular(20))
                          : BoxDecoration(
                          color: ColorFamily.white,
                          border:
                          Border.all(color: Colors.transparent, width: 1),
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(width: 50),
                                const Text("100일",
                                    style: TextStyleFamily.smallTitleTextStyle),
                                const SizedBox(width: 10),
                                Image.asset(
                                    "lib/assets/images/top_bar_heart_36px.png",
                                    width: 30,
                                    height: 33),
                              ]),
                          SizedBox(
                            width: (deviceWidth - 60) / 2,
                            child: Stack(
                              children: [
                                Positioned(
                                  top: deviceHeight * 0.025,
                                  right: 40,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100.0),
                                    child: Image.asset(
                                        'lib/assets/images/default_profile.png',
                                        fit: BoxFit.cover,
                                        width: 80,
                                        height: 80),
                                  ),
                                ),
                                Positioned(
                                  top: deviceHeight * 0.025,
                                  left: 10,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100.0),
                                    child: Image.asset(
                                        'lib/assets/images/default_profile.png',
                                        fit: BoxFit.cover,
                                        width: 80,
                                        height: 80),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    children: [
                      const Text("상단바 활성화",
                          style: TextStyle(
                              fontFamily: FontFamily.mapleStoryLight,
                              fontSize: 12,
                              color: ColorFamily.black)),
                      Switch(
                          value: switchValue,
                          activeColor: ColorFamily.white,
                          activeTrackColor: ColorFamily.pink,
                          inactiveThumbColor: ColorFamily.gray,
                          inactiveTrackColor: ColorFamily.white,
                          trackOutlineColor: switchValue
                              ? MaterialStateProperty.all(Colors.transparent)
                              : MaterialStateProperty.all(ColorFamily.gray),
                          trackOutlineWidth: const MaterialStatePropertyAll(1),
                          onChanged: (bool value) async {
                            setState(() {
                              switchValue = value;
                            });
                            await updateUserData(userAccount, 'top_bar_activate', switchValue);
                          }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
