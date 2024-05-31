import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/provider/ledger_check_box_provider.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/widget/ledger_dialog.dart';
import 'package:woo_yeon_hi/widget/ledger_top_app_bar.dart';
import 'package:woo_yeon_hi/widget/ledger_unregistered_detail_list_view.dart';

class LedgerUnregisteredDetailScreen extends StatefulWidget {
  const LedgerUnregisteredDetailScreen({super.key});

  @override
  State<LedgerUnregisteredDetailScreen> createState() => _LedgerUnregisteredDetailScreenState();
}

class _LedgerUnregisteredDetailScreenState extends State<LedgerUnregisteredDetailScreen> {

  @override
  Widget build(BuildContext context) {

    // Provider를 가져온다.
    var ledgerCheckBoxProvider = Provider.of<LedgerCheckBoxProvider>(context);

    return Scaffold(
      appBar: LedgerTopAppBar(
        title: '미등록 거래내역',
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
            Expanded(
              child: LedgerUnregisteredDetailListView(),
            ),

            // 등록 버튼
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
                onPressed: () {
                  // 체크되지 않은 항목이 있는지 확인
                  if (ledgerCheckBoxProvider.checkedItems.contains(false)) {
                    // 체크되지 않은 항목이 있으면 다이얼로그 표시
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return LedgerDialog('LedgerUnregisteredDetailScreen', '선택되지 않은 항목이 있습니다.', '선택되지 않은 항목은 삭제 됩니다.');
                      },
                    );
                  } else {
                    // 모든 아이템이 체크되어 있는 경우.
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return LedgerDialog('LedgerUnregisteredDetailScreen', '거래내역이 등록 되었습니다.', '가계부를 작성 하러 가보세요.');
                      },
                    );
                  }
                },
                child: Text('등록'),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    minimumSize: Size(double.maxFinite, 50),
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