import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:woo_yeon_hi/screen/calendar/calendar_detail_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/widget/calendar/calendar_search_date.dart';

import '../../style/font.dart';
import '../../style/text_style.dart';

class CalendarSearchBar extends StatefulWidget {
  const CalendarSearchBar({super.key});

  @override
  State<CalendarSearchBar> createState() => _CalendarSearchBarState();
}

class _CalendarSearchBarState extends State<CalendarSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorFamily.cream,
      body: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: buildSearchBar(context),
      ),
    );
  }
  
  Widget buildSearchBar(BuildContext context){
    final List<FloatingSearchBarAction> actions = <FloatingSearchBarAction>[];

    final bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      iconColor: ColorFamily.black,
      height: 50,
      borderRadius: BorderRadius.circular(20),
      elevation: 4,
      automaticallyImplyBackButton: false,
      // controller: controller,
      hint: "일정 검색",
      backgroundColor: ColorFamily.beige,
      hintStyle: TextStyleFamily.hintTextStyle,
      queryStyle: TextStyleFamily.normalTextStyle,
      backdropColor: ColorFamily.cream,
      textInputType: TextInputType.text,
      onSubmitted: (query) {},
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
      leadingActions: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: SvgPicture.asset("lib/assets/icons/arrow_back.svg"),
        ),
      ],
      actions: [
        InkWell(
          onTap: () {},
          child: SvgPicture.asset('lib/assets/icons/calendar.svg'),
        ),

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
      transition: CircularFloatingSearchBarTransition(spacing: 20),
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Card(
            elevation: 4.0,
            // 검색 컨테이너
            child: Container(
              height: 400,
              // Column(
              //   mainAxisSize: MainAxisSize.min,
              //   children: Colors.accents.map((color) {
              //     return Container(height: 112, color: color);
              //   }).toList(),
              // ),
              child: buildBody(),
            )
          ),
        );
      },
      //body: buildBody(),
    );
  }
  
  Widget buildBody(){
    return Column(
      children: [
        Expanded(
          child: Container(
            color: ColorFamily.beige,
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return searchListItem(context, index);
              },
            ),
          ),
        ),
      ],
    );
  }

  // 한개의 항목 구성
  Widget searchListItem(BuildContext context, int index){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            "2024. 5. 23.(목)",
            style: TextStyle(
              fontSize: 13,
              fontFamily: FontFamily.mapleStoryLight,
              color: ColorFamily.black,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Divider(color: ColorFamily.gray),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CalendarDetailScreen())
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                SizedBox(
                    width: 5, height: 35,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: ColorFamily.green
                      ),
                    )
                ),
                SizedBox(width: 10),
                Text(
                  "한강 피크닉 $index",
                  style: TextStyleFamily.normalTextStyle,
                ),
                Spacer(),
                Text(
                    "09:30 ~ 13:00",
                    style: TextStyleFamily.normalTextStyle
                )
              ],
            ),
          ),
        ),
        SizedBox(height: 30),
      ],
    );
  }
}
