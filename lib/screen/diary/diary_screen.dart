import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:woo_yeon_hi/provider/diary_provider.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/text_style.dart';
import 'package:woo_yeon_hi/utils.dart';

import '../../style/font.dart';
import '../../widget/diary/diary_filter_list_view.dart';
import '../../widget/diary/diary_grid_view.dart';
import '../../widget/diary/diary_top_app_bar.dart';
import 'diary_edit_screen.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  int user_idx = 0; // 유저 테이블 연동 할 것.
  @override
  Widget build(BuildContext context) {
    print("");
    print("build!!!");
    print("");

    return ChangeNotifierProvider(
      create: (context) => DiaryProvider(),
      child: Consumer<DiaryProvider>(
        builder: (context, provider, _) {
          return Scaffold(
              backgroundColor: ColorFamily.cream,
              appBar: const DiaryTopAppBar(),
              floatingActionButton: FloatingActionButton(
                backgroundColor: ColorFamily.beige,
                shape: const CircleBorder(),
                child: SvgPicture.asset('lib/assets/icons/edit.svg'),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const DiaryEditScreen(),
                  ));
                },
              ),
              body: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 48,
                      child: Row(
                        children: [
                          InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              _showModalBottomSheet(provider);
                            },
                            child: SvgPicture.asset(
                              'lib/assets/icons/Filter_alt_fill.svg',
                              width: 24,
                              height: 24,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: DiaryFilterListView(
                                  provider))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FutureBuilder(
                      future: provider.getDiary(user_idx),
                        builder: (context, snapshot){
                          if(snapshot.hasData == false){
                            return const Center(child: CircularProgressIndicator(color: ColorFamily.pink,),);
                          }else if(snapshot.hasError){
                            return const Text("오류 발생", style: TextStyleFamily.normalTextStyle,);
                          }else{
                            return Expanded(child: DiaryGridView(provider));
                          }
                        },
                    ),
                  ],
                ),
              )
          );
        },
      ),
    );
  }

  bool isSaturday(DateTime day) {
    return day.weekday == DateTime.saturday;
  }

  bool isWeekend(DateTime day) {
    return day.weekday == DateTime.sunday;
  }

  void _showCalendarBottomSheet(String flag, DiaryProvider provider) {
    DateTime? _selectedDay;
    DateTime _focusedDay = DateTime.now();

    showModalBottomSheet(
        context: context,
        backgroundColor: ColorFamily.white,
        builder: (context) {
          return StatefulBuilder(builder: (context, bottomState) {
            return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.6,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Stack(
                    children: [
                      TableCalendar(
                        firstDay: DateTime.utc(2024, 3, 16),
                        lastDay: DateTime.utc(2024, 8, 14),
                        focusedDay: _focusedDay,
                        locale: 'ko_kr',
                        rowHeight: 50,
                        headerStyle: const HeaderStyle(
                          titleCentered: true,
                          titleTextStyle:
                              TextStyleFamily.appBarTitleBoldTextStyle,
                          formatButtonVisible: false,
                        ),
                        daysOfWeekStyle: const DaysOfWeekStyle(
                            weekdayStyle: TextStyleFamily.normalTextStyle,
                            weekendStyle: TextStyleFamily.normalTextStyle),
                        calendarBuilders: CalendarBuilders(
                            defaultBuilder: (context, day, focusedDay) {
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
                                          ? Colors.blueAccent
                                          : ColorFamily.black,
                                  fontFamily: FontFamily.mapleStoryLight),
                            ),
                          );
                        }, outsideBuilder: (context, day, focusedDay) {
                          return Container(
                            alignment: Alignment.topCenter,
                            padding: const EdgeInsets.only(top: 15),
                            child: Text(
                              textAlign: TextAlign.center,
                              DateFormat('d').format(day),
                              style: const TextStyle(
                                  color: ColorFamily.gray,
                                  fontFamily: FontFamily.mapleStoryLight),
                            ),
                          );
                        }, disabledBuilder: (context, day, focusedDay) {
                          return Container(
                            alignment: Alignment.topCenter,
                            padding: const EdgeInsets.only(top: 15),
                            child: Text(
                              textAlign: TextAlign.center,
                              DateFormat('d').format(day),
                              style: const TextStyle(
                                  color: ColorFamily.gray,
                                  fontFamily: FontFamily.mapleStoryLight),
                            ),
                          );
                        }, selectedBuilder: (context, day, focusedDay) {
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
                                      color: isWeekend(day)
                                          ? ColorFamily.white
                                          : isSaturday(day)
                                              ? ColorFamily.white
                                              : ColorFamily.black,
                                      fontFamily: FontFamily.mapleStoryLight),
                                ),
                              ),
                            ),
                          );
                        }, todayBuilder: (context, day, focusedDay) {
                          return Container(
                            alignment: Alignment.topCenter,
                            padding: const EdgeInsets.only(top: 15),
                            child: Text(
                              textAlign: TextAlign.center,
                              DateFormat('d').format(day),
                              style: const TextStyle(
                                  color: ColorFamily.pink,
                                  fontFamily: FontFamily.mapleStoryLight),
                            ),
                          );
                        }, markerBuilder: (context, day, events) {
                          return Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(top: 20),
                            child: Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                  color: (day == _selectedDay)
                                      ? ColorFamily.white
                                      : ColorFamily.pink,
                                  shape: BoxShape.circle),
                            ),
                          );
                        }),
                        selectedDayPredicate: (day) {
                          return isSameDay(_selectedDay, day);
                        },
                        onDaySelected: (selectedDay, focusedDay) {
                          bottomState(() {
                            _selectedDay = selectedDay;
                            _focusedDay =
                                focusedDay; // update `_focusedDay` here as well
                          });
                        },
                        onPageChanged: (focusedDay) {
                          _focusedDay = focusedDay;
                        },
                      ),
                      // 이벤트 버튼들
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 20,
                        child: Row(
                          children: [
                            SizedBox(
                              width: ((MediaQuery.of(context).size.width - 40) /
                                      2) -
                                  10,
                              height: 40,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: ColorFamily.white,
                                      surfaceTintColor: ColorFamily.white),
                                  onPressed: () {
                                    bottomState(() {
                                      _focusedDay = DateTime.now();
                                    });
                                  },
                                  child: const Text(
                                    "오늘 날짜로",
                                    style: TextStyleFamily.normalTextStyle,
                                  )),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            SizedBox(
                              width: ((MediaQuery.of(context).size.width - 40) /
                                      2) -
                                  10,
                              height: 40,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: ColorFamily.beige,
                                      surfaceTintColor: ColorFamily.beige),
                                  onPressed: () {
                                    if (_selectedDay != null) {
                                      String formattedDate =
                                      dateToString(_selectedDay!);
                                      if (flag == "start") {
                                        provider
                                            .setStartPeriod(formattedDate);
                                        provider.setStartControllerText(
                                            formattedDate);
                                        Navigator.pop(context, "start");
                                      } else {
                                        provider.setEndPeriod(formattedDate);
                                        provider.setEndControllerText(
                                            formattedDate);
                                        Navigator.pop(context, "end");
                                      }
                                    } else {
                                      String formattedDate =
                                      dateToString(_focusedDay);
                                      if (flag == "start") {
                                        provider
                                            .setStartPeriod(formattedDate);
                                        provider.setStartControllerText(
                                            formattedDate);
                                        Navigator.pop(context, "start");
                                      } else {
                                        provider.setEndPeriod(formattedDate);
                                        provider.setEndControllerText(
                                            formattedDate);
                                        Navigator.pop(context, "end");
                                      }
                                    }
                                  },
                                  child: const Text(
                                    "확인",
                                    style: TextStyleFamily.normalTextStyle,
                                  )),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ));
          });
        });
  }

  void _showModalBottomSheet(DiaryProvider provider) {
    if (provider.filterList.first.isEmpty) {
      provider.setSelected_editor([true, false, false]);
    }
    if (provider.filterList.length > 2) {
      if (provider.filterList[2].isEmpty) {
        provider.setSelected_sort([true, false]);
      }
      if (provider.filterList[1].isEmpty) {
        provider.setStartPeriod("");
        provider.setStartControllerText("");
        provider.setEndPeriod("");
        provider.setEndControllerText("");
        provider.removeFilterListByIndex(1);
      }
    } else {
      if (provider.filterList[1].isEmpty) {
        provider.setSelected_sort([true, false]);
      }
    }

    showModalBottomSheet(
        context: context,
        showDragHandle: true,
        backgroundColor: ColorFamily.white,
        builder: (context) {
          return StatefulBuilder(builder: (context, bottomState) {
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
                            isSelected: provider.isSelected_editor,
                            onPressed: (val) {
                              bottomState(() {
                                provider.setSelected_editor(
                                    List.generate(3, (index) => false));
                                provider.updateSelected_editor(
                                    val, !provider.isSelected_editor[val]);
                                if(val == 1){
                                  // 작성자 유형 : 나
                                  provider.setUserIdx(0);
                                }else if(val == 2){
                                  // 작성자 유형 : 상대방
                                  provider.setUserIdx(1);
                                }else{
                                  provider.setUserIdx(null);
                                }
                              });
                            },
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      border: Border.all(
                                        color: provider.isSelected_editor[0]
                                            ? ColorFamily.pink
                                            : ColorFamily.gray,
                                      ),
                                      borderRadius: BorderRadius.circular(20)),
                                  width: (MediaQuery.of(context).size.width -
                                          40 -
                                          30) /
                                      3,
                                  height: 40,
                                  alignment: Alignment.center,
                                  child: Text(
                                    provider.editorType[0],
                                    style: TextStyle(
                                        fontFamily: FontFamily.mapleStoryLight,
                                        fontSize: 14,
                                        color: provider.isSelected_editor[0]
                                            ? ColorFamily.pink
                                            : ColorFamily.gray),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      border: Border.all(
                                        color: provider.isSelected_editor[1]
                                            ? ColorFamily.pink
                                            : ColorFamily.gray,
                                      ),
                                      borderRadius: BorderRadius.circular(20)),
                                  width: (MediaQuery.of(context).size.width -
                                          40 -
                                          30) /
                                      3,
                                  height: 40,
                                  alignment: Alignment.center,
                                  child: Text(
                                    provider.editorType[1],
                                    style: TextStyle(
                                        fontFamily: FontFamily.mapleStoryLight,
                                        fontSize: 14,
                                        color: provider.isSelected_editor[1]
                                            ? ColorFamily.pink
                                            : ColorFamily.gray),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      border: Border.all(
                                        color: provider.isSelected_editor[2]
                                            ? ColorFamily.pink
                                            : ColorFamily.gray,
                                      ),
                                      borderRadius: BorderRadius.circular(20)),
                                  width: (MediaQuery.of(context).size.width -
                                          40 -
                                          30) /
                                      3,
                                  height: 40,
                                  alignment: Alignment.center,
                                  child: Text(
                                    provider.editorType[2],
                                    style: TextStyle(
                                        fontFamily: FontFamily.mapleStoryLight,
                                        fontSize: 14,
                                        color: provider.isSelected_editor[2]
                                            ? ColorFamily.pink
                                            : ColorFamily.gray),
                                  ),
                                ),
                              ),
                            ]),
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
                                  width: (MediaQuery.of(context).size.width -
                                          40 -
                                          20 -
                                          20) /
                                      2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const SizedBox(),
                                          Expanded(
                                            child: TextField(
                                              controller: provider
                                                  .startPeriodController,
                                              textAlign: TextAlign.center,
                                              style: TextStyleFamily
                                                  .normalTextStyle,
                                              enabled: false,
                                              decoration: const InputDecoration(
                                                disabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: ColorFamily
                                                          .black), // 기본 밑줄 색상
                                                ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            child: SvgPicture.asset(
                                                'lib/assets/icons/calendar.svg'),
                                            onTap: () {
                                              _showCalendarBottomSheet(
                                                  "start", provider);
                                            },
                                          )
                                        ]),
                                  ),
                                ),
                              ),
                              const Text(
                                "-",
                                style: TextStyleFamily.normalTextStyle,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                child: SizedBox(
                                  width: (MediaQuery.of(context).size.width -
                                          40 -
                                          20 -
                                          20) /
                                      2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const SizedBox(),
                                          Expanded(
                                            child: TextField(
                                              controller:
                                                  provider.endPeriodController,
                                              textAlign: TextAlign.center,
                                              style: TextStyleFamily
                                                  .normalTextStyle,
                                              enabled: false,
                                              decoration: const InputDecoration(
                                                disabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: ColorFamily
                                                          .black), // 기본 밑줄 색상
                                                ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            child: SvgPicture.asset(
                                                'lib/assets/icons/calendar.svg'),
                                            onTap: () {
                                              _showCalendarBottomSheet(
                                                  "end", provider);
                                            },
                                          )
                                        ]),
                                  ),
                                ),
                              ),
                            ]),
                        const SizedBox(
                          height: 30,
                        ),
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
                            isSelected: provider.isSelected_sort,
                            onPressed: (val) {
                              bottomState(() {
                                provider.setSelected_sort(
                                    List.generate(2, (index) => false));
                                provider.updateSelected_sort(
                                    val, !provider.isSelected_sort[val]);
                              });
                            },
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      border: Border.all(
                                        color: provider.isSelected_sort[0]
                                            ? ColorFamily.pink
                                            : ColorFamily.gray,
                                      ),
                                      borderRadius: BorderRadius.circular(20)),
                                  width: (MediaQuery.of(context).size.width -
                                          40 -
                                          20) /
                                      2,
                                  height: 40,
                                  alignment: Alignment.center,
                                  child: Text(
                                    provider.sortType[0],
                                    style: TextStyle(
                                        fontFamily: FontFamily.mapleStoryLight,
                                        fontSize: 14,
                                        color: provider.isSelected_sort[0]
                                            ? ColorFamily.pink
                                            : ColorFamily.gray),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      border: Border.all(
                                        color: provider.isSelected_sort[1]
                                            ? ColorFamily.pink
                                            : ColorFamily.gray,
                                      ),
                                      borderRadius: BorderRadius.circular(20)),
                                  width: (MediaQuery.of(context).size.width -
                                          40 -
                                          20) /
                                      2,
                                  height: 40,
                                  alignment: Alignment.center,
                                  child: Text(
                                    provider.sortType[1],
                                    style: TextStyle(
                                        fontFamily: FontFamily.mapleStoryLight,
                                        fontSize: 14,
                                        color: provider.isSelected_sort[1]
                                            ? ColorFamily.pink
                                            : ColorFamily.gray),
                                  ),
                                ),
                              ),
                            ]),
                        const SizedBox(
                          height: 30,
                        ),
                        // 확인 버튼
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorFamily.beige,
                                surfaceTintColor: ColorFamily.beige,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                provider.setFilterList([]);
                                // 작성자 유형
                                provider.addFilterListItem(provider.editorType[
                                    provider.isSelected_editor
                                        .indexWhere((element) => element)]);
                                // 조회 기간
                                if (provider.startPeriod.isNotEmpty ||
                                    provider.endPeriod.isNotEmpty) {
                                  if (provider.startPeriod.isEmpty) {
                                    provider.addFilterListItem(
                                        "${provider.startPeriod}~${provider.endPeriod}");
                                  } else if (provider.endPeriod.isEmpty) {
                                    provider.addFilterListItem(
                                        "${provider.startPeriod}~${provider.endPeriod}");
                                  } else {
                                    DateTime pd1 =
                                        stringToDate(provider.startPeriod);
                                    DateTime pd2 =
                                        stringToDate(provider.endPeriod);
                                    if (pd1.compareTo(pd2) < 0) {
                                      provider.addFilterListItem(
                                          "${provider.startPeriod}~${provider.endPeriod}");
                                    } else {
                                      provider.addFilterListItem(
                                          "${provider.endPeriod}~${provider.startPeriod}");
                                    }
                                  }
                                }
                                // 정렬 기준
                                provider.addFilterListItem(provider.sortType[
                                    provider.isSelected_sort
                                        .indexWhere((element) => element)]);
                                provider.providerNotify();
                              },
                              child: const Text(
                                "확인",
                                style: TextStyleFamily.normalTextStyle,
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          });
        });
  }
}
