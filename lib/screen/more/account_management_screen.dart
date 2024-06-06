import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:woo_yeon_hi/screen/more/account_delete_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/widget/more/account_management_top_app_bar.dart';

import '../../style/font.dart';
import '../../style/text_style.dart';

class AccountManagementScreen extends StatelessWidget {
  const AccountManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: const AccountManagementTopAppBar(),
        body: Container(
            width: deviceWidth,
            height: deviceHeight,
            padding: const EdgeInsets.all(20),
            color: ColorFamily.cream,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 15),
                  alignment: Alignment.centerLeft,
                  child: const Text("로그인 계정 정보",
                      style: TextStyleFamily.smallTitleTextStyle),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: deviceWidth-40,
                  child: Material(
                      borderRadius: BorderRadius.circular(20),
                      color: ColorFamily.white,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(3),
                        height: 60,
                        child: Row(
                          children: [
                            Container(
                                padding: const EdgeInsets.fromLTRB(10, 2, 0, 0),
                                child: const Text("구글 로그인",
                                    style: TextStyle(
                                        color: ColorFamily.black,
                                        fontFamily:
                                            FontFamily.mapleStoryLight,
                                        fontSize: 12))),
                            const SizedBox(width: 20),
                            const Text("googlegoogle1234@gmail.com",
                                style:
                                    TextStyleFamily.normalTextStyle),
                          ],
                        ),
                      )),
                ),
                const SizedBox(height: 20),
                SizedBox(
                    width: deviceWidth-40,
                    height: 60,
                    child: Material(
                      color: ColorFamily.cream,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const AccountDeleteScreen()));
                        },
                        child: Column(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("계정 삭제",
                                    style: TextStyleFamily
                                        .smallTitleTextStyle),
                                SvgPicture.asset(
                                    "lib/assets/icons/expand.svg")
                              ],
                            ),
                            const SizedBox(
                              height: 0.5,
                              child: Divider(
                                  color: ColorFamily.gray,
                                  thickness: 0.5),
                            )
                          ],
                        ),
                      ),
                    ))
              ],
            )));
  }
}
