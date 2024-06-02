import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:woo_yeon_hi/provider/ledger_carousel_provider.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';

class LedgerCarouselSlider extends StatefulWidget {
  const LedgerCarouselSlider({super.key});

  @override
  State<LedgerCarouselSlider> createState() => _LedgerCarouselSliderState();
}

class _LedgerCarouselSliderState extends State<LedgerCarouselSlider> {

  @override
  Widget build(BuildContext context) {
    final carouselProvider = Provider.of<LedgerCarouselProvider>(context);

    return Stack(
      children: [
        Card(
          margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(width: 0.5),
          ),
          child: CarouselSlider.builder(
            options: CarouselOptions(
              height: 125.0,
              // 보여줄 비율
              viewportFraction: 1.0,
              // 3초마다 자동 슬라이드
              autoPlay: false,
              autoPlayInterval: Duration(seconds: 3),
              onPageChanged: (index, reason) {
                carouselProvider.setCurrentIndex(index);
              },
            ),
            itemCount: carouselProvider.items.length,
            itemBuilder: (context, index, realIndex) {
              final item = carouselProvider.items[index];
              return Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if(item.containsKey('texts1'))
                      Padding(
                          padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...item['texts1'].map<Widget>((text) => Text(text, style: const TextStyle(fontSize: 14, fontFamily: FontFamily.mapleStoryLight))).toList(),
                            ...item['texts2'].map<Widget>((text) => Text(text, style: const TextStyle(fontSize: 20, fontFamily: FontFamily.mapleStoryBold))).toList(),
                            ...item['texts3'].map<Widget>((text) => Text(text, style: const TextStyle(fontSize: 14, fontFamily: FontFamily.mapleStoryLight))).toList(),
                          ],
                        ),
                      )
                    else if (item.containsKey('image'))
                      Expanded(
                        child: Image.asset(
                          item['image'],
                          fit: BoxFit.contain,
                          //alignment: Alignment.center
                        ),
                      ),
                    if (item.containsKey('icon') && !item.containsKey('image'))
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: IconButton(
                            icon: SvgPicture.asset(item['icon'], width: 24, height: 24),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );



            },
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: 125.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // 인디케이터
              AnimatedSmoothIndicator(
                activeIndex: carouselProvider.currentIndex,
                count: carouselProvider.items.length,
                // 설정
                effect: const WormEffect(
                  dotWidth: 10,
                  dotHeight: 10,
                  activeDotColor: ColorFamily.pink,
                  dotColor: ColorFamily.gray,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}