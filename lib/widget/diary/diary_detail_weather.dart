import 'package:flutter/material.dart';

import '../../style/color.dart';
import '../../style/font.dart';
import '../../style/text_style.dart';

class DiaryDetailWeather extends StatefulWidget {
  const DiaryDetailWeather({super.key});

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
          child: const Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "2024. 5.27.",
                    style: TextStyleFamily.normalTextStyle,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
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
        SizedBox(
          width: (MediaQuery.of(context).size.width - 40) * 0.3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                  width: 60,
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Image.asset('lib/assets/icons/sunny.png'),
                  )
              ),
            ],
          ),
        )
      ],
    );
  }
}
