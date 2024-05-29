import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/style/text_style.dart';

import '../widget/main_bottom_navigation_bar.dart';
import '../widget/more/more_top_app_bar.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MoreTopAppBar(),
      body: Container(
        padding: EdgeInsets.all(20),
        color: ColorFamily.cream,
        child: Column(
          children: [
            SizedBox(height: 30),
            Container(
              child: Row(
                children: [
                  SizedBox(width: 30,),
                  InkWell(
                      onTap: (){},
                      borderRadius: BorderRadius.circular(50),
                      splashColor: Colors.transparent,
                      child: Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
                        child: Image.asset("lib/assets/images/default_profile.png"),
                      )),
                  SizedBox(width: 20,),
                  Container(
                    height: 100,
                    width: 210,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(width: 170, child: Text("멋쟁이사자처럼",style: TextStyle(color: ColorFamily.black,fontSize: 16,fontFamily: FontFamily.mapleStoryBold))),
                              InkWell(onTap: (){},child: Container(child: SvgPicture.asset('lib/assets/icons/expand.svg')))
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          width: 190,
                            child: Text("베낭매고 여행이나 갈까~\n베낭매고 여행이나 갈까~\n베낭매고 여행이나 갈까~",
                            style: TextStyle(color: ColorFamily.black,fontSize: 12,fontFamily: FontFamily.mapleStoryLight))
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50,),
            Container(
              child: Column(
                children: [
                  Material(
                    color: ColorFamily.white,
                    elevation: 1,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                          height: 60,
                          width: 360,
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 20),
                                child: SvgPicture.asset('lib/assets/icons/box.svg'),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "활동 모아보기",
                                  style: TextStyleFamily.normalTextStyle
                                ),
                              )
                            ],
                          )),
                    )),
                  SizedBox(height: 10,),
                  Material(
                      color: ColorFamily.white,
                      elevation: 1,
                      shadowColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                            height: 60,
                            width: 360,
                            child: Stack(
                              alignment: Alignment.centerLeft,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 20),
                                  child: SvgPicture.asset('lib/assets/icons/magicpen.svg'),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "화면 스타일 설정",
                                    style: TextStyleFamily.normalTextStyle
                                  ),
                                )
                              ],
                            )),
                      )),
                  SizedBox(height: 10,),
                  Material(
                      color: ColorFamily.white,
                      elevation: 1,
                      shadowColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                            height: 60,
                            width: 360,
                            child: Stack(
                              alignment: Alignment.centerLeft,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 20),
                                  child: SvgPicture.asset('lib/assets/icons/message-question.svg'),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "도움말",
                                    style: TextStyleFamily.normalTextStyle
                                  ),
                                )
                              ],
                            )),
                      )),
                  SizedBox(height: 10,),
                  Material(
                      color: ColorFamily.white,
                      elevation: 1,
                      shadowColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                            height: 60,
                            width: 360,
                            child: Stack(
                              alignment: Alignment.centerLeft,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 20),
                                  child: SvgPicture.asset('lib/assets/icons/user_edit.svg'),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "계정 설정",
                                    style: TextStyleFamily.normalTextStyle),
                                )
                              ],
                            )),
                      )),
                  SizedBox(height: 10,),
                  Material(
                      color: ColorFamily.white,
                      elevation: 1,
                      shadowColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                            height: 60,
                            width: 360,
                            child: Stack(
                              alignment: Alignment.centerLeft,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 20),
                                  child: SvgPicture.asset('lib/assets/icons/setting.svg'),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "앱 설정",
                                    style: TextStyleFamily.normalTextStyle
                                  ),
                                )
                              ],
                            )),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
