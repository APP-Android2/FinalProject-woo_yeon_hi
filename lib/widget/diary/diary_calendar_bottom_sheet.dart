import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../dao/diary_dao.dart';
import '../../provider/diary_provider.dart';
import '../../style/color.dart';
import '../../style/font.dart';
import '../../style/text_style.dart';
import '../../utils.dart';

bool isSaturday(DateTime day) {
  return day.weekday == DateTime.saturday;
}

bool isWeekend(DateTime day) {
  return day.weekday == DateTime.sunday;
}

void showCalendarBottomSheet(
    BuildContext context, String flag, DiaryProvider provider) {
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();

  showModalBottomSheet(
      context: context,
      backgroundColor: ColorFamily.white,
      builder: (context) {
        return StatefulBuilder(builder: (context, bottomState) {
          return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.6,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Stack(
                  children: [
                    TableCalendar(
                      firstDay: DateTime.utc(2024, 3, 16),
                      lastDay: DateTime.utc(2024, 8, 14),
                      focusedDay: _focusedDay,
                      locale: 'ko_kr',
                      rowHeight: 50,
                      headerStyle: const HeaderStyle(
                        titleCentered: true,
                        titleTextStyle:
                            TextStyleFamily.appBarTitleBoldTextStyle,
                        formatButtonVisible: false,
                      ),
                      daysOfWeekStyle: const DaysOfWeekStyle(
                          weekdayStyle: TextStyleFamily.normalTextStyle,
                          weekendStyle: TextStyleFamily.normalTextStyle),
                      calendarBuilders: CalendarBuilders(
                          defaultBuilder: (context, day, focusedDay) {
                        return Container(
                          alignment: Alignment.topCenter,
                          padding: const EdgeInsets.only(top: 15),
                          child: Text(
                            textAlign: TextAlign.center,
                            DateFormat('d').format(day),
                            style: TextStyle(
                                color: isWeekend(day)
                                    ? Colors.red
                                    : isSaturday(day)
                                        ? Colors.blueAccent
                                        : ColorFamily.black,
                                fontFamily: FontFamily.mapleStoryLight),
                          ),
                        );
                      }, outsideBuilder: (context, day, focusedDay) {
                        return Container(
                          alignment: Alignment.topCenter,
                          padding: const EdgeInsets.only(top: 15),
                          child: Text(
                            textAlign: TextAlign.center,
                            DateFormat('d').format(day),
                            style: const TextStyle(
                                color: ColorFamily.gray,
                                fontFamily: FontFamily.mapleStoryLight),
                          ),
                        );
                      }, disabledBuilder: (context, day, focusedDay) {
                        return Container(
                          alignment: Alignment.topCenter,
                          padding: const EdgeInsets.only(top: 15),
                          child: Text(
                            textAlign: TextAlign.center,
                            DateFormat('d').format(day),
                            style: const TextStyle(
                                color: ColorFamily.gray,
                                fontFamily: FontFamily.mapleStoryLight),
                          ),
                        );
                      }, selectedBuilder: (context, day, focusedDay) {
                        return Container(
                          alignment: Alignment.topCenter,
                          padding: const EdgeInsets.only(top: 10),
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: const BoxDecoration(
                              color: ColorFamily.pink,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                textAlign: TextAlign.center,
                                DateFormat('d').format(day),
                                style: TextStyle(
                                    color: isWeekend(day)
                                        ? ColorFamily.white
                                        : isSaturday(day)
                                            ? ColorFamily.white
                                            : ColorFamily.black,
                                    fontFamily: FontFamily.mapleStoryLight),
                              ),
                            ),
                          ),
                        );
                      }, todayBuilder: (context, day, focusedDay) {
                        return Container(
                          alignment: Alignment.topCenter,
                          padding: const EdgeInsets.only(top: 15),
                          child: Text(
                            textAlign: TextAlign.center,
                            DateFormat('d').format(day),
                            style: const TextStyle(
                                color: ColorFamily.pink,
                                fontFamily: FontFamily.mapleStoryLight),
                          ),
                        );
                      }, markerBuilder: (context, day, events) {
                        return FutureBuilder(
                          future: isExistOnDate(day),
                          builder: (context, snapshot){
                            if(snapshot.hasData == false){
                              return const SizedBox();
                            }else if(snapshot.hasError){
                              return const SizedBox();
                            }else{
                              if(snapshot.data == true){
                                return Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Container(
                                    width: 6,
                                    height: 6,
                                    decoration: BoxDecoration(
                                        color: (day == _selectedDay)
                                            ? ColorFamily.white
                                            : ColorFamily.pink,
                                        shape: BoxShape.circle),
                                  ),
                                );
                              }else{
                                return const SizedBox();
                              }
                            }
                          },
                        );
                      }),
                      selectedDayPredicate: (day) {
                        return isSameDay(_selectedDay, day);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        bottomState(() {
                          _selectedDay = selectedDay;
                          _focusedDay =
                              focusedDay; // update `_focusedDay` here as well
                        });
                      },
                      onPageChanged: (focusedDay) {
                        _focusedDay = focusedDay;
                      },
                    ),
                    // 이벤트 버튼들
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 20,
                      child: Row(
                        children: [
                          SizedBox(
                            width:
                                ((MediaQuery.of(context).size.width - 40) / 2) -
                                    10,
                            height: 40,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorFamily.white,
                                    surfaceTintColor: ColorFamily.white),
                                onPressed: () {
                                  bottomState(() {
                                    _focusedDay = DateTime.now();
                                  });
                                },
                                child: const Text(
                                  "오늘 날짜로",
                                  style: TextStyleFamily.normalTextStyle,
                                )),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            width:
                                ((MediaQuery.of(context).size.width - 40) / 2) -
                                    10,
                            height: 40,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorFamily.beige,
                                    surfaceTintColor: ColorFamily.beige),
                                onPressed: () {
                                  if (_selectedDay != null) {
                                    String formattedDate =
                                        dateToString(_selectedDay!);
                                    if (flag == "start") {
                                      provider.setStartPeriod(formattedDate);
                                      provider.setStartControllerText(
                                          formattedDate);
                                      Navigator.pop(context, "start");
                                    } else {
                                      provider.setEndPeriod(formattedDate);
                                      provider
                                          .setEndControllerText(formattedDate);
                                      Navigator.pop(context, "end");
                                    }
                                  } else {
                                    String formattedDate =
                                        dateToString(_focusedDay);
                                    if (flag == "start") {
                                      provider.setStartPeriod(formattedDate);
                                      provider.setStartControllerText(
                                          formattedDate);
                                      Navigator.pop(context, "start");
                                    } else {
                                      provider.setEndPeriod(formattedDate);
                                      provider
                                          .setEndControllerText(formattedDate);
                                      Navigator.pop(context, "end");
                                    }
                                  }
                                },
                                child: const Text(
                                  "확인",
                                  style: TextStyleFamily.normalTextStyle,
                                )),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ));
        });
      });
}
