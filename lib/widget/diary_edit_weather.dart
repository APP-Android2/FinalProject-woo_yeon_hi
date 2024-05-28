import 'package:flutter/material.dart';

import '../style/color.dart';
import '../style/font.dart';
import '../style/text_style.dart';

class DiaryEditWeather extends StatefulWidget {
  const DiaryEditWeather({super.key});

  @override
  State<DiaryEditWeather> createState() => _DiaryEditWeatherState();
}

class _DiaryEditWeatherState extends State<DiaryEditWeather> {
  int weatherSelected = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width * 2 / 3) - 20,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "2024. 5.27.",
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
          const SizedBox(
            height: 30,
          ),
          // 날씨 토글 버튼
          SizedBox(
            width: (MediaQuery.of(context).size.width * 2 / 3) - 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    onTap: () {
                      setState(() {
                        weatherSelected = 0;
                      });
                    },
                    child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5), // corner radius를 5로 설정
                          border: Border.all(color: (weatherSelected == 0)?ColorFamily.pink:Colors.transparent), // stroke 색상을 red로 설정
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.asset('lib/assets/icons/sunny.png'),
                        ))
                ),
                const SizedBox(width:3,),
                InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    onTap: () {
                      setState(() {
                        weatherSelected = 1;
                      });
                    },
                    child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5), // corner radius를 5로 설정
                          border: Border.all(color: (weatherSelected == 1)?ColorFamily.pink:Colors.transparent), // stroke 색상을 red로 설정
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.asset('lib/assets/icons/cloudy.png'),
                        ))
                ),
                const SizedBox(width:3,),
                InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    onTap: () {
                      setState(() {
                        weatherSelected = 2;
                      });
                    },
                    child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5), // corner radius를 5로 설정
                          border: Border.all(color: (weatherSelected == 2)?ColorFamily.pink:Colors.transparent), // stroke 색상을 red로 설정
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.asset('lib/assets/icons/rainy.png'),
                        ))
                ),
                const SizedBox(width:3,),
                InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    onTap: () {
                      setState(() {
                        weatherSelected = 3;
                      });
                    },
                    child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5), // corner radius를 5로 설정
                          border: Border.all(color: (weatherSelected == 3)?ColorFamily.pink:Colors.transparent), // stroke 색상을 red로 설정
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.asset('lib/assets/icons/snowy.png'),
                        ))
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
