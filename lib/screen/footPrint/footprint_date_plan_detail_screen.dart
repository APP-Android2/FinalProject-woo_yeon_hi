import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/provider/footprint_provider.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/style/text_style.dart';
import 'package:woo_yeon_hi/widget/footPrint/footprint_date_plan_top_app_bar.dart';

class FootprintDatePlanDetailScreen extends StatefulWidget {
  FootprintDatePlanDetailScreen(this.provider, {super.key});
  FootPrintDatePlanSlidableProvider provider;
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
            padding: const EdgeInsets.only(right: 15),
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
      body: ListView.builder(
        itemCount: widget.provider.planList.length,
        itemBuilder: (context, index) {
          print(widget.provider.planedList.toString());
          final item = widget.provider.planList[index];
          return Column(
            children: [
              makeListView(item, index),
              Divider(),
            ],
          );
        },
      )

    );
  }

  Widget makeListView(Map<String, dynamic> item, int index){
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          child: Column(
            children: [
              Row(
                children: [
                  Text('${index + 1}', style: TextStyleFamily.normalTextStyle),
                  const SizedBox(width: 10),
                  Text(item['planed_place_name'], style: TextStyleFamily.normalTextStyle),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const SizedBox(width: 20),
                  Text(item['planed_place_memo'], style: TextStyleFamily.normalTextStyle),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
