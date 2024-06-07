import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/text_style.dart';
import 'package:woo_yeon_hi/widget/dDay/dDay_add_list_view.dart';

import '../../widget/dDay/dDay_add_top_app_bar.dart';
import 'dDay_make_custom_screen.dart';

class dDayAddScreen extends StatefulWidget {
  const dDayAddScreen({super.key});

  @override
  State<dDayAddScreen> createState() => _dDayAddScreenState();
}

class _dDayAddScreenState extends State<dDayAddScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorFamily.cream,
      appBar: const dDayAddTopAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            //  커스텀 d-day 추가 버튼
            SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorFamily.beige),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const dDayMakeCustomScreen()));
                    },
                    child: const Text(
                      "커스텀 디데이 만들기",
                      style: TextStyleFamily.normalTextStyle,
                    ))),
            const Expanded(child: dDayAddListView())
          ],
        ),
      ),
    );
  }
}
