import 'package:flutter/material.dart';
import 'package:woo_yeon_hi/model/diary_model.dart';
import 'package:woo_yeon_hi/model/enums.dart';

import '../../style/color.dart';
import '../../style/font.dart';
import '../../style/text_style.dart';

class DiaryDetailWeather extends StatefulWidget {
  DiaryDetailWeather(this.diary, {super.key});
  Diary diary;

  @override
  State<DiaryDetailWeather> createState() => _DiaryDetailWeatherState();
}

class _DiaryDetailWeatherState extends State<DiaryDetailWeather> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: (MediaQuery.of(context).size.width - 40)* 0.25,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.diary.diaryDate,
                    style: TextStyleFamily.normalTextStyle,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // 일기 쓰는 사람
                  Text(
                    "우연남",
                    style: TextStyle(
                        fontFamily: FontFamily.mapleStoryBold,
                        fontSize: 14,
                        color: ColorFamily.black),
                  ),
                  Text(
                    "님의 일기",
                    style: TextStyleFamily.normalTextStyle,
                  )
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 5,),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
                width: 60,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Image.asset(DiaryWeather.fromType(widget.diary.diaryWeather)!.image),
                )
            ),
          ],
        )
      ],
    );
  }
}
