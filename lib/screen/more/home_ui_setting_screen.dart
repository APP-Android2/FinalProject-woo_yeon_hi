import 'package:card_swiper/card_swiper.dart';
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
    "lib/assets/images/home_preset_standard.png",
    "lib/assets/images/home_preset_dateplan.png",
    "lib/assets/images/home_preset_ledger.png",
    "lib/assets/images/home_preset_dateplan_ledger.png",
  ];

  var presetPosition = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeUiSettingTopAppBar(),
      body: Container(
        padding: EdgeInsets.all(20),
        color: ColorFamily.cream,
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 50),
              presetPosition == 0
              ? Container(
                height: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("lib/assets/images/tick-circle_36px.png",width: 20,height: 20,),
                    SizedBox(width: 5),
                    Text("현재 적용됨", style: TextStyle(color: ColorFamily.black,fontSize: 12,fontFamily: FontFamily.mapleStoryLight),)
                  ],
                ),
              )
              : SizedBox(height: 20),
              SizedBox(height: 5),
              Container(
                height: 400,
                child: Swiper(
                  viewportFraction: 0.5,
                  scale: 0.6,
                  itemBuilder:
                      (BuildContext context, int index) {
                    return Image.asset(presetImages[index], fit: BoxFit.contain);
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
              Padding(padding: EdgeInsets.only(bottom: 15)),
              AnimatedSmoothIndicator(
                activeIndex: presetPosition,
                count: presetImages.length,
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
      ),
    );
  }
}
