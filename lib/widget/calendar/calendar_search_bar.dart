import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:woo_yeon_hi/screen/calendar/calendar_detail_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';

import '../../style/font.dart';
import '../../style/text_style.dart';

class CalendarSearchBar extends StatefulWidget {
  const CalendarSearchBar({super.key});

  @override
  State<CalendarSearchBar> createState() => _CalendarSearchBarState();
}

class _CalendarSearchBarState extends State<CalendarSearchBar> {

  DateTime _focusedDay = DateTime.now();  // 오늘 날짜
  DateTime? _selectedDay;

  // 주말인지
  bool isWeekend(DateTime day){
    return day.weekday == DateTime.sunday;
  }

  // 토요일인지
  bool isSaturday(DateTime day){
    return day.weekday == DateTime.saturday;
  }

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
          onTap: () {
            showCalendarBottomSheet();
          },
          child: SvgPicture.asset('lib/assets/icons/calendar.svg'),
        ),
      ],
      transition: CircularFloatingSearchBarTransition(spacing: 20),
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Card(
            elevation: 4.0,
            // 검색 컨테이너
            child: Container(
              height: 400,
              child: buildBody(),
            )
          ),
        );
      },
      //body: buildBody(),
    );
  }

  // 항목 리스트 구성
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


  // 캘린더 바텀 시트
  void showCalendarBottomSheet(){
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, bottomState) {
            return Wrap(
              children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: ColorFamily.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TableCalendar(
                          locale: 'ko_KR',
                          firstDay: DateTime.utc(2024, 1, 1), // 최소 날짜
                          lastDay: DateTime.utc(2999, 12, 31),  // 최대 날짜
                          focusedDay: _focusedDay,
                          // 캘린더 헤더
                          headerStyle: const HeaderStyle(
                            titleCentered: true,
                            formatButtonVisible: false,
                            titleTextStyle: TextStyleFamily.appBarTitleBoldTextStyle
                          ),
                          daysOfWeekStyle: const DaysOfWeekStyle(
                            weekdayStyle: TextStyleFamily.normalTextStyle,  // 평일
                            weekendStyle: TextStyleFamily.normalTextStyle,  // 주말
                          ),
                          calendarBuilders: CalendarBuilders(
                            // 기본 월의 빌더
                            defaultBuilder: (context, day, focusedDay) {
                              return Container(
                                alignment: Alignment.center,
                                child: Text(
                                  DateFormat('d').format(day),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: isWeekend(day)
                                      ? Colors.red
                                      : isSaturday(day)
                                        ? Colors.blueAccent
                                        : ColorFamily.black,
                                    fontFamily: FontFamily.mapleStoryLight
                                  ),
                                ),
                              );
                            },
                            // 다른 월의 빌더
                            outsideBuilder: (context, day, focusedDay) {
                              return Container(
                                alignment: Alignment.center,
                                child: Text(
                                  DateFormat('d').format(day),
                                  textAlign: TextAlign.center,
                                  style: TextStyleFamily.hintTextStyle,
                                ),
                              );
                            },
                            // 비활성화된 날짜
                            disabledBuilder: (context, day, focusedDay) {
                              return Container(
                                alignment: Alignment.center,
                                child: Text(
                                  DateFormat('d').format(day),
                                  textAlign: TextAlign.center,
                                  style: TextStyleFamily.hintTextStyle,
                                ),
                              );
                            },
                            // 선택된 날짜
                            selectedBuilder: (context, day, focusedDay) {
                              return Container(
                                alignment: Alignment.center,
                                child: Container(
                                  width: 30, height: 30,
                                  decoration: const BoxDecoration(
                                    color: ColorFamily.pink,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      DateFormat('d').format(day),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: isWeekend(day)
                                          ? ColorFamily.white
                                          : isSaturday(day)
                                            ? ColorFamily.white
                                            : ColorFamily.black,
                                        fontFamily: FontFamily.mapleStoryLight
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            // 오늘 날짜
                            todayBuilder: (context, day, focusedDay) {
                              return Container(
                                alignment: Alignment.center,
                                child: Container(
                                  width: 30, height: 30,
                                  decoration: const BoxDecoration(
                                    color: ColorFamily.black,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      DateFormat('d').format(day),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: ColorFamily.white,
                                        fontFamily: FontFamily.mapleStoryLight
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            // 마커
                            markerBuilder: (context, day, events) {
                              var today = "${DateTime.now().toIso8601String().substring(0, 10)} 00:00:00.000Z";
                              return Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.only(top: 20),
                                child: Container(
                                  width: 6, height: 6,
                                  decoration: BoxDecoration(
                                    color: (day == _selectedDay || day.toString() == today)
                                        ? ColorFamily.white
                                        : ColorFamily.pink,
                                    shape: BoxShape.circle
                                  ),
                                ),
                              );
                            },
                          ),
                          // 선택된 날짜
                          selectedDayPredicate: (day) {
                            return isSameDay(_selectedDay, day);
                          },
                          // 날짜 선택
                          onDaySelected: (selectedDay, focusedDay) {
                            bottomState((){
                              setState(() {
                                _selectedDay = selectedDay;
                                _focusedDay = focusedDay;
                              });
                            });
                          },
                          // 화면이 바뀔 때
                          onPageChanged: (focusedDay) {
                            _focusedDay = focusedDay;
                          },
                        ),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            // 오늘 날짜로
                            SizedBox(
                              width: ((MediaQuery.of(context).size.width - 40) / 2) - 10,
                              height: 40,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorFamily.white,
                                  surfaceTintColor: ColorFamily.white,
                                ),
                                onPressed: () {
                                  bottomState(() {
                                    setState(() {
                                      _selectedDay = DateTime.now();
                                      _focusedDay = DateTime.now();
                                    });
                                  });
                                },
                                child: const Text("오늘 날짜로", style: TextStyleFamily.normalTextStyle),
                              ),
                            ),
                            const SizedBox(width: 20),
                            // 확인 버튼
                            SizedBox(
                              width: ((MediaQuery.of(context).size.width - 40) / 2) - 10,
                              height: 40,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorFamily.beige,
                                  surfaceTintColor: ColorFamily.beige,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("확인", style: TextStyleFamily.normalTextStyle),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        );
      },
    );
  }
}
