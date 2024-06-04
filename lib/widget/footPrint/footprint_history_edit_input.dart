import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:woo_yeon_hi/provider/footprint_provider.dart';
import 'package:woo_yeon_hi/screen/footPrint/footprint_history_edit_place_screen.dart';
import 'package:woo_yeon_hi/style/text_style.dart';

import '../../model/enums.dart';
import '../../style/color.dart';
import '../../style/font.dart';

class FootprintHistoryEditInput extends StatefulWidget {
  const FootprintHistoryEditInput({super.key});

  @override
  State<FootprintHistoryEditInput> createState() => _FootprintHistoryEditInputState();
}

class _FootprintHistoryEditInputState extends State<FootprintHistoryEditInput> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FootprintHistoryEditProvider(),
      child: Consumer<FootprintHistoryEditProvider>(
        builder: (context, provider, _) {
          return Padding(
            padding: const EdgeInsets.only(top: 35),
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 40,
              child: Column(
                children: [
                  // 지역 선택
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> FootprintHistoryEditPlaceScreen(provider, MapType.KOREA_FULL.type)));
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset('lib/assets/icons/map.svg'),
                        const SizedBox(width: 15,),
                        provider.selectedPlace != null
                            ? Row(
                          children: [
                            Text(provider.selectedPlace!, style: TextStyleFamily.normalTextStyle,),
                            const Text(" (선택한 지역)", style: TextStyleFamily.hintTextStyle ,)
                          ],
                        )
                            : const Text("(선택한 지역)", style: TextStyleFamily.hintTextStyle ,)
                      ],
                    ),
                  ),
                  const Divider(
                    height: 40,
                    thickness: 1,
                  ),
                  // 날짜 입력
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: (){
                      _showCalendarBottomSheet(provider);
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset('lib/assets/icons/calendar.svg'),
                        const SizedBox(width: 15,),
                        provider.date != null
                            ? Row(
                          children: [
                            Text(provider.date!, style: TextStyleFamily.normalTextStyle,),
                          ],
                        )
                            : const Text("날짜 입력", style: TextStyleFamily.hintTextStyle ,)
                      ],
                    ),
                  ),
                  const Divider(
                    height: 40,
                    thickness: 1,
                  ),
                  // 히스토리 제목
                  Row(
                    children: [
                      SvgPicture.asset('lib/assets/icons/woo_yeon_hi.svg'),
                      const SizedBox(width: 15,),
                      Expanded(
                        child: TextField(
                          controller: provider.titleController,
                          style: TextStyleFamily.normalTextStyle,
                          maxLines: 1,
                          keyboardType: TextInputType.text,
                          cursorColor: ColorFamily.black,
                          onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                          decoration: const InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              hintStyle: TextStyleFamily.hintTextStyle,
                              hintText: "히스토리 제목"
                          ),
                        ),
                      )
                    ],
                  ),
                  const Divider(
                    height: 40,
                    thickness: 1,
                  ),
                  // 히스토리 내용
                  Row(
                    children: [
                      SvgPicture.asset('lib/assets/icons/message-question.svg'),
                      const SizedBox(width: 15,),
                      const Text("어떤 추억을 만드셨나요?", style: TextStyleFamily.normalTextStyle,)
                    ],
                  ),
                  const SizedBox(height: 20,),
                  TextField(
                    controller: provider.contentController,
                    style: TextStyleFamily.normalTextStyle,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    cursorColor: ColorFamily.black,
                    onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                    decoration: const InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                        hintStyle: TextStyleFamily.hintTextStyle,
                        hintText: "내용을 입력해주세요."
                    ),
                  )
                ],
              ),
            ),
          );
        }
      ),
    );
  }

  bool isSaturday(DateTime day) {
    return day.weekday == DateTime.saturday;
  }

  bool isWeekend(DateTime day) {
    return day.weekday == DateTime.sunday;
  }

  void _showCalendarBottomSheet(FootprintHistoryEditProvider provider) {
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
                      SizedBox(
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
                                            if(_selectedDay != null){
                                              var date = DateFormat('yyyy. M.dd.').format(_selectedDay!);
                                              provider.setDate(date);
                                            }else{
                                              var date = DateFormat('yyyy. M.dd.').format(_focusedDay);
                                              provider.setDate(date);
                                            }

                                            Navigator.pop(context);
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
}


