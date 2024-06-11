import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:woo_yeon_hi/screen/calendar/calendar_detail_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/style/text_style.dart';

class CalendarList extends StatefulWidget {
  List<Map<String, dynamic>> scheduleData;
  CalendarList(this.scheduleData, {super.key});

  @override
  State<CalendarList> createState() => _CalendarListState();
}

class _CalendarListState extends State<CalendarList> {

  List<String> scheduleTitle = [];  // 일정 제목
  List<String> scheduleStartTime = [];  // 일정 시작 시간
  List<String> scheduleFinishTime = []; // 일정 종료 시간
  List<String> scheduleStartDate = [];  // 일정 시작 날짜
  List<String> scheduleFinishDate = []; // 일정 종료 날짜
  
  @override
  Widget build(BuildContext context) {

    scheduleTitle.clear();
    scheduleStartTime.clear();
    scheduleFinishTime.clear();
    scheduleStartDate.clear();
    
    for(var map in widget.scheduleData){
      scheduleTitle.add(map['schedule_title']);
      scheduleStartTime.add(map['schedule_start_time']);
      scheduleFinishTime.add(map['schedule_finish_time']);
      scheduleStartDate.add(map['schedule_start_date']);
      scheduleStartDate.add(map['schedule_finish_date']);
    }
    
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(top: 10),
        child: widget.scheduleData.isEmpty
            ? const Center(
                child: Text("일정이 없습니다", style: TextStyleFamily.hintTextStyle),
              )
            : ListView.builder(
                itemCount: widget.scheduleData.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          scheduleStartDate[index],
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: FontFamily.mapleStoryLight,
                            color: ColorFamily.black,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Divider(color: ColorFamily.gray),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => CalendarDetailScreen(widget.scheduleData[index]))
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
                              const SizedBox(width: 10),
                              Text(
                                scheduleTitle[index],
                                style: TextStyleFamily.normalTextStyle,
                              ),
                              Spacer(),
                              Text(
                                  "${scheduleStartTime[index]} ~ ${scheduleFinishTime[index]}",
                                  style: TextStyleFamily.normalTextStyle
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  );
                },
            ),
      ),
    );
  }
}

