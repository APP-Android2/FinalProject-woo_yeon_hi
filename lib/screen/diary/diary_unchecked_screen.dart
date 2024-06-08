import 'package:flutter/material.dart';
import 'package:woo_yeon_hi/model/diary_model.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/text_style.dart';

class DiaryUncheckedScreen extends StatefulWidget {
  DiaryUncheckedScreen(this.unCheckedDiary, {super.key});
  Diary unCheckedDiary;

  @override
  State<DiaryUncheckedScreen> createState() => _DiaryUncheckedScreenState();
}

class _DiaryUncheckedScreenState extends State<DiaryUncheckedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorFamily.cream,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width - 40,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("우연녀", style: TextStyleFamily.appBarTitleBoldTextStyle,),
                  Text("님이",style: TextStyleFamily.normalTextStyle,)
                ],
              ),
            ),
            const Text("작성한 일기가 도착했습니다!", style: TextStyleFamily.normalTextStyle,),
            const SizedBox(height: 70,),
            Image.asset('lib/assets/images/diary_arrived.gif')
          ],
        ),
      ),
    );
  }
}
