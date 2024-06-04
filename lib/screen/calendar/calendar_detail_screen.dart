import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:woo_yeon_hi/screen/calendar/calendar_edit_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/style/text_style.dart';

class CalendarDetailScreen extends StatefulWidget {
  const CalendarDetailScreen({super.key});

  @override
  State<CalendarDetailScreen> createState() => _CalendarDetailScreenState();
}

class _CalendarDetailScreenState extends State<CalendarDetailScreen> {

  Color currentColor = ColorFamily.green;

  final String titleDetail = "한강 피크닉";
  final DateTime startTimeDetail = DateTime(2024, 5, 31, 12, 0);
  final DateTime finishTimeDetail = DateTime(2024, 5, 31, 18, 0);
  final String memoDetail = "썬글라스 챙기기\n도시락 챙기기\nb\nb\nb\nb\nb\nb\nb\nb\nb\nb\nb\nb\nb\nb\nb\nb\nb\nb\nb\nb\nb\nb\nb\nb\nb\nb\nb\nb\nb";

  // 색 업데이트 함수
  void updateColor(Color color){
    setState(() {
      currentColor = color;
    });
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
          "일정 세부사항",
          style: TextStyleFamily.appBarTitleLightTextStyle
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset("lib/assets/icons/arrow_back.svg"),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return CalendarEditScreen(
                      title: titleDetail,
                      termStart: startTimeDetail,
                      termFinish: finishTimeDetail,
                      memo: memoDetail,
                    );
                  }),
                );
              },
              icon: SvgPicture.asset("lib/assets/icons/edit.svg"),
            ),
          )
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30),
                    Row(
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                backgroundColor: currentColor // 선택된 색상
                            ),
                            onPressed: () {},
                            child: Icon(null)
                        ),
                        Expanded(
                          child: Text(
                            titleDetail,
                            style: TextStyleFamily.appBarTitleBoldTextStyle,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 일정 날짜
                          Text(
                            DateFormat("yyyy. M. dd.(E)", "ko_KR").format(startTimeDetail),
                            style: TextStyleFamily.normalTextStyle,
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              // 일정
                              Text(
                                DateFormat("H:mm ~").format(startTimeDetail),
                                style: TextStyleFamily.normalTextStyle,
                              ),
                              Text(
                                DateFormat(" H:mm").format(finishTimeDetail),
                                style: TextStyleFamily.normalTextStyle,
                              ),
                            ],
                          ),
                          const SizedBox(height: 45),
                          const Text("메모", style: TextStyleFamily.normalTextStyle),
                          const SizedBox(height: 10),
                          ConstrainedBox(
                            constraints: const BoxConstraints(
                              minHeight: 320, // 위젯의 최소 크기
                              maxHeight: double.infinity  // 최대 크기에 맞춰 늘어나도록
                            ),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: ColorFamily.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(15),
                                child: SingleChildScrollView(
                                  child: Text(
                                    memoDetail,
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
                                                  Navigator.pop(context);
                                                  Navigator.of(context).pop(
                                                      MaterialPageRoute(builder: (context) => CalendarDetailScreen())
                                                  );
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
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: FontFamily.mapleStoryLight,
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
        },
      )
    );
  }
}
