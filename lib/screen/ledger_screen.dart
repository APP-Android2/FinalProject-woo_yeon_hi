import 'package:flutter/material.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/widget/ledger_carousel_slider.dart';
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
            ],
          ),
        ],
      ),
    );
  }
}