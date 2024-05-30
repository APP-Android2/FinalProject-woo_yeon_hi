import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/text_style.dart';

import '../style/font.dart';

class CalendarTermStart extends StatefulWidget {
  final Function(DateTime) onDateChanged;
  final DateTime initialDate; // 초기 날짜
  final bool isTrue;

  const CalendarTermStart({
    required this.onDateChanged,
    required this.initialDate,
    required this.isTrue,
    super.key
  });

  @override
  State<CalendarTermStart> createState() => _CalendarTermStartState();
}

class _CalendarTermStartState extends State<CalendarTermStart> {

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
    return Column(
      children: [
        widget.isTrue
        ? InkWell(
          onTap: () {
            DatePicker.showDatePicker(
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
          child: Container(
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
              "${DateFormat('yyyy. M. dd.(E) 하루 종일', 'ko_KR').format(selectedDateTime)}",
              style: TextStyleFamily.normalTextStyle,
            ),
          ),
        )
        : InkWell(
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
          child: Container(
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
              style: TextStyleFamily.normalTextStyle,
            ),
          ),
        ),
      ],
    );
  }
}