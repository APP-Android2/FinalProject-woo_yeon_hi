import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/provider/ledger_check_box_provider.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/widget/ledger_dialog.dart';
import 'package:woo_yeon_hi/widget/ledger_top_app_bar.dart';
import 'package:woo_yeon_hi/widget/ledger_unregistered_detail_list_view.dart';

import '../style/text_style.dart';

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
  }
}