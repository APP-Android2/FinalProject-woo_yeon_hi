import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:woo_yeon_hi/style/color.dart';
import '../../style/font.dart';
import '../../style/text_style.dart';

class DailySummaryCalendar extends StatefulWidget {
  const DailySummaryCalendar({super.key});

  @override
  State<DailySummaryCalendar> createState() => _DailySummaryCalendarState();
}

class _DailySummaryCalendarState extends State<DailySummaryCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  var summaryIndex = true;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  bool isHoliday(DateTime day) {
    return day.weekday == DateTime.sunday;
  }

  bool isSaturday(DateTime day) {
    return day.weekday == DateTime.saturday;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 415,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: ColorFamily.white),
      child: TableCalendar(
        firstDay: DateTime.utc(2010, 1, 1),
        lastDay: DateTime.now(),
        focusedDay: _focusedDay,
        rowHeight: 50,
        locale: 'ko_kr',
        currentDay: DateTime.now(),
        availableGestures: AvailableGestures.horizontalSwipe,
        headerStyle: HeaderStyle(
          titleCentered: true,
          titleTextStyle: TextStyleFamily.appBarTitleBoldTextStyle,
          formatButtonVisible: false,
          leftChevronIcon: SvgPicture.asset('lib/assets/icons/arrow_left.svg'),
          rightChevronIcon: SvgPicture.asset('lib/assets/icons/arrow_right.svg'),
        ),
        daysOfWeekHeight:40,
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
                      color: isHoliday(day)
                          ? Colors.red
                          : isSaturday(day)
                          ? Colors.blueAccent
                          : ColorFamily.black,
                      fontFamily: FontFamily.mapleStoryLight),
                ),
              );
            },
            outsideBuilder: (context, day, focusedDay) {
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
            },
            disabledBuilder: (context, day, focusedDay) {
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
            },
            selectedBuilder: (context, day, focusedDay) {
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
                          color: isHoliday(day)
                              ? Colors.red
                              : isSaturday(day)?Colors.blueAccent :ColorFamily.black,
                          fontFamily: FontFamily.mapleStoryLight),
                    ),
                  ),
                ),
              );
            },
            todayBuilder: (context, day, focusedDay) {
              return Container(
                alignment: Alignment.topCenter,
                child: Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    DateFormat('d').format(day),
                    style: const TextStyle(
                        color: ColorFamily.pink,
                        fontFamily: FontFamily.mapleStoryLight,
                        fontSize: 15),
                  ),
                ),
              );
            },
            markerBuilder: (context, day, events){
              var _toDay = "${DateTime.now().toIso8601String().substring(0, 10)} 00:00:00.000Z";
              return Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                      color: (day == _selectedDay || day.toString() == _toDay)
                          ? ColorFamily.white
                          : ColorFamily.pink,
                      shape: BoxShape.circle
                  ),
                ),
              );
            }
        ),
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(_selectedDay, selectedDay)) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          }
        },
        onFormatChanged: (format) {
          if (_calendarFormat != format) {
            // Call `setState()` when updating calendar format
            setState(() {
              _calendarFormat = format;
            });
          }
        },
        onPageChanged: (focusedDay) {
          // No need to call `setState()` here
          _focusedDay = focusedDay;
        },
      ),
    );
  }
}