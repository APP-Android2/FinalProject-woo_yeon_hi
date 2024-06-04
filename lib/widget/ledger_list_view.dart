import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/widget/ledger_modal_bottom_sheet.dart';

class LedgerListView extends StatefulWidget {
  const LedgerListView({super.key});

  @override
  State<LedgerListView> createState() => _LedgerListViewState();
}

class _LedgerListViewState extends State<LedgerListView> {

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return makeListItem();
          },
        ),
    );
  }

  // 리스트뷰 항목 하나를 구성
  Widget makeListItem(){
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset('lib/assets/icons/coffee_cup.svg'),
                  SizedBox(width: 10),
                  Text('스타벅스코리아', style: TextStyle(fontSize: 14, color: ColorFamily.black, fontFamily: FontFamily.mapleStoryLight)),
                ],
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return LedgerModalBottomSheet();
                        },
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: SvgPicture.asset('lib/assets/icons/horizontal_more.svg'),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 15),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('일시', style: TextStyle(fontSize: 14, color: ColorFamily.black, fontFamily: FontFamily.mapleStoryLight)),
              Text('2024. 5. 17.(월) 12:30', style: TextStyle(fontSize: 14, color: ColorFamily.black, fontFamily: FontFamily.mapleStoryLight)),
            ],
          ),
          SizedBox(height: 15),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('금액', style: TextStyle(fontSize: 14, color: ColorFamily.black, fontFamily: FontFamily.mapleStoryLight)),
              Text('-11,500원', style: TextStyle(fontSize: 14, color: ColorFamily.black, fontFamily: FontFamily.mapleStoryLight)),
            ],
          ),
          SizedBox(height: 15),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('메모', style: TextStyle(fontSize: 14, color: ColorFamily.black, fontFamily: FontFamily.mapleStoryLight)),
              Text('아아 먹었음', style: TextStyle(fontSize: 14, color: ColorFamily.black, fontFamily: FontFamily.mapleStoryLight)),
            ],
          ),
          SizedBox(height: 15),
          // 구분 선
          Divider(),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
