import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woo_yeon_hi/screen/ledger/ledger_edit_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/style/text_style.dart';
import 'package:woo_yeon_hi/widget/ledger/ledger_dialog.dart';

class LedgerModalBottomSheet extends StatefulWidget {
  const LedgerModalBottomSheet({super.key});

  @override
  State<LedgerModalBottomSheet> createState() => _LedgerModalBottomSheetState();
}

class _LedgerModalBottomSheetState extends State<LedgerModalBottomSheet> {
  @override
  Widget build(BuildContext context) {
    // 현재 화면의 높이를 가져옵니다.
    // double screenHeight = MediaQuery.of(context).size.height;

    // BottomSheet의 높이를 화면 높이의 20%로 설정합니다.
    // double bottomSheetHeight = screenHeight * 0.2;

    return Wrap(
      children: [
        Column(
          children: [
            InkWell(
              splashColor: ColorFamily.gray.withOpacity(0.5),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LedgerEditScreen(),
                    )
                );
                FocusScope.of(context).unfocus();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                height: 70,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset('lib/assets/icons/edit.svg', width: 24, height: 24),
                    const Text(
                      "수정",
                      style: TextStyleFamily.smallTitleTextStyle,
                    ),
                    const SizedBox(
                      width: 24,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 0.5,
              child: Divider(
                color: ColorFamily.gray,
                thickness: 0.5,
              ),
            ),
            InkWell(
              splashColor: ColorFamily.gray.withOpacity(0.5),
              onTap: () {
                setState(() {
                  Navigator.pop(context);
                  FocusScope.of(context).unfocus();
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                height: 70,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset('lib/assets/icons/delete.svg', color: ColorFamily.pink, width: 24, height: 24),
                    const Text(
                      "삭제",
                      style: TextStyleFamily.smallTitleTextStyle_pink,
                    ),
                    const SizedBox(
                      width: 24,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );

    /*
    return Container(
      height: bottomSheetHeight,
      //color: Colors.white,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),

      child: Column(
        children: [
          // 핸들바
          Container(
            width: 32,
            height: 4,
            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(5),
            ),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(35, 30, 35, 20),
            child: Material(
              color: Colors.transparent,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => LedgerEditScreen(),
                        ),
                      );

                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset('lib/assets/icons/edit.svg', width: 24, height: 24),
                        Text('수정', style: TextStyle(color: ColorFamily.black, fontSize: 20, fontFamily: FontFamily.mapleStoryLight)),
                        SizedBox(width: 24)
                      ],
                    ),
                  ),
                  //SizedBox(height: 20),
                ],
              ),
            ),
          ),
          Divider(height: 0.5),
          Padding(
            padding: EdgeInsets.fromLTRB(35, 20, 35, 0),
            child: Material(
              color: Colors.transparent,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      // 삭제 버튼 클릭 시 다이얼로그 표시
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return LedgerDialog('LedgerModalBottomSheet', '해당 항목을 삭제 하시겠습니까?', '다시 복구 되지 않습니다.');
                        },
                      );

                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset('lib/assets/icons/delete.svg', color: ColorFamily.pink, width: 24, height: 24),
                        Text('삭제', style: TextStyle(color: ColorFamily.pink, fontSize: 20, fontFamily: FontFamily.mapleStoryLight)),
                        SizedBox(width: 24)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    */
  }
}
