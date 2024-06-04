import 'package:flutter/material.dart';
import 'package:woo_yeon_hi/style/color.dart';

class CalendarSwitch extends StatefulWidget {
  final Function(bool) onSwitchChanged; // 스위치의 값을 변경할 함수
  const CalendarSwitch({required this.onSwitchChanged, super.key});

  @override
  State<CalendarSwitch> createState() => _CalendarSwitchState();
}

class _CalendarSwitchState extends State<CalendarSwitch> {

  bool isTrue = false;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: isTrue,
      activeColor: ColorFamily.pink,
      onChanged: (value) {
        setState(() {
          isTrue = !isTrue;
          widget.onSwitchChanged(isTrue);
        });
      },
    );
  }
}
