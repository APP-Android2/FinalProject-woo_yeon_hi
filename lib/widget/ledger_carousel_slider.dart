import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:woo_yeon_hi/style/font.dart';

class LedgerCarouselSlider extends StatefulWidget {
  const LedgerCarouselSlider({super.key});

  @override
  State<LedgerCarouselSlider> createState() => _LedgerCarouselSliderState();
}

class _LedgerCarouselSliderState extends State<LedgerCarouselSlider> {

  final List<Map<String, dynamic>> items = [
    {
      'texts1': ['5월 지출 현황'],
      'texts2': ['123,123,123 원'],
      'texts3': ['지난달보다 178,784,567 원 더 쓰고 있어요'],
      'icon': 'lib/assets/icons/expand.svg',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
          //color: ColorFamily.gray,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(width: 0.5)
          ),

          child: CarouselSlider(
            options: CarouselOptions(
              height: 125.0,
              // 보여줄 비율
              viewportFraction: 1.0,
              // 3초마다 자동 슬라이드
              autoPlay: false,
              autoPlayInterval: Duration(seconds: 3),
            ),

            items: items.map((item) => Builder(
              builder: (BuildContext context) {
                return Container(
                  //decoration: BoxDecoration(border: Border.all(width: 3,color: Colors.red)),
                  padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                    children: item['texts1'].map<Widget>((text) {
                                      return Text(
                                        text,
                                        style: TextStyle(fontSize: 14, fontFamily: FontFamily.mapleStoryLight),
                                      );
                                    }).toList()
                                ),
                                Column(
                                    children: item['texts2'].map<Widget>((text2) {
                                      return Text(
                                        text2,
                                        style: TextStyle(fontSize: 20, fontFamily: FontFamily.mapleStoryBold),
                                      );
                                    }).toList()
                                ),
                                Column(
                                    children: item['texts3'].map<Widget>((text3) {
                                      return Text(
                                        text3,
                                        style: TextStyle(fontSize: 14, fontFamily: FontFamily.mapleStoryLight),
                                      );
                                    }).toList()
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 5.0),
                      Container(
                        child: Row(
                          children: [
                            IconButton(
                              icon: SvgPicture.asset(item['icon'], width: 24, height: 24),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            )).toList(),
          ),
        ),

        Container(
          //color: Colors.deepPurple,
          width: double.infinity,
          height: 125.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // 인디케이터
              AnimatedSmoothIndicator(
                activeIndex: 0,
                count: 5,
                // 설정
                effect: WormEffect(
                  dotWidth: 10,
                  dotHeight: 10,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}