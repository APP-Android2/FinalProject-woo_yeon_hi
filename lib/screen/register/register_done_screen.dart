import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/screen/main_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';

import '../../provider/tab_page_index_provider.dart';
import '../../style/font.dart';

class RegisterDoneScreen extends StatefulWidget {
  const RegisterDoneScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<RegisterDoneScreen> createState() => _RegisterDoneScreen();
}

class _RegisterDoneScreen extends State<RegisterDoneScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: ColorFamily.cream,
          padding: EdgeInsets.all(20),
          child: AnimatedBackground(
            behaviour:
            // BubblesBehaviour(
            //   options: BubbleOptions(
            //     bubbleCount: 30,
            //     minTargetRadius: 20,
            //     maxTargetRadius: 30,
            //     growthRate: 10,
            //     popRate: 5
            //   )
            // ),
            RandomParticleBehaviour(
              options: ParticleOptions(
                opacityChangeRate: 25,
                spawnMinRadius: 10,
                spawnMaxRadius: 30,
                spawnMinSpeed: 30,
                spawnMaxSpeed: 50,
                particleCount: 30,
                minOpacity: 0.1,
                maxOpacity: 0.4,
                spawnOpacity: 0.5,
                baseColor: ColorFamily.cream,
                image: Image(image: AssetImage('lib/assets/images/heart_fill.png')),
              ),
            ),
            vsync: this,
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
                                        "우연히",
                                        style: TextStyle(
                                            color: ColorFamily.pink,
                                            fontSize: 40,
                                            fontFamily: FontFamily.cafe24Moyamoya),
                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.only(top: 160)),
                                    Container(
                                      child: Text(
                                        "커플 등록이 완료되었습니다!",
                                        style: TextStyle(
                                            color: ColorFamily.black,
                                            fontSize: 18,
                                            fontFamily: FontFamily.mapleStoryLight),
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "지금부터 ",
                                          style: TextStyle(
                                              color: ColorFamily.black,
                                              fontSize: 18,
                                              fontFamily: FontFamily.mapleStoryLight),
                                        ),
                                        Text(
                                          "멋쟁이사자",
                                          style: TextStyle(
                                              color: ColorFamily.black,
                                              fontSize: 20,
                                              fontFamily: FontFamily.mapleStoryBold),
                                        ),Text(
                                          " 님과",
                                          style: TextStyle(
                                              color: ColorFamily.black,
                                              fontSize: 18,
                                              fontFamily: FontFamily.mapleStoryLight),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 15),
                                    Text(
                                      "소중한 추억을 쌓아보세요!",
                                      style: TextStyle(
                                          color: ColorFamily.black,
                                          fontSize: 18,
                                          fontFamily: FontFamily.mapleStoryLight),
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
                                          elevation: 0.5,
                                          shadowColor: Colors.black,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(20.0),
                                          ),
                                          child: InkWell(
                                              onTap: () {
                                                runApp(MainScreen());
                                              },
                                              borderRadius:
                                              BorderRadius.circular(20.0),
                                              child: Container(
                                                  height: 40,
                                                  width: 120,
                                                  child: Container(
                                                    decoration: BoxDecoration(border: Border.all(color: ColorFamily.pink),borderRadius: BorderRadius.circular(20)),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "홈 화면으로 이동",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: ColorFamily.black,
                                                          fontFamily: FontFamily
                                                              .mapleStoryLight),
                                                    ),
                                                  ))),
                                        ),
                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.only(right: 50)),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ]),
              ],
            ),
          ),
        ));
  }
}