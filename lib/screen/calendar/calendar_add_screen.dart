import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/widget/calendar/calendar_color_picker.dart';
import 'package:woo_yeon_hi/widget/calendar/calendar_switch.dart';
import 'package:woo_yeon_hi/widget/calendar/calendar_term_finish.dart';
import 'package:woo_yeon_hi/widget/calendar/calendar_term_start.dart';

import '../../style/text_style.dart';

class CalendarAddScreen extends StatefulWidget {
  const CalendarAddScreen({super.key});

  @override
  State<CalendarAddScreen> createState() => _CalendarAddScreenState();
}

class _CalendarAddScreenState extends State<CalendarAddScreen> {

  // 현재 선택된 색상
  Color currentColor = ColorFamily.green;

  // 하루 종일 체크여부
  bool checkAllDay = false;

  // 시작일 날짜
  DateTime termStart = DateTime.now().subtract(Duration(minutes: DateTime.now().minute));
  // 종료일 날짜  +1 hour
  DateTime termFinish = DateTime.now().add(const Duration(hours: 1)).subtract(Duration(minutes: DateTime.now().minute));
  // 종료일 텍스트 데코
  TextDecoration finishTextDecoration = TextDecoration.none;
  // 종료일 체크 참거짓
  bool checkTerm = true;

  // 색 업데이트 함수
  void updateColor(Color color){
    setState(() {
      currentColor = color;
    });
  }

  // 스위치 버튼 - 하루종일
  void isAllDay(bool isTrue){
    setState(() {
      checkAllDay = !checkAllDay;
      updateFinishDecoration();
    });
  }

  // 시작일이 변경될 때
  void onTermStartChanged(DateTime date){
    setState(() {
      termStart = date;
      updateFinishDecoration();
    });
  }

  // 종료일이 변경될 때
  void onTermFinishChanged(DateTime date){
    setState(() {
      termFinish = date;
      updateFinishDecoration();
    });
  }

  // 종료일 상태 업데이트
  void updateFinishDecoration() {

    // 년, 월, 일
    var startDay = termStart.year + termStart.month + termStart.day;
    var finishDay = termFinish.year + termFinish.month + termFinish.day;

    // 하루종일 - true
    if(checkAllDay){
      // 년, 월, 일이 같다면
      if(startDay == finishDay) {
        checkTerm = true;
        finishTextDecoration = TextDecoration.none;
      }
      else {
        // 종료일이 시작일보다 먼저라면
        if (termFinish.isBefore(termStart)) {
          checkTerm = false;
          finishTextDecoration = TextDecoration.lineThrough;
        } else {
          checkTerm = true;
          finishTextDecoration = TextDecoration.none;
        }
      }
    }

    // 하루종일 - false
    else {
      // 종료일이 시작일보다 먼저라면
      if (termFinish.isBefore(termStart)) {
        checkTerm = false;
        finishTextDecoration = TextDecoration.lineThrough;
      } else {
        checkTerm = true;
        finishTextDecoration = TextDecoration.none;
      }
    }

  }

  @override
  void initState() {
    super.initState();

    // 화면이 처음 생성 될 때 함수 호출
    updateFinishDecoration();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorFamily.cream,
        appBar: AppBar(
          surfaceTintColor: ColorFamily.cream,
          backgroundColor: ColorFamily.cream,
          centerTitle: true,
          scrolledUnderElevation: 0,
          title: const Text(
              "일정 추가",
              style: TextStyleFamily.appBarTitleLightTextStyle
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset("lib/assets/icons/arrow_back.svg"),
          ),
          actions: [
            IconButton(
              onPressed: () {
                // 일정 오류
                if(termFinish.isBefore(termStart)){
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                        surfaceTintColor: ColorFamily.white,
                        backgroundColor: ColorFamily.white,
                        child: Wrap(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 30, 0, 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Column(
                                    children: [
                                      Text(
                                        "오류가 발생했습니다.",
                                        style: TextStyleFamily.dialogTitleTextStyle,
                                      ),
                                      SizedBox(height: 15),
                                      Text(
                                        "시작일은 종료일의 이전이어야 합니다.",
                                        style: TextStyleFamily.hintTextStyle,
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 30),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      TextButton(
                                        style: ButtonStyle(
                                          overlayColor: MaterialStateProperty.all(
                                            ColorFamily.gray
                                          )
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          "취소",
                                          style: TextStyleFamily.dialogButtonTextStyle,
                                        ),
                                      ),
                                      TextButton(
                                        style: ButtonStyle(
                                            overlayColor: MaterialStateProperty.all(
                                                ColorFamily.gray
                                            )
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          "확인",
                                          style: TextStyleFamily.dialogButtonTextStyle_pink,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                  // 오류가 없을 경우
                } else {
                  // 저장 처리
                  Navigator.pop(context);
                }
              },
              icon: SvgPicture.asset("lib/assets/icons/done.svg"),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: currentColor // 선택된 색상
                    ),
                    // 색 선택 다이얼로그 띄우기
                    onPressed: () => showColorPickerDialog(context, currentColor, updateColor),
                    child: const Icon(
                      Icons.color_lens,
                      color: Colors.white,
                    ),
                  ),
                  const Expanded(
                    child: TextField(
                      style: TextStyleFamily.appBarTitleBoldTextStyle,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: "제목",
                        hintStyle: TextStyleFamily.hintTitleTextStyle,
                        border: InputBorder.none, // 밑줄 제거
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text("하루 종일", style: TextStyleFamily.normalTextStyle),
                        const Spacer(),
                        CalendarSwitch(onSwitchChanged: isAllDay), // 스위치 버튼
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        const Text("시작", style: TextStyleFamily.normalTextStyle),
                        const Spacer(),
                        // 시작 날짜를 선택하는 위젯
                        CalendarTermStart(
                          onDateChanged: onTermStartChanged,
                          initialDate: termStart,
                          isTrue: checkAllDay,
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        const Text("종료", style: TextStyleFamily.normalTextStyle),
                        const Spacer(),
                        // 종료 날짜를 선택하는 위젯
                        CalendarTermFinish(
                          onDateChanged: onTermFinishChanged,
                          textDecoration: finishTextDecoration,
                          initialDate: termFinish,
                          isTrue: checkAllDay,
                          checkTerm: checkTerm,
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    const Text("메모", style: TextStyleFamily.normalTextStyle),
                    const SizedBox(height: 10),
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        minHeight: 320, // 위젯의 최소 크기
                        maxHeight: double.infinity, // 최대 크기에 맞춰 늘어나도록
                      ),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: ColorFamily.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: TextField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: InputDecoration(
                                hintText: "메모를 입력해주세요",
                                hintStyle: TextStyleFamily.hintTextStyle,
                                border: InputBorder.none
                            ),
                            style: TextStyleFamily.normalTextStyle,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}