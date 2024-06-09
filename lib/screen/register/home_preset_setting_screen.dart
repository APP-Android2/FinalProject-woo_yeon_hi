import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/screen/register/birthday_setting_screen.dart';
import 'package:woo_yeon_hi/screen/register/register_done_screen.dart';
import 'package:woo_yeon_hi/screen/register/register_screen.dart';
import 'package:woo_yeon_hi/style/text_style.dart';

import '../../model/enums.dart';
import '../../model/user_model.dart';
import '../../style/color.dart';
import '../../style/font.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:card_swiper/card_swiper.dart';

class HomePresetSettingScreen extends StatefulWidget {
  final bool isHost;

  const HomePresetSettingScreen({super.key, required this.isHost});

  @override
  State<HomePresetSettingScreen> createState() => _RegisterDoneScreenState();
}

class _RegisterDoneScreenState extends State<HomePresetSettingScreen> {

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

  var presetImages = [
    "lib/assets/images/home_preset_standard_4x.png",
    "lib/assets/images/home_preset_dateplan_4x.png",
    "lib/assets/images/home_preset_ledger_4x.png",
    "lib/assets/images/home_preset_dateplan_ledger_4x.png",
  ];

  late int presetPosition;

  dynamic userProvider;
  @override
  void initState() {
    super.initState();
    userProvider = Provider.of<UserModel>(context, listen: false);
    presetPosition = userProvider.homePresetType;
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
                                        "5 / 5",
                                        style: TextStyle(
                                            fontFamily:
                                                FontFamily.mapleStoryBold,
                                            fontSize: 15,
                                            color: ColorFamily.pink),
                                      )
                                    : const Text(
                                        "4 / 4",
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
                                              "lib/assets/icons/heart_fill.svg",
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
                                              "lib/assets/icons/heart_fill.svg",
                                              height: 24),
                                        ],
                                      ),
                                SizedBox(height: deviceHeight * 0.05),
                                const Text(
                                  "홈 화면 스타일을 골라주세요",
                                  style: TextStyleFamily.smallTitleTextStyle,
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  "언제든지 변경할 수 있어요 :)",
                                  style: TextStyle(
                                      color: ColorFamily.gray,
                                      fontSize: 12,
                                      fontFamily: FontFamily.mapleStoryLight),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  height: deviceHeight*0.5,
                                  child: Swiper(
                                    index: presetPosition,
                                    viewportFraction: 0.5,
                                    scale: 0.6,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        decoration:
                                        presetPosition == index
                                            ? BoxDecoration(border: Border.all(color: ColorFamily.pink, width: 1.5), borderRadius: BorderRadius.circular(20))
                                            : BoxDecoration(border: Border.all(color: Colors.transparent, width: 1.5), borderRadius: BorderRadius.circular(20)),
                                          child: Material(borderRadius: BorderRadius.circular(20), elevation: 1.0, child: ClipRRect(borderRadius: BorderRadius.circular(20), child: Image.asset(presetImages[index], fit: BoxFit.contain))),
                                      );
                                    },
                                    itemCount: presetImages.length,
                                    loop: false,
                                    autoplay: false,
                                    onIndexChanged: (index) {
                                      setState(() {
                                        presetPosition = index;
                                        userProvider.homePresetType = presetPosition;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(height: 10),
                                AnimatedSmoothIndicator(
                                  activeIndex: presetPosition,
                                  count: presetImages.length,
                                  effect: const ScrollingDotsEffect(
                                    dotColor: ColorFamily.beige,
                                    activeDotColor: ColorFamily.pink,
                                    spacing: 10,
                                    dotHeight: 10,
                                    dotWidth: 10,
                                    activeDotScale: 1.5,
                                  ),
                                )
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
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RegisterDoneScreen(
                                                    title: '', isHost: widget.isHost)),(route) => false);
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
              )
            ])));
  }
}
