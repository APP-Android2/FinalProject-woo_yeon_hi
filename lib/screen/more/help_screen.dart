import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/style/text_style.dart';
import 'package:woo_yeon_hi/widget/more/help_top_app_bar.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  String _searchKeyword = "";
  bool _isUnExpanded = true;

  List<String> helpListTitle = [
    "탈퇴 시 상대방 계정 처리가 궁금해요.",
    "로그아웃은 어떻게 하나요?",
    "데이터 백업은 어떻게 하나요?",
    "잠금 비밀번호를 잊어버렸을 때 해결방법이 궁금해요.",
    "탈퇴 시 상대방 계정 처리가 궁금해요.",
    "로그아웃은 어떻게 하나요?",
    "데이터 백업은 어떻게 하나요?",
    "잠금 비밀번호를 잊어버렸을 때 해결방법이 궁금해요.",
    "탈퇴 시 상대방 계정 처리가 궁금해요.",
    "로그아웃은 어떻게 하나요?",
    "데이터 백업은 어떻게 하나요?",
    "잠금 비밀번호를 잊어버렸을 때 해결방법이 궁금해요.",
  ];



  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: const HelpTopAppBar(),
        body: Container(
            width: deviceWidth,
            height: deviceHeight,
            padding: const EdgeInsets.all(20),
            color: ColorFamily.cream,
            child: Column(
              children: [
                Material(
                  elevation: 1,
                  color: ColorFamily.beige,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    alignment: Alignment.center,
                    width: deviceWidth - 60,
                    height: deviceHeight * 0.07,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      cursorColor: ColorFamily.black,
                      textInputAction: TextInputAction.search,
                      style: TextStyleFamily.normalTextStyle,
                      decoration: InputDecoration(
                          suffixIcon:
                          SvgPicture.asset("lib/assets/icons/search.svg"),
                          suffixIconConstraints:
                          const BoxConstraints(minHeight: 24, minWidth: 24),
                          hintText: "어떤 도움이 필요하신가요?",
                          hintStyle: TextStyle(
                              fontSize: 14,
                              color: ColorFamily.black.withOpacity(0.5),
                              fontFamily: FontFamily.mapleStoryLight),
                          counterText: "",
                          border: InputBorder.none),
                      onTapOutside: (event) {
                        FocusScope.of(context).unfocus();
                      },
                      onFieldSubmitted: (value) {
                        //TODO value를 포함하는 도움말 항목들만 노출되도록 기능 구현
                        setState(() {
                          _searchKeyword = value;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 30),
                    color: ColorFamily.cream,
                    child: ListView.builder(
                      itemCount: 12,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Material(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorFamily.white,
                              elevation: 1,
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                  splashColor: Colors.transparent,
                                ),
                                child: ExpansionTile(
                                    onExpansionChanged: (isExpanded) {
                                      setState(() {
                                        _isUnExpanded = !_isUnExpanded;
                                      });
                                    },
                                    iconColor: ColorFamily.black,
                                    leading: _isUnExpanded
                                        ? SvgPicture.asset(
                                        "lib/assets/icons/arrow_right_fill.svg")
                                        : SvgPicture.asset("lib/assets/icons/arrow_down_fill.svg"),
                                    trailing: SvgPicture.asset(""),
                                    title: Text(helpListTitle[index], style: TextStyleFamily.normalTextStyle),
                                    backgroundColor: ColorFamily.beige,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    children: [
                                      makeHelpListItem(context, index)
                                    ]),
                              ),
                            ),
                            const SizedBox(height: 10)
                          ],
                        );
                      },
                    ),
                  ),
                )
              ],
            )));
  }
}

Widget makeHelpListItem(BuildContext context, int index) {
  return const Column(
    children: [
      Padding(
        padding: EdgeInsets.only(left: 30),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.",
              style: TextStyle(
                  fontSize: 12,
                  color: ColorFamily.black,
                  fontFamily: FontFamily.mapleStoryLight)),
        ),
      ),
      SizedBox(height: 20),
    ],
  );
}
