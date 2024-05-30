import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/text_style.dart';
import 'package:woo_yeon_hi/widget/more/daily_summary_calendar.dart';
import 'package:woo_yeon_hi/widget/more/daily_summary_top_app_bar.dart';

import '../../style/font.dart';

class DailySummaryScreen extends StatefulWidget {
  const DailySummaryScreen({super.key});

  @override
  State<DailySummaryScreen> createState() => _DailySummaryScreenState();
}

class _DailySummaryScreenState extends State<DailySummaryScreen> {

  DateTime _summaryDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  var summaryIndex = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DailySummaryTopAppBar(),
      body: Container(
        color: ColorFamily.cream,
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      child: IconButton(onPressed: () {},
                          icon: SvgPicture.asset(
                              "lib/assets/icons/arrow_left.svg"))),
                  Material(
                      color: ColorFamily.cream,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        onTap: () {
                          showMaterialModalBottomSheet(
                              backgroundColor: ColorFamily.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      topLeft: Radius.circular(20))),
                              context: context,
                              builder: (context) =>
                                  Container(
                                      height: 420,
                                      child: Column(children: [
                                        Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            height: 360,
                                            child: DailySummaryCalendar()
                                        ),
                                        Material(
                                          color: ColorFamily.beige,
                                          elevation: 0.5,
                                          shadowColor: Colors.black,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(
                                                20.0),
                                          ),
                                          child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  _summaryDay = _selectedDay!;
                                                });
                                                Navigator.pop(context);
                                              },
                                              borderRadius:
                                              BorderRadius.circular(
                                                  20.0),
                                              child: Container(
                                                  width: 380,
                                                  height: 40,
                                                  child: Container(
                                                    alignment: Alignment
                                                        .center,
                                                    child: Text(
                                                      "확인",
                                                      style: TextStyleFamily
                                                          .normalTextStyle,
                                                    ),
                                                  ))),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(top: 20))
                                      ])));
                        },
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                  child: Container(
                                    child: Text(
                                        textAlign:
                                        TextAlign.center,
                                        DateFormat('yyyy. M. d.')
                                            .format(
                                            _summaryDay),
                                        style: TextStyleFamily.normalTextStyle
                                    ),
                                  )),
                              Container(
                                  height: 5,
                                  width: 100,
                                  child: Divider(
                                    color: ColorFamily.black,
                                    thickness: 0.5,
                                  ))
                            ],
                          ),
                        ),
                      )),
                  Container(
                      child: IconButton(onPressed: () {},
                          icon: SvgPicture.asset(
                              "lib/assets/icons/arrow_right.svg"))),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 10),
                  children: [
                    Material(
                      elevation: 3,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
                        width: 350,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: ColorFamily.white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(shape: BoxShape.circle, color: DotsColor.scarlet),
                                ),
                                SizedBox(width: 10),
                                Container(
                                  child: Text("디데이",style: TextStyleFamily.smallTitleTextStyle),
                                )
                              ],
                            ),
                            SizedBox(height: 10),
                            Container(
                              padding: EdgeInsets.only(left: 20),
                              // 데이터가 없을 때
                              child: Text("이벤트가 없습니다.",style: TextStyleFamily.normalTextStyle)
                              // 데이터가 있을 때
                              // child: 해당 데이터 위젯
                            ),
                            SizedBox(height: 30),

                            Row(
                              children: [
                                Container(
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(shape: BoxShape.circle, color: DotsColor.brown),
                                ),
                                SizedBox(width: 10),
                                Container(
                                  child: Text("캘린더",style: TextStyleFamily.smallTitleTextStyle),
                                )
                              ],
                            ),
                            SizedBox(height: 10),
                            Container(
                              padding: EdgeInsets.only(left: 20),
                              // 데이터가 없을 때
                              child: Text("이벤트가 없습니다.",style: TextStyleFamily.normalTextStyle),
                              // 데이터가 있을 때
                              // child: 해당 데이터 위젯
                            ),
                            SizedBox(height: 30),

                            Row(
                              children: [
                                Container(
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(shape: BoxShape.circle, color: DotsColor.pastelYellow),
                                ),
                                SizedBox(width: 10),
                                Container(
                                  child: Text("가계부",style: TextStyleFamily.smallTitleTextStyle),
                                )
                              ],
                            ),
                            SizedBox(height: 10),
                            Container(
                              padding: EdgeInsets.only(left: 20),
                              // 데이터가 없을 때
                              child: Text("이벤트가 없습니다.",style: TextStyleFamily.normalTextStyle),
                              // 데이터가 있을 때
                              // child: 해당 데이터 위젯
                            ),
                            SizedBox(height: 30),

                            Row(
                              children: [
                                Container(
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(shape: BoxShape.circle, color: DotsColor.cyan),
                                ),
                                SizedBox(width: 10),
                                Container(
                                  child: Text("일기",style: TextStyleFamily.smallTitleTextStyle),
                                )
                              ],
                            ),
                            SizedBox(height: 10),
                            Container(
                              padding: EdgeInsets.only(left: 20),
                              // 데이터가 없을 때
                              child: Text("이벤트가 없습니다.",style: TextStyleFamily.normalTextStyle),
                              // 데이터가 있을 때
                              // child: 해당 데이터 위젯
                            ),
                            SizedBox(height: 30),

                            Row(
                              children: [
                                Container(
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(shape: BoxShape.circle, color: DotsColor.pastelPink),
                                ),
                                SizedBox(width: 10),
                                Container(
                                  child: Text("발자국",style: TextStyleFamily.smallTitleTextStyle),
                                )
                              ],
                            ),
                            SizedBox(height: 10),
                            Container(
                              padding: EdgeInsets.only(left: 20),
                              // 데이터가 없을 때
                              child: Text("이벤트가 없습니다.",style: TextStyleFamily.normalTextStyle),
                              // 데이터가 있을 때
                              // child: 해당 데이터 위젯
                            ),
                            SizedBox(height: 30),

                            Row(
                              children: [
                                Container(
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(shape: BoxShape.circle, color: DotsColor.green),
                                ),
                                SizedBox(width: 10),
                                Container(
                                  child: Text("데이트 플랜",style: TextStyleFamily.smallTitleTextStyle),
                                )
                              ],
                            ),
                            SizedBox(height: 10),
                            Container(
                              padding: EdgeInsets.only(left: 20),
                              // 데이터가 없을 때
                              child: Text("이벤트가 없습니다.",style: TextStyleFamily.normalTextStyle),
                              // 데이터가 있을 때
                              // child: 해당 데이터 위젯
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30)
                  ]
              ),
            )
          ],
        ),
      ),
    );
  }
}