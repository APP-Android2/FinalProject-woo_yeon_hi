import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:woo_yeon_hi/screen/calendar_add_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/style/text_style.dart';
import 'package:woo_yeon_hi/widget/calendar_date.dart';

import '../widget/calendar_list.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {

  // 참 거짓으로 상태를 나눔
  bool _isCalendar = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        scrolledUnderElevation: 0,
        title: Text(
          "캘린더",
          style: TextStyleFamily.appBarTitleBoldTextStyle
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset("lib/assets/icons/arrow_back.svg"),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      _isCalendar = !_isCalendar;
                    });
                  },
                  child: _isCalendar
                    ? SvgPicture.asset("lib/assets/icons/list.svg")
                    : SvgPicture.asset("lib/assets/icons/calendar.svg"),
                ),
                const SizedBox(width: 10),
                SvgPicture.asset("lib/assets/icons/search.svg"),
                const SizedBox(width: 5),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CalendarAddScreen())
                    );
                  },
                  child: SvgPicture.asset("lib/assets/icons/add.svg"),
                ),
              ],
            ),
          ),
          _isCalendar ? CalendarDate() : CalendarList(),
        ],
      )
    );
  }
}
