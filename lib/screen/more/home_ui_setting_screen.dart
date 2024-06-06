import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/widget/more/home_ui_setting_top_app_bar.dart';

class HomeUiSettingScreen extends StatefulWidget {
  const HomeUiSettingScreen({super.key});

  @override
  State<HomeUiSettingScreen> createState() => _HomeUiSettingScreenState();
}

class _HomeUiSettingScreenState extends State<HomeUiSettingScreen> {

  var presetImages = [
    "lib/assets/images/home_preset_standard_4x.png",
    "lib/assets/images/home_preset_dateplan_4x.png",
    "lib/assets/images/home_preset_ledger_4x.png",
    "lib/assets/images/home_preset_dateplan_ledger_4x.png",
  ];

  late int userPreset;
  late int presetPosition;

  @override
  void initState(){
    super.initState();

    userPreset = 3; // db에서 가져올 데이터
    presetPosition = userPreset;
  }


  @override
  Widget build(BuildContext context) {

    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const HomeUiSettingTopAppBar(),
      body: Container(
        width: deviceWidth,
        height: deviceHeight,
        padding: const EdgeInsets.all(20),
        color: ColorFamily.cream,
        child: Column(
          children: [
            SizedBox(height: deviceHeight*0.05),
            presetPosition == userPreset
            ? SizedBox(
              height: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("lib/assets/images/tick-circle_36px.png", width: 20,height: 20,),
                  const SizedBox(width: 5),
                  const Text("현재 적용됨", style: TextStyle(color: ColorFamily.black, fontSize: 12, fontFamily: FontFamily.mapleStoryLight),)
                ],
              ),
            )
            : const SizedBox(height: 20),
            const SizedBox(height: 5),
            SizedBox(
              height: deviceHeight*0.61,
              child: Swiper(
                index: presetPosition,
                viewportFraction: 0.6,
                scale: 0.6,
                itemBuilder:
                    (BuildContext context, int index) {
                  return Column(
                      children: [
                        Container(
                            decoration:
                            presetPosition == index
                            ? BoxDecoration(border: Border.all(color: ColorFamily.pink, width: 2), borderRadius: BorderRadius.circular(20))
                            : BoxDecoration(border: Border.all(color: Colors.transparent, width: 2), borderRadius: BorderRadius.circular(20)),
                            child: Material(borderRadius: BorderRadius.circular(20), elevation: 1.0, child: ClipRRect(borderRadius: BorderRadius.circular(20), child: Image.asset(presetImages[index], fit: BoxFit.cover,)))),
                      ],
                    );
                },
                itemCount: presetImages.length,
                loop: false,
                autoplay: false,
                onIndexChanged: (index) {
                  setState(() {
                    presetPosition = index;
                  });
                },
              ),
            ),
            const SizedBox(height: 15),
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
          ]),
      ),
    );
  }
}
