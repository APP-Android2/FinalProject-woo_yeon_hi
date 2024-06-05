import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/style/text_style.dart';

import '../../provider/dDay_provider.dart';
import '../../widget/dDay/dDay_make_custom_top_app_bar.dart';

class dDayMakeCustomScreen extends StatefulWidget {
  const dDayMakeCustomScreen({super.key});

  @override
  State<dDayMakeCustomScreen> createState() => _dDayMakeCustomScreenState();
}

class _dDayMakeCustomScreenState extends State<dDayMakeCustomScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => dDayMakeCustomProvider(),
      child: Consumer<dDayMakeCustomProvider>(
        builder: (context, provider, _){
          return GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Scaffold(
              backgroundColor: ColorFamily.cream,
              appBar: dDayMakeCustomTopAppBar(provider),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // 타이틀 입력
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 40,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "타이틀",
                              style: TextStyleFamily.dialogButtonTextStyle,
                            )
                          ],
                        ),
                      ),
                      TextField(
                        controller: provider.title,
                        cursorColor: ColorFamily.black,
                        style: TextStyleFamily.normalTextStyle,
                        maxLines: 1,
                        maxLength: 20,
                        decoration: const InputDecoration(
                          hintText: "한 줄로 작성해주세요!",
                          hintStyle: TextStyleFamily.hintTextStyle,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: ColorFamily.black),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: ColorFamily.black),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      // d-day 설명
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 40,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "디데이 설명",
                              style: TextStyleFamily.dialogButtonTextStyle,
                            )
                          ],
                        ),
                      ),
                      TextField(
                        controller: provider.content,
                        cursorColor: ColorFamily.black,
                        style: TextStyleFamily.normalTextStyle,
                        maxLines: 1,
                        maxLength: 20,
                        decoration: const InputDecoration(
                          hintText: "한 줄로 작성해주세요!",
                          hintStyle: TextStyleFamily.hintTextStyle,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: ColorFamily.black),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: ColorFamily.black),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      // 날짜 표시 방법
                      Container(
                        width: MediaQuery.of(context).size.width - 40,
                        decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                        child: Card(
                          color: ColorFamily.white,
                          elevation: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: provider.selectedDay != null
                                    ? provider.isChecked[0] // 날짜 세기
                                      ? provider.selectedDay!.difference(_today()).inDays <= 0
                                          ?Text("${(provider.selectedDay!.difference(_today()).inDays).abs()}일째", style: exampleTextStyle)
                                          :Text("시작 날짜를\n선택해주세요.", style: exampleErrorTextStyle, textAlign: TextAlign.center,)
                                      // d-day
                                      : provider.selectedDay!.difference(_today()).inDays >= 0
                                        ? provider.selectedDay!.difference(_today()).inDays == 0
                                          ? Text("D-day", style: exampleTextStyle)
                                          : Text("D-${(provider.selectedDay!.difference(_today()).inDays).abs()}", style: exampleTextStyle,)
                                        : Text("디데이 날짜를\n선택해주세요.", style: exampleErrorTextStyle, textAlign: TextAlign.center,)
                                    // 날짜를 선택하지 않은 경우
                                    : provider.isChecked[0]
                                        // 날짜 세기
                                        ? Text("${(provider.focusedDay.difference(_today()).inDays).abs()}일째", style: exampleTextStyle)
                                        // d-day
                                        : Text("D-day", style: exampleTextStyle)
                                  ),
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      width: (MediaQuery.of(context).size.width -
                                          40 -
                                          40) *
                                          0.5,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          const Text(
                                            "날짜세기",
                                            style: TextStyleFamily
                                                .dialogButtonTextStyle,
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Checkbox(
                                              side: const BorderSide(
                                                  color: ColorFamily.gray),
                                              activeColor: ColorFamily.pink,
                                              checkColor: ColorFamily.white,
                                              value: provider.isChecked[0],
                                              onChanged: (value) {
                                                if(value!){
                                                  provider.checkedChange();
                                                }
                                              })
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: (MediaQuery.of(context).size.width -
                                          40 -
                                          40) *
                                          0.5,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          const Text(
                                            "디데이",
                                            style: TextStyleFamily
                                                .dialogButtonTextStyle,
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Checkbox(
                                              side: const BorderSide(
                                                  color: ColorFamily.gray),
                                              activeColor: ColorFamily.pink,
                                              checkColor: ColorFamily.white,
                                              value: provider.isChecked[1],
                                              onChanged: (value) {
                                                if(value!){
                                                  provider.checkedChange();
                                                }
                                              })
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox (
                        height: 20,
                      ),

                      // 캘린더
                      
                      Wrap(
                        children: [
                          Card(
                            elevation: 1,
                            child: Stack(
                              children: [
                                SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.5,
                                  child: TableCalendar(
                                    locale: 'ko_KR',  // main 에서 받음
                                    firstDay: DateTime.utc(2000, 1, 1), // 최소 날짜
                                    lastDay: DateTime.utc(2999, 12, 31),  // 최대 날짜
                                    focusedDay: provider.focusedDay,  // 현재
                                    rowHeight: MediaQuery.of(context).size.height * 0.055,
                                    availableGestures: AvailableGestures.horizontalSwipe,
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
                                          //color: Colors.blue,
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
                                              style: TextStyleFamily.hintTextStyle
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
                                              style: TextStyleFamily.hintTextStyle
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
                                                  fontFamily: FontFamily.mapleStoryLight,
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
                                    ),
                                    // 선택된 날짜
                                    selectedDayPredicate: (day) {
                                      return isSameDay(provider.selectedDay, day);
                                    },
                                    // 날짜 선택
                                    onDaySelected: (selectedDay, focusedDay) {
                                      setState(() {
                                        provider.setSelectedDay(selectedDay);
                                        provider.setfocusedDay(focusedDay);
                                      });
                                    },
                                    // 화면이 바뀔때
                                    onPageChanged: (focusedDay) {
                                      provider.setfocusedDay(focusedDay);
                                    },
                                  ),
                                ),
                                Positioned(
                                  left: 20,
                                  right: 20,
                                  bottom: 20,
                                  child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: ColorFamily.beige),
                                  onPressed: () {
                                    provider.setSelectedDay(DateTime.now());
                                    provider.setfocusedDay(DateTime.now());
                                  },
                                  child: const Text(
                                    "오늘 날짜로",
                                    style: TextStyleFamily.normalTextStyle,
                                  )),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }

  // 주말인지
  bool isWeekend(DateTime day){
    return day.weekday == DateTime.sunday;
  }

  // 토요일인지
  bool isSaturday(DateTime day){
    return day.weekday == DateTime.saturday;
  }

  // 날짜 계산용 오늘 날짜
  DateTime _today(){
    final now = DateTime.now();
      return DateTime(now.year, now.month, now.day);
  }
}

TextStyle exampleTextStyle = const TextStyle(
    fontFamily: FontFamily.mapleStoryBold,
    fontSize: 20,
    color: ColorFamily.pink);

TextStyle exampleErrorTextStyle = const TextStyle(
    fontFamily: FontFamily.mapleStoryBold,
    fontSize: 12,
    color: ColorFamily.pink);
