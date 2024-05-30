import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woo_yeon_hi/screen/calendar_edit_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/style/text_style.dart';
import 'package:woo_yeon_hi/widget/calendar_color_picker.dart';

class CalendarDetailScreen extends StatefulWidget {
  const CalendarDetailScreen({super.key});

  @override
  State<CalendarDetailScreen> createState() => _CalendarDetailScreenState();
}

class _CalendarDetailScreenState extends State<CalendarDetailScreen> {

  Color currentColor = ColorFamily.green;

  final String title = "한강 피크닉";

  // 색 업데이트 함수
  void updateColor(Color color){
    setState(() {
      currentColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        scrolledUnderElevation: 0,
        title: Text(
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
                    return CalendarEditScreen(title: title);
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
                            "한강 피크닉",
                            style: TextStyleFamily.appBarTitleBoldTextStyle,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "2024. 5. 28.(화)",
                            style: TextStyleFamily.normalTextStyle,
                          ),
                          SizedBox(height: 5),
                          Text(
                            "12:00 ~ 18:00",
                            style: TextStyleFamily.normalTextStyle,
                          ),
                          SizedBox(height: 45),
                          Text("메모", style: TextStyleFamily.normalTextStyle),
                          SizedBox(height: 10),
                          ConstrainedBox(
                            constraints: BoxConstraints(
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
                                    "썬글라스 챙기기\n도시락 챙기기\nb\nb\nb\nb\nb\nb\nb\nb\nb\nb\nb\nb\nb\nb\nb\nb\nb\nb\nb\nb\nb\nb\nb\nb\nb\nb\nb\nb\nb",
                                    style: TextStyleFamily.normalTextStyle,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: ColorFamily.pink,
                            minimumSize: Size(double.infinity, 40),
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
                                            text: TextSpan(
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
                                          SizedBox(height: 40),
                                          Row(
                                            // 같은 크기만큼 양 옆 공간차지
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
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
                                                child: Text(
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
                        child: Text(
                          "일정 삭제",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: FontFamily.mapleStoryLight,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
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
