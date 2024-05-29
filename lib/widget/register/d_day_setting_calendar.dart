import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:woo_yeon_hi/style/color.dart';
import '../../style/font.dart';
import '../../style/text_style.dart';

class DdaySettingCalendar extends StatefulWidget {
  const DdaySettingCalendar({super.key});

  @override
  State<DdaySettingCalendar> createState() => _DdaySettingCalendarState();
}

class _DdaySettingCalendarState extends State<DdaySettingCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

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
          // leftChevronMargin: EdgeInsets.only(left: 75),
          // rightChevronMargin: EdgeInsets.only(right: 75)
        ),
        daysOfWeekHeight:40,
        daysOfWeekStyle: DaysOfWeekStyle(
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
                            ? ColorFamily.white
                            : ColorFamily.black,
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
        ),
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) {
          // Use `selectedDayPredicate` to determine which day is currently selected.
          // If this returns true, then `day` will be marked as selected.

          // Using `isSameDay` is recommended to disregard
          // the time-part of compared DateTime objects.
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(_selectedDay, selectedDay)) {
            // Call `setState()` when updating the selected day
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
