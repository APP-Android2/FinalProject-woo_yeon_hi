import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/style/text_style.dart';
import 'package:woo_yeon_hi/widget/more/help_top_app_bar.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final FloatingSearchBarController controller = FloatingSearchBarController();
  var _searchKeyword = "";
  var _expandIndex = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: HelpTopAppBar(),
        body: Container(
            padding: EdgeInsets.all(20),
            color: ColorFamily.cream,
            child: buildSearchBar(context)));
  }
}

Widget buildSearchBar(BuildContext context) {
  final List<FloatingSearchBarAction> actions = <FloatingSearchBarAction>[];

  final bool isPortrait =
      MediaQuery.of(context).orientation == Orientation.portrait;

  return
      // Consumer<SearchModel>(
      // builder: (BuildContext context, SearchModel model, _) =>
      FloatingSearchBar(
      iconColor: ColorFamily.black,
      height: 60,
      borderRadius: BorderRadius.circular(20),
      elevation: 1,
      automaticallyImplyBackButton: false,
      // controller: controller,
      hint: '어떤 도움이 필요하신가요?',
      backgroundColor: ColorFamily.beige,
      hintStyle: TextStyleFamily.normalTextStyle,
      queryStyle: TextStyleFamily.normalTextStyle,
      // backdropColor: ColorFamily.cream,
      backdropColor: Colors.transparent,
      textInputType: TextInputType.text,
      onSubmitted: (query) {},
      // leadingActions: [SvgPicture.asset('lib/assets/icons/arrow_back.svg')],
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 500),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        // Call your model, bloc, controller here.
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      // transition: CircularFloatingSearchBarTransition(),
      actions: [
        SvgPicture.asset('lib/assets/icons/search.svg'),

        // FloatingSearchBarAction(
        //   showIfOpened: false,
        //   child: SvgPicture.asset('lib/assets/icons/delete.svg'),
        // ),
        // FloatingSearchBarAction.searchToClear(
        //   showIfClosed: true,
        // ),
      ],
      // actions: actions,
      // progress: model.isLoading,
      // onQueryChanged: model.onQueryChanged,
      // onKeyEvent: (KeyEvent keyEvent) {
      //   if (keyEvent.logicalKey == LogicalKeyboardKey.escape) {
      //     controller.query = '';
      //     controller.close();
      //   }
      // },
      transition: CircularFloatingSearchBarTransition(spacing: 16),
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
              elevation: 4.0,
              child: Container(height: 300, color: ColorFamily.beige)
              // Column(
              //   mainAxisSize: MainAxisSize.min,
              //   children: Colors.accents.map((color) {
              //     return Container(height: 112, color: color);
              //   }).toList(),
              // ),
              ),
        );
      },
      body: ListView(children: [buildBody()]),
  );
}

Widget buildBody() {
  return Container(
    padding: EdgeInsets.all(10),
    color: ColorFamily.cream,
    width: 360,
    height: 800,
    child: Column(
      children: [
        SizedBox(height: 100),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(bottom: 30),
            color: ColorFamily.cream,
            child: ListView.builder(
              itemCount: 15,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Material(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorFamily.white,
                      elevation: 1,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          splashColor: Colors.transparent, // 원하는 splashColor로 변경
                        ),
                        child: ExpansionTile(
                            iconColor: ColorFamily.black,
                            leading:
                            //TODO 펼침 여부에 따라 아이콘 변경
                            SvgPicture.asset("lib/assets/icons/arrow_right_fill.svg"),
                            //SvgPicture.asset("lib/assets/icons/arrow_down_fill.svg"),
                            trailing: SvgPicture.asset(""),
                            title: Text("탈퇴시 상대방 계정 처리가 궁금해요.",
                                style: TextStyleFamily.normalTextStyle),
                            backgroundColor: ColorFamily.beige,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            collapsedShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            children: [helpListItem(context, index)]),
                      ),
                    ),
                    SizedBox(height: 10)
                  ],
                );
              },
            ),
          ),
        )
      ],
    ),
  );
}

Widget helpListItem(BuildContext context, int index) {
  return Container(
      child: Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              // child:
              // SvgPicture.asset("lib/assets/icons/arrow_right_fill.svg")
              // SvgPicture.asset("lib/assets/icons/arrow_down_fill.svg")
              ),
          SizedBox(width: 50),
          Container(
            width: 330,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text("탈퇴시 상대방 계정 처리가 궁금해요.", style: TextStyleFamily.normalTextStyle),
                // SizedBox(height: 10),
                Text(
                    "계정삭제(탈퇴)를 할 경우 상대방 계정은 lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    style: TextStyle(
                        fontSize: 12,
                        color: ColorFamily.black,
                        fontFamily: FontFamily.mapleStoryLight)),
              ],
            ),
          ),
        ],
      ),
      SizedBox(height: 20),
    ],
  ));
}
