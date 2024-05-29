import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';

import '../style/color.dart';
import '../style/font.dart';

class CalendarTermFinish extends StatefulWidget {
  final Function(DateTime) onDateChanged;
  final TextDecoration textDecoration;
  final DateTime initialDate; // 초기 날짜
  final bool checkTerm;

  const CalendarTermFinish({
    required this.onDateChanged,
    required this.textDecoration,
    required this.initialDate,
    required this.checkTerm,
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
      child: widget.checkTerm
      ? Container(
        padding: EdgeInsets.only(bottom: 1),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: ColorFamily.black,
              width: 1
            )
          )
        ),
        child: Text(
          "${DateFormat('yyyy. M. dd.(E) HH:mm', 'ko_KR').format(selectedDateTime)}",
          style: TextStyle(
            fontSize: 14,
            fontFamily: FontFamily.mapleStoryLight,
            color: ColorFamily.black,
            // 부모 위젯
            decoration: widget.textDecoration,
          ),
        ),
      )
      : Text(
        "${DateFormat('yyyy. M. dd.(E) HH:mm', 'ko_KR').format(selectedDateTime)}",
        style: TextStyle(
          fontSize: 14,
          fontFamily: FontFamily.mapleStoryLight,
          color: ColorFamily.black,
          // 부모 위젯
          decoration: widget.textDecoration,
        ),
      ),
    );
  }
}
