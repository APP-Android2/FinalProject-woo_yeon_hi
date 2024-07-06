import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/dialogs.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/widget/login/account_processing_top_app_bar.dart';

import '../../dao/user_dao.dart';
import '../../provider/login_register_provider.dart';
import '../../style/font.dart';
import '../../style/text_style.dart';

class AccountProcessingScreen extends StatefulWidget {
  const AccountProcessingScreen({super.key});

  @override
  State<AccountProcessingScreen> createState() =>
      _AccountProcessingScreenState();
}

class _AccountProcessingScreenState extends State<AccountProcessingScreen> {
  final DateTime _accountDeletedDay = DateTime.now();
  final DateTime _cancelAvailableDay =
      DateTime.now().add(const Duration(days: 30));

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;

    return Consumer<UserProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: const AccountProcessingTopAppBar(),
        body: Container(
          width: deviceWidth,
          height: deviceHeight,
          padding: const EdgeInsets.all(20),
          color: ColorFamily.cream,
          child: Column(
            children: [
              SizedBox(height: deviceHeight * 0.05),
              Image.asset(
                'lib/assets/images/warning.png',
                height: 80,
              ),
              const SizedBox(height: 30),
              const Text("계정 삭제 진행중...",
                  style: TextStyle(
                      fontSize: 20,
                      color: ColorFamily.black,
                      fontFamily: FontFamily.mapleStoryLight)),
              const SizedBox(height: 50),
              const Text("삭제일로부터 30일 이내에 취소가 가능합니다.",
                  style: TextStyleFamily.smallTitleTextStyle),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("계정 삭제일자 :  ",
                      style: TextStyleFamily.normalTextStyle),
                  Text(DateFormat('yyyy. M. d.').format(_accountDeletedDay),
                      style: TextStyleFamily.smallTitleTextStyle),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("취소 가능일자 :  ",
                      style: TextStyleFamily.normalTextStyle),
                  Text(DateFormat('yyyy. M. d.').format(_cancelAvailableDay),
                      style: TextStyleFamily.smallTitleTextStyle),
                ],
              ),
              const SizedBox(height: 100),
              Material(
                color: ColorFamily.pink,
                elevation: 1,
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: InkWell(
                    onTap: () {
                      dialogTitleWithContent(context, "계정 삭제 취소", "보관된 데이터와 앱 설정으로 복구됩니다.", () {
                        Navigator.pop(context, false);
                      }, () async {
                        await updateSpecificUserData(
                        provider.userIdx,
                        'user_state',
                        0);
                        Navigator.pop(context, true);
                        Fluttertoast.showToast(
                            msg:
                            "계정 복구가 완료되었습니다.\n다시 로그인 해주세요.",
                            toastLength:
                            Toast.LENGTH_LONG,
                            gravity:
                            ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 3,
                            backgroundColor:
                            ColorFamily.black,
                            textColor:
                            ColorFamily.white,
                            fontSize: 14.0);
                      });
                    },
                    borderRadius: BorderRadius.circular(20.0),
                    child: SizedBox(
                        height: 40,
                        width: deviceWidth * 0.6,
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text("계정 삭제 취소",
                              style: TextStyleFamily.normalTextStyle),
                        ))),
              ),
            ],
          ),
        ),
      );
    });
  }
}
