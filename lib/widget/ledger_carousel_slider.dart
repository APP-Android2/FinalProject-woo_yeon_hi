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
        Container(
          height: 145,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: CarouselSlider.builder(
            options: CarouselOptions(
              height: 140.0,
              // 보여줄 비율
              viewportFraction: 1.0,
              autoPlay: false,
              onPageChanged: (index, reason) {
                carouselProvider.setCurrentIndex(index);
              },
            ),
            itemCount: carouselProvider.items.length,
            itemBuilder: (context, index, realIndex) {
              final item = carouselProvider.items[index];
              return Material(
                color: ColorFamily.cream,
                elevation: 1,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: ColorFamily.white),
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
                              SizedBox(height: 10),
                              ...item['texts2'].map<Widget>((text) => Text(text, style: const TextStyle(fontSize: 20, fontFamily: FontFamily.mapleStoryBold))).toList(),
                              SizedBox(height: 5),
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
                            Container(width: 64, child: SvgPicture.asset(item['icon'], width: 24, height: 24)),
                          ],
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: 135.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // 인디케이터
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                height: 15,
                decoration: BoxDecoration(color: Color(0xFFE6E6E6),borderRadius: BorderRadius.circular(20)),
                child: AnimatedSmoothIndicator(
                  activeIndex: carouselProvider.currentIndex,
                  count: carouselProvider.items.length,
                  // 설정
                  effect: const WormEffect(
                    dotWidth: 10,
                    dotHeight: 10,
                    activeDotColor: ColorFamily.pink,
                    dotColor: ColorFamily.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}