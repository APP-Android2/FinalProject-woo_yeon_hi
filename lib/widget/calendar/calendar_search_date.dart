import 'package:flutter/material.dart';

class CalendarSearchDate extends StatefulWidget {
  const CalendarSearchDate({super.key});

  @override
  State<CalendarSearchDate> createState() => _CalendarSearchDateState();
}

class _CalendarSearchDateState extends State<CalendarSearchDate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("달력 검색 화면"),
      ),
    );
  }
}
