import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woo_yeon_hi/screen/more/daily_summary_screen.dart';
import 'package:woo_yeon_hi/screen/more/profile_edit_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/style/text_style.dart';
import '../../widget/more/more_top_app_bar.dart';

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
                  SizedBox(width: 20,),
                  Material(
                    elevation: 1,
                    borderRadius: BorderRadius.circular(60),
                    child: InkWell(
                        onTap: (){},
                        borderRadius: BorderRadius.circular(60),
                        splashColor: Colors.transparent,
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(60),image: DecorationImage(image: AssetImage('lib/assets/images/default_profile.png'))),
                        )),
                  ),
                  SizedBox(width: 20,),
                  Container(
                    height: 120,
                    width: 210,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(width: 170, child: Text("우연남",style: TextStyle(color: ColorFamily.black,fontSize: 16,fontFamily: FontFamily.mapleStoryBold))),
                              InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileEditScreen()));
                                  },
                                  child: Container(width: 40, height: 40, child: SvgPicture.asset('lib/assets/icons/expand.svg',fit: BoxFit.none,)))
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: 190,
                            child: Text("함께할 때 가장 행복해!\n너와 나, 완벽한 조합 💑",
                              style: TextStyle(color: ColorFamily.black,fontSize: 12,fontFamily: FontFamily.mapleStoryLight), maxLines: 3)
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
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DailySummaryScreen()));
                      },
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
