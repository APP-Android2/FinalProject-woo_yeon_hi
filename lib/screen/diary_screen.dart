import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:woo_yeon_hi/screen/diary_edit_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/text_style.dart';
import 'package:woo_yeon_hi/widget/diary_filter_list_view.dart';
import 'package:woo_yeon_hi/widget/diary_grid_view.dart';
import 'package:woo_yeon_hi/widget/diary_top_app_bar.dart';

import '../style/font.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  List<String> editorType = ["전체", "나", "상대방"];
  String startPeriod = "";
  String endPeriod = "";
  TextEditingController startPeriodController = TextEditingController(text: "");
  TextEditingController endPeriodController = TextEditingController(text: "");
  List<String> sortType = ["최신순", "오래된순"];

  List<bool> isSelected_editor = [true, false, false];
  List<bool> isSelected_sort = [true, false];

  List<String> filterList = ["전체", "최신순"];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: ColorFamily.cream,
      appBar: const DiaryTopAppBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorFamily.beige,
        shape: const CircleBorder(),
        child: SvgPicture.asset('lib/assets/icons/edit.svg'),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => const DiaryEditScreen(),
            )
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(
          children: [
            SizedBox(
              height: 48,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _showModalBottomSheet();
                      });
                    },
                    icon: SvgPicture.asset(
                      'lib/assets/icons/Filter_alt_fill.svg',
                      width: 24,
                      height: 24,
                    ),
                    iconSize: 24,
                  ),
                  Expanded(child: DiaryFilterListView(filterList))
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(child: DiaryGridView()),
          ],
        ),
      ),
    );
  }
  bool isSaturday(DateTime day) {
    return day.weekday == DateTime.saturday;
  }

  bool isWeekend(DateTime day) {
    return day.weekday == DateTime.sunday;
  }

  void _showCalendarBottomSheet(String flag) {
    DateTime? _selectedDay = null;
    DateTime _focusedDay = DateTime.now();

    showModalBottomSheet(
        context: context,
        backgroundColor: ColorFamily.white,
        builder: (context){
          return StatefulBuilder(
              builder: (context, bottomState) {
                return Wrap(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TableCalendar(
                                  firstDay:  DateTime.utc(2024, 3, 16),
                                  lastDay: DateTime.utc(2024, 8, 14),
                                  focusedDay: _focusedDay,
                                  locale: 'ko_kr',
                                  rowHeight: 50,
                                  headerStyle: const HeaderStyle(
                                      titleCentered: true,
                                      titleTextStyle: TextStyleFamily.appBarTitleBoldTextStyle,
                                      formatButtonVisible: false,
                                  ),
                                  daysOfWeekStyle: const DaysOfWeekStyle(
                                      weekdayStyle: TextStyleFamily.normalTextStyle,
                                      weekendStyle: TextStyleFamily.normalTextStyle
                                  ),
                                  calendarBuilders: CalendarBuilders(
                                      defaultBuilder: (context, day, focusedDay){
                                        return Container(
                                          alignment: Alignment.topCenter,
                                          padding: const EdgeInsets.only(top: 15),
                                          child: Text(
                                            textAlign: TextAlign.center,
                                            DateFormat('d').format(day),
                                            style: TextStyle(
                                                color: isWeekend(day)
                                                    ? Colors.red
                                                    : isSaturday(day)
                                                    ?Colors.blueAccent
                                                    :ColorFamily.black
                                                ,
                                                fontFamily: FontFamily.mapleStoryLight
                                            ),
                                          ),
                                        );
                                      },
                                      outsideBuilder: (context, day, focusedDay){
                                        return Container(
                                          alignment: Alignment.topCenter,
                                          padding: const EdgeInsets.only(top: 15),
                                          child: Text(
                                            textAlign: TextAlign.center,
                                            DateFormat('d').format(day),
                                            style: const TextStyle(
                                                color: ColorFamily.gray,
                                                fontFamily: FontFamily.mapleStoryLight
                                            ),
                                          ),
                                        );
                                      },
                                      disabledBuilder: (context, day, focusedDay){
                                        return Container(
                                          alignment: Alignment.topCenter,
                                          padding: const EdgeInsets.only(top: 15),
                                          child: Text(
                                            textAlign: TextAlign.center,
                                            DateFormat('d').format(day),
                                            style: const TextStyle(
                                                color: ColorFamily.gray,
                                                fontFamily: FontFamily.mapleStoryLight
                                            ),
                                          ),
                                        );
                                      },
                                      selectedBuilder: (context, day, focusedDay){
                                        return Container(
                                          alignment: Alignment.topCenter,
                                          padding: const EdgeInsets.only(top: 10),
                                          child: Container(
                                            width: 30,
                                            height: 30,
                                            decoration: const BoxDecoration(
                                              color: ColorFamily.pink,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                              child: Text(
                                                textAlign: TextAlign.center,
                                                DateFormat('d').format(day),
                                                style: TextStyle(
                                                  decoration: TextDecoration.lineThrough,
                                                    color: isWeekend(day)
                                                        ? ColorFamily.white
                                                        : isSaturday(day)?ColorFamily.white:ColorFamily.black,
                                                    fontFamily: FontFamily.mapleStoryLight
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      todayBuilder: (context, day, focusedDay){
                                        return Container(
                                          alignment: Alignment.topCenter,
                                          padding: const EdgeInsets.only(top: 10),
                                          child: Container(
                                            width: 30,
                                            height: 30,
                                            decoration: const BoxDecoration(
                                              color: ColorFamily.black,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                              child: Text(
                                                textAlign: TextAlign.center,
                                                DateFormat('d').format(day),
                                                style: const TextStyle(
                                                    color: ColorFamily.white,
                                                    fontFamily: FontFamily.mapleStoryLight
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    markerBuilder: (context, day, events){
                                        var _toDay = "${DateTime.now().toIso8601String().substring(0, 10)} 00:00:00.000Z";
                                        return Container(
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.only(top: 20),
                                          child: Container(
                                            width: 6,
                                            height: 6,
                                            decoration: BoxDecoration(
                                              color: (day == _selectedDay || day.toString() == _toDay)
                                                  ?ColorFamily.white
                                                  :ColorFamily.pink,
                                              shape: BoxShape.circle
                                            ),
                                          ),
                                        );
                                    }
                                  ),
                                  selectedDayPredicate: (day){
                                    return isSameDay(_selectedDay, day);
                                  },
                                  onDaySelected: (selectedDay, focusedDay) {
                                    bottomState((){
                                      setState(() {
                                        _selectedDay = selectedDay;
                                        _focusedDay = focusedDay; // update `_focusedDay` here as well
                                      });
                                    });
                                  },
                                  onPageChanged: (focusedDay) {
                                    _focusedDay = focusedDay;
                                  },
                                ),
                                const SizedBox(height: 30,),
                                // 이벤트 버튼들
                                Row(
                                  children: [
                                    SizedBox(
                                      width: ((MediaQuery.of(context).size.width - 40) / 2) - 10,
                                      height: 40,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: ColorFamily.white,
                                            surfaceTintColor: ColorFamily.white
                                          ),
                                          onPressed: (){
                                            bottomState((){
                                              setState(() {
                                                _focusedDay = DateTime.now();
                                              });
                                            });
                                          },
                                          child: const Text("오늘 날짜로", style: TextStyleFamily.normalTextStyle,)
                                      ),
                                    ),
                                    const SizedBox(width: 20,),
                                    SizedBox(
                                      width: ((MediaQuery.of(context).size.width - 40) / 2) - 10,
                                      height: 40,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: ColorFamily.beige,
                                              surfaceTintColor: ColorFamily.beige
                                          ),
                                          onPressed: (){
                                            setState(() {
                                              if(_selectedDay != null){
                                                String formattedDate = DateFormat('yyyy. M.dd').format(_selectedDay!);
                                                if(flag == "start"){
                                                  startPeriod = formattedDate;
                                                  startPeriodController.text = startPeriod;
                                                  Navigator.pop(context, "start");
                                                }else{
                                                  endPeriod = formattedDate;
                                                  endPeriodController.text = endPeriod;
                                                  Navigator.pop(context, "end");
                                                }
                                              }else{
                                                String formattedDate = DateFormat('yyyy. M.dd').format(_focusedDay);
                                                if(flag == "start"){
                                                  startPeriod = formattedDate;
                                                  startPeriodController.text = startPeriod;
                                                  Navigator.pop(context, "start");
                                                }else{
                                                  endPeriod = formattedDate;
                                                  endPeriodController.text = endPeriod;
                                                  Navigator.pop(context, "end");
                                                }
                                              }
                                            });
                                          },
                                          child: const Text("확인", style: TextStyleFamily.normalTextStyle,)
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                      )
                    ]
                );
              }
          );
        }
    );
  }

  void _showModalBottomSheet() {
    if(filterList[0].isEmpty){
      isSelected_editor = [true, false, false];
    }
    if(filterList.length > 2){
      if(filterList[2].isEmpty){
        isSelected_sort = [true, false];
      }
      if(filterList[1].isEmpty){
        startPeriod = "";
        startPeriodController.text = startPeriod;
        endPeriod = "";
        endPeriodController.text = endPeriod;
        filterList.removeAt(1);
      }
    }else{
      if(filterList[1].isEmpty){
        isSelected_sort = [true, false];
      }
    }

    showModalBottomSheet(
        context: context,
        showDragHandle: true,
        backgroundColor: ColorFamily.white,
        builder: (context) {
          return StatefulBuilder(
              builder: (context, bottomState) {
                return Wrap(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "작성자 유형",
                                  style: TextStyleFamily.appBarTitleBoldTextStyle,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            // 작성자 유형
                            ToggleButtons(
                                renderBorder: false,
                                fillColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                selectedColor: ColorFamily.pink,
                                selectedBorderColor: ColorFamily.pink,
                                disabledBorderColor: ColorFamily.gray,
                                disabledColor: ColorFamily.gray,
                                isSelected: isSelected_editor,
                                onPressed: (val){
                                  bottomState((){
                                    setState(() {
                                      isSelected_editor = List.generate(3, (index) => false);
                                      isSelected_editor[val] = !isSelected_editor[val];
                                      print("changed, $isSelected_editor");
                                    });
                                  });
                                },
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(5,0,5,0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          border: Border.all(color: isSelected_editor[0]
                                              ? ColorFamily.pink
                                              : ColorFamily.gray,),
                                          borderRadius: BorderRadius.circular(20)),
                                      width: (MediaQuery.of(context).size.width - 40 - 30) / 3,
                                      height: 40,
                                      alignment: Alignment.center,
                                      child: Text(
                                        editorType[0],
                                        style: TextStyle(
                                            fontFamily: FontFamily.mapleStoryLight,
                                            fontSize: 14,
                                            color: isSelected_editor[0]
                                                ? ColorFamily.pink
                                                : ColorFamily.gray
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          border: Border.all(color: isSelected_editor[1]
                                              ? ColorFamily.pink
                                              : ColorFamily.gray,),
                                          borderRadius: BorderRadius.circular(20)),
                                      width: (MediaQuery.of(context).size.width - 40 - 30) / 3,
                                      height: 40,
                                      alignment: Alignment.center,
                                      child: Text(
                                        editorType[1],
                                        style: TextStyle(
                                            fontFamily: FontFamily.mapleStoryLight,
                                            fontSize: 14,
                                            color: isSelected_editor[1]
                                                ? ColorFamily.pink
                                                : ColorFamily.gray
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          border: Border.all(color: isSelected_editor[2]
                                              ? ColorFamily.pink
                                              : ColorFamily.gray,),
                                          borderRadius: BorderRadius.circular(20)),
                                      width: (MediaQuery.of(context).size.width - 40 - 30) / 3,
                                      height: 40,
                                      alignment: Alignment.center,
                                      child: Text(
                                        editorType[2],
                                        style: TextStyle(
                                            fontFamily: FontFamily.mapleStoryLight,
                                            fontSize: 14,
                                            color: isSelected_editor[2]
                                                ? ColorFamily.pink
                                                : ColorFamily.gray
                                        ),
                                      ),
                                    ),
                                  ),
                                ]
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "조회 기간",
                                  style: TextStyleFamily.appBarTitleBoldTextStyle,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            // 조회 기간
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                    child: SizedBox(
                                      width: (MediaQuery.of(context).size.width - 40 - 20 - 20) / 2,
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 5),
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              const SizedBox(),
                                              Expanded(
                                                child: TextField(
                                                  controller: startPeriodController,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyleFamily.normalTextStyle,
                                                  enabled: false,
                                                  decoration: const InputDecoration(
                                                    disabledBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(color: ColorFamily.black), // 기본 밑줄 색상
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                child: SvgPicture.asset('lib/assets/icons/calendar.svg'),
                                                onTap: () {
                                                  _showCalendarBottomSheet("start");
                                                },
                                              )
                                            ]

                                        ),
                                      ),
                                    ),
                                  ),
                                  const Text("-", style: TextStyleFamily.normalTextStyle,),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                    child: SizedBox(
                                      width: (MediaQuery.of(context).size.width - 40 - 20 - 20) / 2,
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 5),
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(),
                                              Expanded(
                                                child: TextField(
                                                  controller: endPeriodController,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyleFamily.normalTextStyle,
                                                  enabled: false,
                                                  decoration: const InputDecoration(
                                                    disabledBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(color: ColorFamily.black), // 기본 밑줄 색상
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                child: SvgPicture.asset('lib/assets/icons/calendar.svg'),
                                                onTap: () {
                                                  _showCalendarBottomSheet("end");
                                                },
                                              )
                                            ]

                                        ),
                                      ),
                                    ),
                                  ),

                                ]

                            ),
                            const SizedBox(
                              height: 30,),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "정렬 기준",
                                  style: TextStyleFamily.appBarTitleBoldTextStyle,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            // 정렬 기준
                            ToggleButtons(
                                renderBorder: false,
                                fillColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                selectedColor: ColorFamily.pink,
                                selectedBorderColor: ColorFamily.pink,
                                disabledBorderColor: ColorFamily.gray,
                                disabledColor: ColorFamily.gray,
                                isSelected: isSelected_sort,
                                onPressed: (val){
                                  bottomState((){
                                    setState(() {
                                      isSelected_sort = List.generate(2, (index) => false);
                                      isSelected_sort[val] = !isSelected_sort[val];
                                    });
                                  });
                                },
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(5,0,5,0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          border: Border.all(color: isSelected_sort[0]
                                              ? ColorFamily.pink
                                              : ColorFamily.gray,),
                                          borderRadius: BorderRadius.circular(20)),
                                      width: (MediaQuery.of(context).size.width - 40 - 20) / 2,
                                      height: 40,
                                      alignment: Alignment.center,
                                      child: Text(
                                        sortType[0],
                                        style: TextStyle(
                                            fontFamily: FontFamily.mapleStoryLight,
                                            fontSize: 14,
                                            color: isSelected_sort[0]
                                                ? ColorFamily.pink
                                                : ColorFamily.gray
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          border: Border.all(color: isSelected_sort[1]
                                              ? ColorFamily.pink
                                              : ColorFamily.gray,),
                                          borderRadius: BorderRadius.circular(20)),
                                      width: (MediaQuery.of(context).size.width - 40 - 20) / 2,
                                      height: 40,
                                      alignment: Alignment.center,
                                      child: Text(
                                        sortType[1],
                                        style: TextStyle(
                                            fontFamily: FontFamily.mapleStoryLight,
                                            fontSize: 14,
                                            color: isSelected_sort[1]
                                                ? ColorFamily.pink
                                                : ColorFamily.gray
                                        ),
                                      ),
                                    ),
                                  ),
                                ]
                            ),
                            const SizedBox(
                              height: 30,),
                            // 확인 버튼
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 40,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorFamily.beige,
                                    surfaceTintColor: ColorFamily.beige,
                                  ),
                                  onPressed: (){
                                    setState(() {
                                      filterList = [];
                                      // 작성자 유형
                                      filterList.add(editorType[isSelected_editor.indexWhere((element) => element)]);
                                      // 조회 기간
                                      if(startPeriod.isNotEmpty || endPeriod.isNotEmpty){
                                        if(startPeriod.isEmpty){
                                          filterList.add("$startPeriod~$endPeriod");
                                        }else if(endPeriod.isEmpty){
                                          filterList.add("$startPeriod~$endPeriod");
                                        }else{
                                          DateTime pd1 = DateTime.parse(startPeriod.replaceAll(".", "-").replaceAll(" ", "0"));
                                          DateTime pd2 = DateTime.parse(endPeriod.replaceAll(".", "-").replaceAll(" ", "0"));
                                          if(pd1.compareTo(pd2) < 0){
                                            filterList.add("$startPeriod~$endPeriod");
                                          }else{
                                            filterList.add("$endPeriod~$startPeriod");
                                          }
                                        }
                                      }
                                      // 정렬 기준
                                      filterList.add(sortType[isSelected_sort.indexWhere((element) => element)]);
                                      Navigator.pop(context);
                                    });
                                  },
                                  child: const Text("확인", style: TextStyleFamily.normalTextStyle,)
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
          );
        }
    );
  }
}
