import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/widget/ledger_carousel_slider.dart';
import 'package:woo_yeon_hi/widget/ledger_table_calendar.dart';
import 'package:woo_yeon_hi/widget/ledger_top_app_bar.dart';

class LedgerScreen extends StatefulWidget {
  const LedgerScreen({super.key});

  @override
  State<LedgerScreen> createState() => _LedgerScreenState();
}

class _LedgerScreenState extends State<LedgerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 앱바
      appBar: LedgerTopAppBar(),
      // 전체 배경색
      backgroundColor: ColorFamily.cream,
      body: Stack(
        children: [
          ListView(
            children: [
              // 상단 베너
              LedgerCarouselSlider(),
              // 캘린더
              LedgerTableCalendar(),
            ],
          ),

          // 하단 중앙에 FloatingActionButton 배치
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0), // 화면 하단에서 간격 설정
                child: Container(
                  color: ColorFamily.cream,
                  width: 60,
                  height: 40,
                  child: FloatingActionButton(
                    onPressed: () {
                      // FAB의 액션
                      print('Center123');
                    },
                    backgroundColor: ColorFamily.beige,
                    child: Text('오늘', style: TextStyle(fontSize: 15,fontFamily: FontFamily.mapleStoryLight)),
                  ),
                )
            ),
          ),

          // 하단 오른쪽에 FloatingActionButton 배치
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16.0, right: 16.0), // 화면 하단과 오른쪽에서 간격 설정
              child: FloatingActionButton(
                  onPressed: () {
                    // FAB의 액션
                    print('Right123');
                  },
                  backgroundColor: ColorFamily.beige,
                  child: SvgPicture.asset('lib/assets/icons/edit.svg')
              ),
            ),
          ),
        ],
      ),
    );
  }
}