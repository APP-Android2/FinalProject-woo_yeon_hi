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
    return Scaffold(
      appBar: UiStyleSettingTopAppBar(),
      body: Container(
        padding: EdgeInsets.all(20),
        color: ColorFamily.cream,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 60,
                child: Material(
                  color: ColorFamily.cream,
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeUiSettingScreen(),));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(height: 5),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("홈 화면 스타일",style: TextStyleFamily.smallTitleTextStyle),
                              SvgPicture.asset("lib/assets/icons/expand.svg")
                            ],
                          ),
                        ),
                        Container(
                          height: 0.5,
                          color: ColorFamily.pink,
                          child: Divider(color: ColorFamily.gray, thickness: 0.5),
                        )
                      ],
                    ),
                  ),
                )
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 60,
                  child: Material(
                    color: ColorFamily.cream,
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => TopBarUiSettingScreen(),));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(height: 5),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("상단바 스타일",style: TextStyleFamily.smallTitleTextStyle),
                                SvgPicture.asset("lib/assets/icons/expand.svg")
                              ],
                            ),
                          ),
                          Container(
                            height: 0.5,
                            color: ColorFamily.pink,
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
