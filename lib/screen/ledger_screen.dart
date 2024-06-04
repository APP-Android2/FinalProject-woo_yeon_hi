import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/widget/ledger_carousel_slider.dart';
import 'package:woo_yeon_hi/widget/ledger_dialog.dart';
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
      appBar: LedgerTopAppBar(
        title: '가계부',
      ),
      // 전체 배경색
      body: Container(
        color: ColorFamily.cream,
        child: Stack(
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
                    color: Colors.transparent,
                    width: 60,
                    height: 40,
                    child: FloatingActionButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                      backgroundColor: ColorFamily.beige,
                      child: Text('오늘', style: TextStyle(fontSize: 15,fontFamily: FontFamily.mapleStoryLight)),
                      heroTag: "actionButton1",
                      onPressed: () {
                        // FAB의 액션
                        print('Center123');
                      },
                    ),
                  ),
              ),
            ),
          ],
        ),
      ),

      // 하단 오른쪽에 FloatingActionButton 배치
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: ColorFamily.beige,
        child: SvgPicture.asset('lib/assets/icons/edit.svg'),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return LedgerDialog('LedgerScreen', '미등록 거래내역이 있습니다.', '이동하시겠습니까?');
            },
          );
        },
      ),
    );
  }
}