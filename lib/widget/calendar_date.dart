import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:woo_yeon_hi/screen/calendar_detail_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/style/text_style.dart';

class CalendarDate extends StatefulWidget {
  const CalendarDate({super.key});

  @override
  State<CalendarDate> createState() => _CalendarDateState();
}

class _CalendarDateState extends State<CalendarDate> {

  DateTime _focusedDay = DateTime.now();  // 오늘 날짜
  DateTime _selectedDay = DateTime(   // 선택된 날짜
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  List<bool> test = [false];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            //  달력 위젯
            child: Card(
              elevation: 4,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorFamily.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: TableCalendar(
                    locale: 'ko_KR',  // main 에서 받음
                    firstDay: DateTime.utc(1900, 1, 1), // 최소 날짜
                    lastDay: DateTime.utc(2999, 12, 31),  // 최대 날짜
                    focusedDay: _focusedDay,  // 현재
                    onDaySelected: (selectedDay, focusedDay) {  // 선택된 날짜
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    },
                    selectedDayPredicate: (day) { // 선택된 날짜
                      return isSameDay(_selectedDay, day);
                    },
                    // 캘린더 헤더
                    headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      titleTextStyle: TextStyle(
                        fontSize: 15,
                        fontFamily: FontFamily.mapleStoryBold,
                        color: ColorFamily.black,
                      ),
                    ),
                    // 마크 표시는 마크는 eventLoader 를 사용하여 표시한다.
                    calendarStyle: CalendarStyle(
                      markersMaxCount: 1, // 마크 개수
                      markerDecoration: BoxDecoration(
                        color: ColorFamily.pink,
                        shape: BoxShape.circle,
                      ),
                      isTodayHighlighted: false,  // 오늘 표시 여부
                      // 선택된 날짜
                      selectedDecoration: BoxDecoration(
                        color: ColorFamily.pink,
                        shape: BoxShape.circle,
                      )
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            // 일별 일정 리스트
            child: Padding(
              padding: EdgeInsets.only(top: 15),
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: ListView.separated(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: InkWell(
                          onTap: () {
                            // 항목 클릭
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => CalendarDetailScreen())
                            );
                          },
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: SizedBox(
                                  width: 5, height: 35,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: ColorFamily.green,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                "롯데월드 $index",
                                style: TextStyleFamily.normalTextStyle,
                              ),
                              Spacer(),
                              Text(
                                "10:00 ~ 12:00",
                                style: TextStyleFamily.normalTextStyle,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Divider(),
                      );
                    },
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
