import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';

import '../style/font.dart';

class CalendarTermFinish extends StatefulWidget {
  final Function(DateTime) onDateChanged;
  final TextDecoration textDecoration;
  final DateTime initialDate; // 초기 날짜

  const CalendarTermFinish({
    required this.onDateChanged,
    required this.textDecoration,
    required this.initialDate,
    super.key
  });

  @override
  State<CalendarTermFinish> createState() => _CalendarTermFinishState();
}

class _CalendarTermFinishState extends State<CalendarTermFinish> {

  // 선택한 날짜 시간
  late DateTime selectedDateTime;

  @override
  void initState(){
    super.initState();

    // 현재 시간으로
    selectedDateTime = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        DatePicker.showDateTimePicker(
          context,
          showTitleActions: true,
          onConfirm: (time) {
            setState(() {
              selectedDateTime = time;
              // 부모 위젯에게 전달
              widget.onDateChanged(selectedDateTime);
            });
          },
          currentTime: DateTime.now(),
          locale: LocaleType.ko,
        );
      },
      child: Text(
        "${selectedDateTime.year}. "
        "${selectedDateTime.month}. "
        "${selectedDateTime.day}."
        "(${DateFormat('E', 'ko_KR').format(selectedDateTime)}) "
        "${selectedDateTime.hour}:${selectedDateTime.minute.toString().padLeft(2, '0')}",
        style: TextStyle(
          fontSize: 14,
          fontFamily: FontFamily.mapleStoryLight,
          // 부모 위젯
          decoration: widget.textDecoration,
        ),
      ),
    );
  }
}
