import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/widget/footPrint/footprint_date_plan_search_bar.dart';
import 'package:woo_yeon_hi/widget/footPrint/footprint_date_plan_top_app_bar.dart';

class FootprintDatePlanWriteScreen extends StatefulWidget {
  const FootprintDatePlanWriteScreen({super.key});

  @override
  State<FootprintDatePlanWriteScreen> createState() => _FootprintDatePlanWriteScreenState();
}

class _FootprintDatePlanWriteScreenState extends State<FootprintDatePlanWriteScreen> {
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
      ),
      // 전체 배경색
      backgroundColor: ColorFamily.cream,
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: FootprintDatePlanSearchBar(),
            ),
          ],
        ),
      ),
    );
  }
}