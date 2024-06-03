import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:woo_yeon_hi/screen/more/app_lock_setting_screen.dart';
import 'package:woo_yeon_hi/screen/more/password_check_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/widget/more/app_lock_top_app_bar.dart';

import '../../style/font.dart';
import '../../style/text_style.dart';

class PasswordSettingScreen extends StatefulWidget {
  final bool isBioAuthSupported;

  const PasswordSettingScreen(this.isBioAuthSupported, {super.key});

  @override
  State<PasswordSettingScreen> createState() => _PasswordSettingScreenState();
}

class _PasswordSettingScreenState extends State<PasswordSettingScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppLockSettingTopAppBar(),
      body: Container(
        padding: EdgeInsets.all(20),
        color: ColorFamily.cream,
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 170)),
            Container(
                child: Text("비밀번호 입력",
                    style: TextStyleFamily.passwordTextStyle)),
            Padding(padding: EdgeInsets.only(top: 75)),
            Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 50,
                    child:
                    SvgPicture.asset("lib/assets/icons/woo_yeon_hi_48px.svg"),
                  ),
                  Padding(padding: EdgeInsets.only(right: 20)),
                  Container(
                    alignment: Alignment.center,
                    width: 50,
                    child:
                    SvgPicture.asset("lib/assets/icons/woo_yeon_hi_48px.svg"),
                  ),
                  Padding(padding: EdgeInsets.only(right: 20)),
                  Container(
                    alignment: Alignment.center,
                    width: 50,
                    child:
                    SvgPicture.asset("lib/assets/icons/password_bar_24px.svg"),
                  ),
                  Padding(padding: EdgeInsets.only(right: 20)),
                  Container(
                    alignment: Alignment.center,
                    width: 50,
                    child:
                    SvgPicture.asset("lib/assets/icons/password_bar_24px.svg"),
                  ),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 210)),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PasswordCheckScreen(widget.isBioAuthSupported)));
                        },
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          alignment: Alignment.center,
                          width: 60,
                          height: 30,
                          child: Text(
                            "1",
                            style: TextStyleFamily.passwordTextStyle,
                          ),
                        ),
                      )),
                  Padding(padding: EdgeInsets.only(right: 50)),
                  Expanded(
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(0.0),
                        child: Container(
                          alignment: Alignment.center,
                          width: 60,
                          height: 30,
                          child: Text(
                            "2",
                            style: TextStyleFamily.passwordTextStyle,
                          ),
                        ),
                      )),
                  Padding(padding: EdgeInsets.only(right: 50)),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(0.0),
                      child: Container(
                        alignment: Alignment.center,
                        width: 60,
                        height: 30,
                        child: Text(
                          "3",
                          style: TextStyleFamily.passwordTextStyle,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 35)),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  Expanded(
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(0.0),
                        child: Container(
                          alignment: Alignment.center,
                          width: 60,
                          height: 30,
                          child: Text(
                            "4",
                            style: TextStyleFamily.passwordTextStyle,
                          ),
                        ),
                      )),
                  Padding(padding: EdgeInsets.only(right: 50)),
                  Expanded(
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(0.0),
                        child: Container(
                          alignment: Alignment.center,
                          width: 60,
                          height: 30,
                          child: Text(
                            "5",
                            style: TextStyleFamily.passwordTextStyle,
                          ),
                        ),
                      )),
                  Padding(padding: EdgeInsets.only(right: 50)),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(0.0),
                      child: Container(
                        alignment: Alignment.center,
                        width: 60,
                        height: 30,
                        child: Text(
                          "6",
                          style: TextStyleFamily.passwordTextStyle,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 35)),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  Expanded(
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(0.0),
                        child: Container(
                          alignment: Alignment.center,
                          width: 60,
                          height: 30,
                          child: Text(
                            "7",
                            style: TextStyleFamily.passwordTextStyle,
                          ),
                        ),
                      )),
                  Padding(padding: EdgeInsets.only(right: 50)),
                  Expanded(
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(0.0),
                        child: Container(
                          alignment: Alignment.center,
                          width: 60,
                          height: 30,
                          child: Text(
                            "8",
                            style: TextStyleFamily.passwordTextStyle,
                          ),
                        ),
                      )),
                  Padding(padding: EdgeInsets.only(right: 50)),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(0.0),
                      child: Container(
                        alignment: Alignment.center,
                        width: 60,
                        height: 30,
                        child: Text(
                          "9",
                          style: TextStyleFamily.passwordTextStyle,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 35)),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  Expanded(
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(0.0),
                        child: Container(
                          alignment: Alignment.center,
                          width: 60,
                          height: 30,
                          child: Text(
                            "",
                            style: TextStyleFamily.passwordTextStyle,
                          ),
                        ),
                      )),
                  Padding(padding: EdgeInsets.only(right: 50)),
                  Expanded(
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(0.0),
                        child: Container(
                          alignment: Alignment.center,
                          width: 60,
                          height: 30,
                          child: Text(
                            "0",
                            style: TextStyleFamily.passwordTextStyle,
                          ),
                        ),
                      )),
                  Padding(padding: EdgeInsets.only(right: 50)),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(0.0),
                      child: Container(
                        alignment: Alignment.center,
                        width: 60,
                        height: 30,
                        child: SvgPicture.asset("lib/assets/icons/backspace.svg"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//TODO 비밀번호 4자리 입력 완료시 PasswordCheckScreen으로 이동하면서 widget.isBioAuthSupporeted 넘겨주기