import 'package:flutter/material.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';

class LedgerDialog extends StatefulWidget {
  const LedgerDialog({super.key});

  @override
  State<LedgerDialog> createState() => _LedgerDialogState();
}

class _LedgerDialogState extends State<LedgerDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Dialog(
        backgroundColor: ColorFamily.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        child: Container(
          width: 280,
          height: 163,
          margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: Column(
            //mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Top과 텍스트 높이
              SizedBox(height: 30),
              Text(
                '미등록 거래내역이 있습니다.',
                style: TextStyle(color: ColorFamily.black, fontSize: 16, fontFamily: FontFamily.mapleStoryLight),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15),
              Text(
                '이동 하시겠습니까?',
                style: TextStyle(color: ColorFamily.gray, fontSize: 12, fontFamily: FontFamily.mapleStoryLight),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        print('취소됨');
                        Navigator.of(context).pop();
                      },
                      child: Text('취소', style: TextStyle(color: ColorFamily.black, fontSize: 20, fontFamily: FontFamily.mapleStoryLight))
                  ),
                  SizedBox(width: 75),
                  TextButton(
                      onPressed: () {
                        print('확인됨');
                        Navigator.of(context).pop();
                      },
                      child: Text('확인', style: TextStyle(color: ColorFamily.pink, fontSize: 20, fontFamily: FontFamily.mapleStoryLight))
                  ),

                  // 버튼과 bottom의 높이
                  SizedBox(height: 20)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
