import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/widget/more/account_management_top_app_bar.dart';

import '../../style/font.dart';
import '../../style/text_style.dart';

class AccountManagementScreen extends StatelessWidget {
  const AccountManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AccountManagementTopAppBar(),
        body: Container(
            padding: EdgeInsets.all(20),
            color: ColorFamily.cream,
            child: Column(children: [
              Container(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        alignment: Alignment.centerLeft,
                        child: Text("로그인 계정 정보",
                            style: TextStyleFamily.smallTitleTextStyle),
                      ),
                      SizedBox(height: 10),
                      Container(
                        child: Material(
                            borderRadius: BorderRadius.circular(20),
                            color: ColorFamily.white,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.all(3),
                              height: 60,
                              child: Row(
                                children: [
                                  Container(
                                      padding: EdgeInsets.fromLTRB(10, 2, 0, 0),
                                      child: Text("구글 로그인",
                                          style: TextStyle(
                                              color: ColorFamily.black,
                                              fontFamily:
                                                  FontFamily.mapleStoryLight,
                                              fontSize: 12))),
                                  Container(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Text("googlegoogle1234@gmail.com",
                                          style:
                                              TextStyleFamily.normalTextStyle)),
                                ],
                              ),
                            )),
                      ),
                      SizedBox(height: 20),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          height: 60,
                          child: Material(
                            color: ColorFamily.cream,
                            child: InkWell(
                              onTap: () {
                                // Navigator.push(context, MaterialPageRoute(builder: (context) => TopBarUiSettingScreen(),));
                              },
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(height: 5),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("계정 삭제",
                                            style: TextStyleFamily
                                                .smallTitleTextStyle),
                                        SvgPicture.asset(
                                            "lib/assets/icons/expand.svg")
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 0.5,
                                    color: ColorFamily.pink,
                                    child: Divider(
                                        color: ColorFamily.gray,
                                        thickness: 0.5),
                                  )
                                ],
                              ),
                            ),
                          ))
                    ],
                  ))
            ])));
  }
}
