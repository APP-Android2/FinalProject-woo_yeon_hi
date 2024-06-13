import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/style/text_style.dart';
import 'package:woo_yeon_hi/widget/calendar/calendar_color_picker.dart';
import 'package:woo_yeon_hi/widget/calendar/calendar_switch.dart';
import 'package:woo_yeon_hi/widget/calendar/calendar_term_finish.dart';
import 'package:woo_yeon_hi/widget/calendar/calendar_term_start.dart';

class CalendarEditScreen extends StatefulWidget {
  Map<String, dynamic> scheduleData;
  CalendarEditScreen(this.scheduleData, {super.key});

  @override
  State<CalendarEditScreen> createState() => _CalendarEditScreenState();
}

class _CalendarEditScreenState extends State<CalendarEditScreen> {

  Map<String, dynamic> _scheduleData = {};

  // 현재 선택된 색상
  Color currentColor = ColorFamily.green;

  // 하루 종일 체크여부
  bool checkAllDay = false;

  // 시작일 날짜
  DateTime termStart = DateTime.now();
  // 종료일 날짜
  DateTime termFinish = DateTime.now();
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

  // 스위치 버튼
  void isAllTime(bool isTrue){
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

    updateFinishDecoration();

    _scheduleData = widget.scheduleData;

    // 시작일
    termStart = stringToDateForStart(_scheduleData['schedule_start_date']);
    // 종료일
    termFinish = stringToDateForFinish(_scheduleData['schedule_finish_date']);
  }

  // 시작일을 DateTime 타입으로 변경
  DateTime stringToDateForStart(String strDateTime) {
    var date = _scheduleData['schedule_start_date'];
    var time = _scheduleData['schedule_start_time'];

    strDateTime = "$date $time";

    var dateFormat = DateFormat('yyyy. M. dd.(E) HH:mm', 'ko_KR');
    DateTime dateTime = dateFormat.parse(strDateTime);

    return dateTime;
  }

  // 종료일을 DateTime 타입으로 변경
  DateTime stringToDateForFinish(String strDateTime) {
    var date = _scheduleData['schedule_finish_date'];
    var time = _scheduleData['schedule_finish_time'];

    strDateTime = "$date $time";

    var dateFormat = DateFormat('yyyy. M. dd.(E) HH:mm', 'ko_KR');
    DateTime dateTime = dateFormat.parse(strDateTime);

    return dateTime;
  }


  /*


      수정 완료 처리


   */



  @override
  Widget build(BuildContext context) {

    // 제목
    TextEditingController titleController = TextEditingController(text: "${_scheduleData['schedule_title']}");
    // 메모 내용
    TextEditingController memoController = TextEditingController(text: "${_scheduleData['schedule_memo']}");

    return Scaffold(
      backgroundColor: ColorFamily.cream,
      appBar: AppBar(
        backgroundColor: ColorFamily.cream,
        surfaceTintColor: ColorFamily.cream,
        centerTitle: true,
        scrolledUnderElevation: 0,
        title: const Text(
          "일정 편집",
          style: TextStyleFamily.appBarTitleLightTextStyle,
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: SvgPicture.asset('lib/assets/icons/arrow_back.svg'),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {
                // 저장처리
                Navigator.pop(context);
              },
              icon: SvgPicture.asset('lib/assets/icons/done.svg'),
            ),
          )
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            backgroundColor: currentColor,
                          ),
                          onPressed: () => showColorPickerDialog(context, currentColor, updateColor),
                          child: const Icon(null),
                        ),
                        Expanded(
                          child: TextField(
                            controller: titleController,
                            style: TextStyleFamily.appBarTitleBoldTextStyle,
                            keyboardType: TextInputType.text,
                            cursorColor: ColorFamily.black,
                            onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                            decoration: const InputDecoration(
                              hintText: "제목",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
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
                              CalendarSwitch(onSwitchChanged: isAllTime)
                            ],
                          ),
                          const SizedBox(height: 30),
                          Row(
                            children: [
                              const Text("시작", style: TextStyleFamily.normalTextStyle),
                              const Spacer(),
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
                              CalendarTermFinish(
                                onDateChanged: onTermFinishChanged,
                                textDecoration: finishTextDecoration,
                                initialDate: termFinish,
                                isTrue: checkAllDay,
                                checkTerm: checkTerm,
                              )
                            ],
                          ),
                          const SizedBox(height: 30),
                          const Text("메모", style: TextStyleFamily.normalTextStyle),
                          const SizedBox(height: 10),
                          Card(
                            color: ColorFamily.white,
                            surfaceTintColor: ColorFamily.white,
                            elevation: 4,
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                minHeight: 320, // 위젯의 최소 크기
                                maxHeight: double.infinity  // 최대 크기에 맞춰서 늘어나도록
                              ),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: ColorFamily.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  child: TextField(
                                    controller: memoController,
                                    keyboardType: TextInputType.multiline,
                                    cursorColor: ColorFamily.black,
                                    onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                                    maxLines: null,
                                    decoration: const InputDecoration(
                                      hintText: "메모를 입력해주세요",
                                      hintStyle: TextStyleFamily.hintTextStyle,
                                      border: InputBorder.none,
                                    ),
                                    style: TextStyleFamily.normalTextStyle,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorFamily.pink,
                          minimumSize: const Size(double.infinity, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )
                        ),
                        onPressed: () {
                          // 다이얼로그
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                surfaceTintColor: ColorFamily.white,
                                backgroundColor: ColorFamily.white,
                                child: Wrap(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 30, 0, 20),
                                      child: Column(
                                        // 공간을 차지하지 않고 각 끝으로
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          // 텍스트마다 각각 속성을 부여하는 RichText - TextSpan
                                          RichText(
                                            text: const TextSpan(
                                                text: "정말 ",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: FontFamily.mapleStoryLight,
                                                  color: ColorFamily.black,
                                                ),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: "삭제 ",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: FontFamily.mapleStoryBold,
                                                        color: ColorFamily.black,
                                                      )
                                                  ),
                                                  TextSpan(
                                                      text: "하시겠습니까?",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontFamily: FontFamily.mapleStoryLight,
                                                          color: ColorFamily.black
                                                      )
                                                  )
                                                ]
                                            ),
                                          ),
                                          const SizedBox(height: 40),
                                          Row(
                                            // 같은 크기만큼 양 옆 공간차지
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                  "취소",
                                                  style: TextStyleFamily.dialogButtonTextStyle,
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  // 삭제 처리

                                                  Navigator.pop(context); // 다이얼로그
                                                  Navigator.pop(context); // 일정 편집화면
                                                  Navigator.pop(context); // 일정 세부사항 화면
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
                        },
                        child: const Text(
                          "일정 삭제",
                          style: TextStyle(
                            color: ColorFamily.white,
                            fontSize: 14,
                            fontFamily: FontFamily.mapleStoryLight
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
