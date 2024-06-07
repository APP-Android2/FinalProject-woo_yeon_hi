import 'package:flutter/material.dart';
import 'package:woo_yeon_hi/screen/footPrint/footprint_history_detail_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/text_style.dart';

import '../../model/dDay_model.dart';
import '../../style/font.dart';

class dDayListView extends StatefulWidget {
  const dDayListView({super.key});

  @override
  State<dDayListView> createState() => _dDayListViewState();
}

class _dDayListViewState extends State<dDayListView> {
  List<dDayModel> dDayList = [
    dDayModel(title: "연애 D+", content: "오래오래 가자", count: "100일 째", date: "2024. 3.01. ~"),
    dDayModel(title: "생일", content: "우연녀 생일", count: "D-100", date: "2024. 8.25.(일)"),
    dDayModel(title: "200일", content: "만난지 200일 ♥️", count: "D-100", date: "2024. 8.25. (일)"),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView.builder(
        itemCount: dDayList.length,
          itemBuilder: (context, index) => _makedDayItem(index)
      ),
    );
  }
  Widget _makedDayItem(int index){
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 40,
        child: Wrap(
          children: [
            Card(
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(
                  children: [
                    // title, count
                    SizedBox(
                        width: MediaQuery.of(context).size.width - 40 - 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(dDayList[index].title, style: dDayTitleTextStyle,),
                            Text(dDayList[index].count, style: dDayCountTextStyle,)
                          ],
                        )
                    ),
                    const SizedBox(height: 20,),
                    // content, date
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 40 - 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(dDayList[index].content, style: dDayContentTextStyle,),
                            Text(dDayList[index].date, style: dDayDateTextStyle,)
                          ],
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


TextStyle dDayTitleTextStyle = const TextStyle(
    fontFamily: FontFamily.mapleStoryLight,
    fontSize: 20,
    color: ColorFamily.black
);

TextStyle dDayContentTextStyle = const TextStyle(
    fontFamily: FontFamily.mapleStoryLight,
    fontSize: 14,
    color: ColorFamily.gray
);

TextStyle dDayCountTextStyle = const TextStyle(
    fontFamily: FontFamily.mapleStoryBold,
    fontSize: 20,
    color: ColorFamily.pink
);
TextStyle dDayDateTextStyle = const TextStyle(
    fontFamily: FontFamily.mapleStoryLight,
    fontSize: 14,
    color: ColorFamily.gray
);
