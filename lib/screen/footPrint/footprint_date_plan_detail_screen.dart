import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/provider/footprint_provider.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/widget/footPrint/footprint_date_plan_top_app_bar.dart';

class FootprintDatePlanDetailScreen extends StatefulWidget {
  const FootprintDatePlanDetailScreen({super.key});

  @override
  State<FootprintDatePlanDetailScreen> createState() => _FootprintDatePlanDetailScreenState();
}

class _FootprintDatePlanDetailScreenState extends State<FootprintDatePlanDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FootprintDatePlanTopAppBar(
        title: '데이트 플랜 리스트',
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: SvgPicture.asset('lib/assets/icons/done.svg'),
          )
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset('lib/assets/icons/arrow_back.svg'),
        ),
      ),
      backgroundColor: ColorFamily.cream,
      body: Consumer<FootPrintDatePlanSlidableProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.items.length,
            itemBuilder: (context, index) {
              final item = provider.items[index];
              return Column(
                children: [
                  makeListView(item, index, provider),
                  Divider(),
                ],
              );
            },
          );
        },
      ),

    );
  }

  Widget makeListView(Item item, int index, FootPrintDatePlanSlidableProvider provider){
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            child: Column(
              children: [
                Row(
                  children: [
                    Text('${index + 1}', style: TextStyle(fontSize: 14, color: ColorFamily.black, fontFamily: FontFamily.mapleStoryLight)),
                    SizedBox(width: 10),
                    Text('잠실역 2번 출구', style: TextStyle(fontSize: 14, color: ColorFamily.black, fontFamily: FontFamily.mapleStoryLight)),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(width: 20),
                    Text('맛집: 00카페\n영업시간: 10시~22시\n참고: https://www.naver.com', style: TextStyle(fontSize: 12, color: ColorFamily.black, fontFamily: FontFamily.mapleStoryLight)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
