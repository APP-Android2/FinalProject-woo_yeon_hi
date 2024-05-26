import 'package:flutter/material.dart';
import 'package:woo_yeon_hi/screen/register/birthday_setting_screen.dart';
import 'package:woo_yeon_hi/screen/register/register_screen.dart';

import '../../style/color.dart';
import '../../style/font.dart';

import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:card_swiper/card_swiper.dart';

class HomePresetSettingScreen extends StatefulWidget {
  const HomePresetSettingScreen({super.key});

  @override
  State<HomePresetSettingScreen> createState() => _RegisterDoneScreenState();
}

class _RegisterDoneScreenState extends State<HomePresetSettingScreen> {
  // var presetImages1 = [
  //   Image.asset("lib/assets/images/home_preset_standard.png"),
  //   Image.asset("lib/assets/images/home_preset_dateplan.png"),
  //   Image.asset("lib/assets/images/home_preset_ledger.png"),
  //   Image.asset("lib/assets/images/home_preset_dateplan_ledger.png"),
  // ];
  var presetImages2 = [
    "lib/assets/images/home_preset_standard.png",
    "lib/assets/images/home_preset_dateplan.png",
    "lib/assets/images/home_preset_ledger.png",
    "lib/assets/images/home_preset_dateplan_ledger.png",
  ];

  var presetImagesHeight = 400.0;
  var presetImagesWidth = 180.0;

  var presetPosition = 0;

  late CarouselSlider cardSlider;

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
                              Container(
                                child: Text(
                                  "5 / 5",
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
                                      "lib/assets/images/heart_fill.png",
                                      height: 24,
                                    ),
                                  ],
                                ),
                              )),
                              Padding(padding: EdgeInsets.only(top: 50)),
                              Container(
                                child: Text(
                                  "홈 화면 스타일을 골라주세요",
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
                                  "언제든지 변경할 수 있어요 :)",
                                  style: TextStyle(
                                      color: ColorFamily.gray,
                                      fontSize: 12,
                                      fontFamily: FontFamily.mapleStoryLight),
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(top: 20)),
                              Container(
                                height: 400,
                                child: Swiper(
                                  viewportFraction: 0.5,
                                  scale: 0.6,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Image.asset(presetImages2[index],
                                        fit: BoxFit.contain);
                                  },
                                  itemCount: presetImages2.length,
                                  loop: false,
                                  autoplay: false,
                                  onIndexChanged: (index) {
                                    setState(() {
                                      presetPosition = index;
                                    });
                                  },
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 15)),
                              AnimatedSmoothIndicator(
                                activeIndex: presetPosition,
                                count: presetImages2.length,
                                effect: ScrollingDotsEffect(
                                  dotColor: ColorFamily.beige,
                                  activeDotColor: ColorFamily.pink,
                                  spacing: 10,
                                  dotHeight: 10,
                                  dotWidth: 10,
                                  activeDotScale: 1.5,
                                ),
                              )
                            ])),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Padding(padding: EdgeInsets.only(left: 50)),
                              Expanded(
                                child: Container(
                                  child: Material(
                                    color: ColorFamily.white,
                                    elevation: 1.0,
                                    shadowColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BirthdaySettingScreen()));
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
                                  elevation: 1.0,
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
                                            "완료",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontFamily:
                                                    FontFamily.mapleStoryLight),
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
    ));
  }
}
