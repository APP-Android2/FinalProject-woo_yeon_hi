import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/widget/ledger_List_view.dart';
import 'package:woo_yeon_hi/widget/ledger_top_app_bar.dart';

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

            Padding(padding: EdgeInsets.only(bottom: 30)),

            // 아이템 항목
            LedgerListView(),

            // 작성 버튼
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    // 그림자 색상
                    color: Colors.black.withOpacity(0.3),
                    // 그림자 오프셋 (x, y)
                    offset: Offset(0, 4),
                    // 그림자 흐림 반경
                    blurRadius: 6,
                    // 그림자 확산 반경
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text('확인'),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    minimumSize: Size(300, 50),
                    alignment: Alignment.center,
                    textStyle: TextStyle(fontSize: 14, fontFamily: FontFamily.mapleStoryLight),
                    backgroundColor: ColorFamily.beige,
                    foregroundColor: ColorFamily.black
                ),
              ),
            ),
            SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}
