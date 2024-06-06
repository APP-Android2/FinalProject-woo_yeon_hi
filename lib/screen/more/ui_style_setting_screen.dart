import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woo_yeon_hi/screen/more/top_bar_ui_setting_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/text_style.dart';
import 'package:woo_yeon_hi/widget/more/ui_setting_top_app_bar.dart';

import 'home_ui_setting_screen.dart';

class UiStyleSettingScreen extends StatelessWidget {
  const UiStyleSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {

    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const UiStyleSettingTopAppBar(),
      body: Container(
          width: deviceWidth,
          height: deviceHeight,
        padding: const EdgeInsets.all(20),
        color: ColorFamily.cream,
          child: Column(
            children: [
              SizedBox(
                width: deviceWidth-40,
                height: 60,
                child: Material(
                  color: ColorFamily.cream,
                  child: InkWell(
                    splashColor: ColorFamily.gray,
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeUiSettingScreen()));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("홈 화면 스타일",style: TextStyleFamily.smallTitleTextStyle),
                            SvgPicture.asset("lib/assets/icons/expand.svg")
                          ],
                        ),
                        const SizedBox(
                          height: 0.5,
                          child: Divider(color: ColorFamily.gray, thickness: 0.5),
                        )
                      ],
                    ),
                  ),
                )
              ),
              SizedBox(
                  width: deviceWidth-40,
                  height: 60,
                  child: Material(
                    color: ColorFamily.cream,
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const TopBarUiSettingScreen(),));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("상단바 스타일",style: TextStyleFamily.smallTitleTextStyle),
                              SvgPicture.asset("lib/assets/icons/expand.svg")
                            ],
                          ),
                          const SizedBox(
                            height: 0.5,
                            child: Divider(color: ColorFamily.gray, thickness: 0.5),
                          )
                        ],
                      ),
                    ),
                  )
              )
            ],
          )
    ) );
  }
}
