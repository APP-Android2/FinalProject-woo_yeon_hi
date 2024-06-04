import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/widget/more/account_processing_top_app_bar.dart';

import '../../style/font.dart';
import '../../style/text_style.dart';

class AccountProcessingScreen extends StatefulWidget {
  const AccountProcessingScreen({super.key});

  @override
  State<AccountProcessingScreen> createState() => _AccountProcessingScreenState();
}

class _AccountProcessingScreenState extends State<AccountProcessingScreen> {

  DateTime _accountDeletedDay = DateTime.now();
  DateTime _cancelAvailableDay = DateTime.now().add(Duration(days: 30));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AccountProcessingTopAppBar(),
      body: Container(
        padding: EdgeInsets.all(20),
        color: ColorFamily.cream,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(height: 30),
              Image.asset(
                'lib/assets/images/warning.png',
                height: 80,
              ),
              SizedBox(height: 30),
              Text("계정 삭제 진행중...", style: TextStyle(fontSize: 20,color: ColorFamily.black,fontFamily: FontFamily.mapleStoryLight)),
              SizedBox(height: 50),
              Text("삭제일로부터 30일 이내에 취소가 가능합니다.", style: TextStyleFamily.smallTitleTextStyle),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("계정 삭제일자 :  ", style: TextStyleFamily.normalTextStyle),
                Text(DateFormat('yyyy. M. d.').format(_accountDeletedDay), style: TextStyleFamily.smallTitleTextStyle),
              ],),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("취소 가능일자 :  ", style: TextStyleFamily.normalTextStyle),
                  Text(DateFormat('yyyy. M. d.').format(_cancelAvailableDay), style: TextStyleFamily.smallTitleTextStyle),
                ],),
              SizedBox(height: 100),
              Material(
                color: ColorFamily.pink,
                elevation: 1,
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(20.0),
                ),
                child: InkWell(
                    onTap: () {},
                    borderRadius:
                    BorderRadius.circular(20.0),
                    child: Container(
                        height: 40,
                        width: 160,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            "계정 삭제 취소",
                            style: TextStyle(fontFamily: FontFamily.mapleStoryLight, color: ColorFamily.black, fontSize: 14),
                          ),
                        ))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

