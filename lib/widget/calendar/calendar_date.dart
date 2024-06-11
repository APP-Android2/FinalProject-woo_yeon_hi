import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:woo_yeon_hi/dao/diary_dao.dart';
import 'package:woo_yeon_hi/dao/schedule_dao.dart';
import 'package:woo_yeon_hi/model/schedule_model.dart';
import 'package:woo_yeon_hi/provider/schedule_provider.dart';
import 'package:woo_yeon_hi/screen/calendar/calendar_detail_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/style/text_style.dart';

class CalendarDate extends StatefulWidget {
  List<Map<String, dynamic>> scheduleData;
  CalendarDate(this.scheduleData, {super.key});

  @override
  State<CalendarDate> createState() => _CalendarDateState();
}

class _CalendarDateState extends State<CalendarDate> {

  List<String> scheduleTitle = [];  // 일정 제목
  List<String> scheduleStartTime = [];  // 일정 시작 시간
  List<String> scheduleFinishTime = []; // 일정 종료 시간

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

    scheduleTitle.clear();
    scheduleStartTime.clear();
    scheduleFinishTime.clear();

    for(var map in widget.scheduleData){
      scheduleTitle.add(map['schedule_title']);
      scheduleStartTime.add(map['schedule_start_time']);
      scheduleFinishTime.add(map['schedule_finish_time']);
    }

    return Expanded(
      child: Column(
        children: [
          const SizedBox(height: 10),
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
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: TableCalendar(
                    locale: 'ko_KR',  // main 에서 받음
                    firstDay: DateTime.utc(2024, 1, 1), // 최소 날짜
                    lastDay: DateTime.utc(2999, 12, 31),  // 최대 날짜
                    focusedDay: _focusedDay,  // 현재
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
                      // 마커
                      markerBuilder: (context, day, events) {
                        return FutureBuilder<bool>(
                          future: isExistOnSchedule(day),
                          builder: (context, snapshot) {
                            if(snapshot.hasData == false){
                              return const SizedBox();
                            } else if(snapshot.hasError){
                              return const SizedBox();
                            } else {
                              if(snapshot.data == true){
                                return Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.only(top: 20),
                                  child: Container(
                                    width: 6, height: 6,
                                    decoration: BoxDecoration(
                                        color: (day == _selectedDay)
                                            ? ColorFamily.white
                                            : ColorFamily.pink,
                                        shape: BoxShape.circle
                                    ),
                                  ),
                                );
                              } else {
                                return const SizedBox();
                              }
                            }
                          },
                        );
                      },
                    ),
                    // 선택된 날짜
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    // 날짜 선택
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    },
                    // 화면이 바뀔때
                    onPageChanged: (focusedDay) {
                      _focusedDay = focusedDay;
                    },
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
                child: widget.scheduleData.isEmpty
                    ? const Center(
                        child: Text("일정이 없습니다", style: TextStyleFamily.hintTextStyle),
                      )
                    : ListView.separated(
                        itemCount: widget.scheduleData.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: index == 0
                                ? const EdgeInsets.fromLTRB(20, 10, 20, 0)
                                : const EdgeInsets.symmetric(horizontal: 20),
                            child: InkWell(
                              onTap: () {
                                // 항목 클릭
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => CalendarDetailScreen(widget.scheduleData[index]))
                                );
                              },
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8),
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
                                  const SizedBox(width: 10),
                                  Text(
                                    scheduleTitle[index],
                                    style: TextStyleFamily.normalTextStyle,
                                  ),
                                  const Spacer(),
                                  Text(
                                    "${scheduleStartTime[index]} ~ ${scheduleFinishTime[index]}",
                                    style: TextStyleFamily.normalTextStyle,
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Divider(color: ColorFamily.gray),
                          );
                        },
                    ),
              ),
            ),
          )
        ],
      ),
    );
  }
}