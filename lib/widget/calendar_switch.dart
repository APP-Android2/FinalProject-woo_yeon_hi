import 'package:flutter/material.dart';
import 'package:woo_yeon_hi/style/color.dart';

class CalendarSwitch extends StatefulWidget {
  const CalendarSwitch({super.key});

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
          isTrue = value;
        });
      },
    );
  }
}
