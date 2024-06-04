import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/widget/ledger_list_view.dart';
import 'package:woo_yeon_hi/widget/ledger_top_app_bar.dart';

import '../style/text_style.dart';

class LedgerDetailScreen extends StatefulWidget {
  const LedgerDetailScreen({super.key});

  @override
  State<LedgerDetailScreen> createState() => _LedgerDetailScreenState();
}

class _LedgerDetailScreenState extends State<LedgerDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LedgerTopAppBar(
        title: '가계부 상세',
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset('lib/assets/icons/arrow_back.svg'),
        ),
      ),
      backgroundColor: ColorFamily.white,
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
              child: Text('5. 17.', style: TextStyle(color: ColorFamily.black, fontSize: 20, fontFamily: FontFamily.mapleStoryBold)),
            ),

            SizedBox(height: 30),

            // 아이템 항목
            LedgerListView(),

            // 작성 버튼
            Container(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: Material(
                color: ColorFamily.beige,
                elevation: 1,
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    child: Text(
                      "확인",
                      style: TextStyleFamily.normalTextStyle,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
