import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/style/text_style.dart';

import '../../widget/more/top_bar_ui_setting_top_app_bar.dart';

class TopBarUiSettingScreen extends StatefulWidget {
  const TopBarUiSettingScreen({super.key});

  @override
  State<TopBarUiSettingScreen> createState() => _TopBarUiSettingScreenState();
}

class _TopBarUiSettingScreenState extends State<TopBarUiSettingScreen> {

  var _topBarIndex = 1;
  var _topbarActivated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBarUiSettingTopAppBar(),
      body: Container(
        padding: EdgeInsets.all(20),
        color: ColorFamily.cream,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Material(
                elevation: 1,
                borderRadius: BorderRadius.circular(20),
                borderOnForeground: true,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: (){
                    setState(() {
                      _topBarIndex = 0;
                    });
                  },
                  child: _topBarIndex == 0
                  ? Container(
                    width: 380,
                    height: 60,
                    decoration: BoxDecoration(color: ColorFamily.white, border: Border.all(color: ColorFamily.pink,width: 1),borderRadius: BorderRadius.circular(20)),
                    child: Stack(
                      children: [
                          Align(alignment: Alignment.center, child: Text("100일", style: TextStyleFamily.smallTitleTextStyle)),
                          Align(alignment: Alignment.center, child: Padding(padding: EdgeInsets.only(left: 250), child: Image.asset("lib/assets/images/top_bar_heart_36px.png",width: 30, height: 33)))
                      ],
                    ),
                    )
                  : Container(
                      width: 380,
                      height: 60,
                      decoration: BoxDecoration(color: ColorFamily.white, borderRadius: BorderRadius.circular(20)),
                      child: Stack(
                        children: [
                          Align(alignment: Alignment.center, child: Text("100일", style: TextStyleFamily.smallTitleTextStyle)),
                          Align(alignment: Alignment.center, child: Padding(padding: EdgeInsets.only(left: 250), child: Image.asset("lib/assets/images/top_bar_heart_36px.png",width: 30, height: 33)))
                      ],
                    ),
                  )
                ),
              ),
              SizedBox(height: 20),
              Material(
                elevation: 1,
                borderRadius: BorderRadius.circular(20),
                borderOnForeground: true,
                child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: (){
                      setState(() {
                        _topBarIndex = 1;
                      });
                    },
                    child: _topBarIndex == 1
                        ? Container(
                          width: 380,
                          height: 60,
                          decoration: BoxDecoration(color: ColorFamily.white, border: Border.all(color: ColorFamily.pink,width: 1),borderRadius: BorderRadius.circular(20)),
                          child: Stack(
                            children: [
                              Align(alignment: Alignment.center, child: Text("+100", style: TextStyleFamily.smallTitleTextStyle)),
                              Align(alignment: Alignment.center, child: Padding(padding: EdgeInsets.only(left: 250), child: Image.asset("lib/assets/images/top_bar_heart_36px.png",width: 30, height: 33)))
                            ],
                          ),
                        )
                            : Container(
                          width: 380,
                          height: 60,
                          decoration: BoxDecoration(color: ColorFamily.white, borderRadius: BorderRadius.circular(20)),
                          child: Stack(
                            children: [
                              Align(alignment: Alignment.center, child: Text("+100", style: TextStyleFamily.smallTitleTextStyle)),
                              Align(alignment: Alignment.center, child: Padding(padding: EdgeInsets.only(left: 250), child: Image.asset("lib/assets/images/top_bar_heart_36px.png",width: 30, height: 33)))
                        ],
                      ),
                    )
                ),
              ),
              SizedBox(height: 20),
              Material(
                elevation: 1,
                borderRadius: BorderRadius.circular(20),
                borderOnForeground: true,
                child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: (){
                      setState(() {
                        _topBarIndex = 2;
                      });
                    },
                    child: _topBarIndex == 2
                        ? Container(
                      width: 380,
                      height: 120,
                      decoration: BoxDecoration(color: ColorFamily.white, border: Border.all(color: ColorFamily.pink,width: 1),borderRadius: BorderRadius.circular(20)),
                      child: Stack(
                        children: [
                          Align(alignment: Alignment.centerLeft,
                              child: Padding(padding: EdgeInsets.only(left: 30),
                               child: ClipRRect(
                                 borderRadius: BorderRadius.circular(100.0),
                                 child: Image.asset(
                                   'lib/assets/images/default_profile.png',
                                   fit: BoxFit.cover, width: 80, height: 80),
                               )
                          )),
                          Align(alignment: Alignment.center, child: Padding(padding: EdgeInsets.only(bottom: 20), child: Image.asset("lib/assets/images/top_bar_heart_36px.png",width: 30, height: 33))),
                          Align(alignment: Alignment.center, child: Padding(padding: EdgeInsets.only(top: 40), child: Text("100일", style: TextStyleFamily.smallTitleTextStyle))),
                          Align(alignment: Alignment.centerRight, child: Padding(padding: EdgeInsets.only(left: 30),
                              child: Padding(
                                padding: EdgeInsets.only(right: 30),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100.0),
                                  child: Image.asset(
                                      'lib/assets/images/default_profile.png',
                                      fit: BoxFit.cover, width: 80, height: 80),
                                ),
                              )
                          )),
                        ],
                      ),
                    )
                        : Container(
                      width: 380,
                      height: 120,
                      decoration: BoxDecoration(color: ColorFamily.white, borderRadius: BorderRadius.circular(20)),
                      child: Stack(
                        children: [
                          Align(alignment: Alignment.centerLeft,
                              child: Padding(padding: EdgeInsets.only(left: 30),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100.0),
                                    child: Image.asset(
                                        'lib/assets/images/default_profile.png',
                                        fit: BoxFit.cover, width: 80, height: 80),
                                  )
                              )),
                          Align(alignment: Alignment.center, child: Padding(padding: EdgeInsets.only(bottom: 20), child: Image.asset("lib/assets/images/top_bar_heart_36px.png",width: 30, height: 33))),
                          Align(alignment: Alignment.center, child: Padding(padding: EdgeInsets.only(top: 40), child: Text("100일", style: TextStyleFamily.smallTitleTextStyle))),
                          Align(alignment: Alignment.centerRight, child: Padding(padding: EdgeInsets.only(left: 30),
                              child: Padding(
                                padding: EdgeInsets.only(right: 30),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100.0),
                                  child: Image.asset(
                                      'lib/assets/images/default_profile.png',
                                      fit: BoxFit.cover, width: 80, height: 80),
                                ),
                              )
                          )),
                        ],
                      ),
                    )
                ),
              ),
              SizedBox(height: 20),
              Material(
                elevation: 1,
                borderRadius: BorderRadius.circular(20),
                borderOnForeground: true,
                child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: (){
                      setState(() {
                        _topBarIndex = 3;
                      });
                    },
                    child: _topBarIndex == 3
                        ? Container(
                      width: 380,
                      height: 120,
                      decoration: BoxDecoration(color: ColorFamily.white, border: Border.all(color: ColorFamily.pink,width: 1),borderRadius: BorderRadius.circular(20)),
                      child: Stack(
                        children: [
                          Align(alignment: Alignment.centerLeft, child: Padding(padding: EdgeInsets.only(left: 60), child: Text("100일", style: TextStyleFamily.smallTitleTextStyle))),
                          Align(alignment: Alignment.centerLeft, child: Padding(padding: EdgeInsets.only(left: 110), child: Image.asset("lib/assets/images/top_bar_heart_36px.png",width: 30, height: 33))),
                          Align(alignment: Alignment.centerRight,
                              child: Padding(padding: EdgeInsets.only(right: 40),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100.0),
                                  child: Image.asset(
                                    'lib/assets/images/default_profile.png',
                                    fit: BoxFit.cover, width: 80, height: 80),
                                ),
                              )
                          ),
                          Align(alignment: Alignment.center,
                              child: Padding(padding: EdgeInsets.only(left: 100),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100.0),
                                    child: Image.asset(
                                        'lib/assets/images/default_profile.png',
                                        fit: BoxFit.cover, width: 80, height: 80),
                                  )
                              ))
                        ],
                      ),
                    )
                        : Container(
                      width: 380,
                      height: 120,
                      decoration: BoxDecoration(color: ColorFamily.white, borderRadius: BorderRadius.circular(20)),
                      child: Stack(
                        children: [
                          Align(alignment: Alignment.centerLeft, child: Padding(padding: EdgeInsets.only(left: 60), child: Text("100일", style: TextStyleFamily.smallTitleTextStyle))),
                          Align(alignment: Alignment.centerLeft, child: Padding(padding: EdgeInsets.only(left: 110), child: Image.asset("lib/assets/images/top_bar_heart_36px.png",width: 30, height: 33))),
                          Align(alignment: Alignment.centerRight,
                              child: Padding(padding: EdgeInsets.only(right: 40),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100.0),
                                  child: Image.asset(
                                      'lib/assets/images/default_profile.png',
                                      fit: BoxFit.cover, width: 80, height: 80),
                                ),
                              )
                          ),
                          Align(alignment: Alignment.center,
                              child: Padding(padding: EdgeInsets.only(left: 100),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100.0),
                                    child: Image.asset(
                                        'lib/assets/images/default_profile.png',
                                        fit: BoxFit.cover, width: 80, height: 80),
                                  )
                              ))
                        ],
                      ),
                    )
                ),
              ),
              SizedBox(height: 30),
              Container(
                width: 375,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("상단바 활성화", style: TextStyle(fontFamily: FontFamily.mapleStoryLight,fontSize: 12,color: ColorFamily.black)),
                    Switch(
                      value: _topbarActivated,
                      activeColor: ColorFamily.white,
                      activeTrackColor: ColorFamily.pink,
                      inactiveThumbColor: ColorFamily.gray,
                      inactiveTrackColor: ColorFamily.white,
                      trackOutlineWidth: MaterialStatePropertyAll(0.5),
                      onChanged: (bool value) {
                        // This is called when the user toggles the switch.
                        setState(() {
                          _topbarActivated = value;
                        });
                      }),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
