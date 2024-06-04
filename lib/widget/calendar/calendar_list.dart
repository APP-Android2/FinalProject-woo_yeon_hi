import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:woo_yeon_hi/screen/calendar/calendar_detail_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/style/text_style.dart';

class CalendarList extends StatefulWidget {
  const CalendarList({super.key});

  @override
  State<CalendarList> createState() => _CalendarListState();
}

class _CalendarListState extends State<CalendarList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(top: 10),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "2024. 5. 23.(목)",
                    style: TextStyle(
                      fontSize: 13,
                      fontFamily: FontFamily.mapleStoryLight,
                      color: ColorFamily.black,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Divider(color: ColorFamily.gray,),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CalendarDetailScreen())
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        SizedBox(
                            width: 5, height: 35,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: ColorFamily.green
                              ),
                            )
                        ),
                        SizedBox(width: 10),
                        Text(
                          "한강 피크닉 $index",
                          style: TextStyleFamily.normalTextStyle,
                        ),
                        Spacer(),
                        Text(
                            "09:30 ~ 13:00",
                            style: TextStyleFamily.normalTextStyle
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
              ],
            );
          },
        ),
      ),
    );
  }
}

