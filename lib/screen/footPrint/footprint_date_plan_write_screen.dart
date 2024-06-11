import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woo_yeon_hi/screen/footPrint/footprint_date_plan_detail_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/widget/footPrint/footprint_date_plan_draggable_sheet.dart';
import 'package:woo_yeon_hi/widget/footPrint/footprint_date_plan_search_bar.dart';
import 'package:woo_yeon_hi/widget/footPrint/footprint_date_plan_top_app_bar.dart';

class FootprintDatePlanWriteScreen extends StatefulWidget {
  const FootprintDatePlanWriteScreen({super.key});

  @override
  State<FootprintDatePlanWriteScreen> createState() => _FootprintDatePlanWriteScreenState();
}

class _FootprintDatePlanWriteScreenState extends State<FootprintDatePlanWriteScreen> {
  // NaverMapController 객체의 비동기 작업 완료를 나타내는 Completer 생성
  final Completer<NaverMapController> mapControllerCompleter = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 앱바
      appBar: FootprintDatePlanTopAppBar(
        title: '데이트 플랜 작성',
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset('lib/assets/icons/arrow_back.svg'),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FootprintDatePlanDetailScreen()
                  )
              );
            },
            icon: SvgPicture.asset('lib/assets/icons/list.svg'),
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset('lib/assets/icons/done.svg'),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      // 전체 배경색
      backgroundColor: ColorFamily.cream,
      body: Stack(
        children: [
          // NaverMap 위젯 초기화.
          NaverMap(
            options: const NaverMapViewOptions(),
            // 지도 준비 완료 시 호출되는 콜백 함수
            onMapReady: (controller) {
              mapControllerCompleter.complete(controller);
              print("네이버 맵 로딩 완료");
            },
          ),

          // 검색 바
          FootprintDatePlanSearchBar(),

          // 바텀 시트
          FootprintDatePlanDraggableSheet(),
        ],
      ),
    );
  }
}