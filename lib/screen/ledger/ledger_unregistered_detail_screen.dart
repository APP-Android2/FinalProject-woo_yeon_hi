import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/provider/ledger_provider.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/widget/ledger/ledger_top_app_bar.dart';
import 'package:woo_yeon_hi/widget/ledger/ledger_unregistered_detail_list_view.dart';

import '../../style/text_style.dart';
import '../../widget/ledger/ledger_dialog.dart';

class LedgerUnregisteredDetailScreen extends StatefulWidget {
  const LedgerUnregisteredDetailScreen({super.key});

  @override
  State<LedgerUnregisteredDetailScreen> createState() => _LedgerUnregisteredDetailScreenState();
}

class _LedgerUnregisteredDetailScreenState extends State<LedgerUnregisteredDetailScreen> {

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (context) => LedgerCheckBoxProvider(),
      child: Consumer<LedgerCheckBoxProvider>(
        builder: (context, provider, child) {
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
                          // 체크되지 않은 항목이 있는지 확인
                          if (provider.checkedItems.contains(false)) {
                            // 체크되지 않은 항목이 있으면 다이얼로그 표시
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return LedgerDialog('LedgerUnregisteredDetailScreen', '선택되지 않은 항목이 있습니다.', '선택되지 않은 항목은 삭제 됩니다.');
                              },
                            );
                          }else {
                            // 모든 아이템이 체크되어 있는 경우.
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return LedgerDialog('LedgerUnregisteredDetailScreen', '거래내역이 등록 되었습니다.', '가계부를 작성 하러 가보세요.');});}
                        },
                        //Navigator.pop(context);
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          height: 40,
                          alignment: Alignment.center,
                          child: Text(
                            "등록",
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
        },
      ),
    );
  }
}