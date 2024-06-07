import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/screen/more/password_check_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/widget/more/app_lock_top_app_bar.dart';

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
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const AppLockSettingTopAppBar(),
      body: Container(
        width: deviceWidth,
        height: deviceHeight,
        padding: const EdgeInsets.all(20),
        color: ColorFamily.cream,
        child: Column(
          children: [
            SizedBox(height: deviceHeight * 0.1),
            const Text("비밀번호 입력",
                style: TextStyleFamily.passwordTextStyle),
            SizedBox(height: deviceHeight * 0.08),
            SizedBox(
              height: 50,
              width: deviceWidth*0.6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SvgPicture.asset("lib/assets/icons/woo_yeon_hi_48px.svg", width: 48, height: 48),
                  const SizedBox(width: 20),
                  SvgPicture.asset("lib/assets/icons/woo_yeon_hi_48px.svg", width: 48, height: 48),
                  const SizedBox(width: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: SvgPicture.asset("lib/assets/icons/password_bar_24px.svg", width: 24),
                  ),
                  const SizedBox(width: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: SvgPicture.asset("lib/assets/icons/password_bar_24px.svg", width: 24),
                  )
                ],
              ),
            ),
            SizedBox(height: deviceHeight*0.25),
            SizedBox(
              height: deviceHeight * 0.08,
              width: deviceWidth-40,
              child: Row(
                children: [
                  SizedBox(
                    height: deviceHeight * 0.08,
                    width: (deviceWidth-40)/3,
                    child: InkWell(
                      onTap: () {
                        print("1번 클릭됨");
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "1",
                          style: TextStyleFamily.passwordTextStyle,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: deviceHeight * 0.08,
                    width: (deviceWidth-40)/3,
                    child: InkWell(
                      onTap: () {
                        print("2번 클릭됨");
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "2",
                          style: TextStyleFamily.passwordTextStyle,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: deviceHeight * 0.08,
                    width: (deviceWidth-40)/3,
                    child: InkWell(
                      onTap: () {
                        print("3번 클릭됨");
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "3",
                          style: TextStyleFamily.passwordTextStyle,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: deviceHeight * 0.08,
              width: deviceWidth-40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: deviceHeight * 0.08,
                    width: (deviceWidth-40)/3,
                    child: InkWell(
                      onTap: () {
                        print("4번 클릭됨");
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "4",
                          style: TextStyleFamily.passwordTextStyle,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: deviceHeight * 0.08,
                    width: (deviceWidth-40)/3,
                    child: InkWell(
                      onTap: () {
                        print("5번 클릭됨");
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "5",
                          style: TextStyleFamily.passwordTextStyle,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: deviceHeight * 0.08,
                    width: (deviceWidth-40)/3,
                    child: InkWell(
                      onTap: () {
                        print("6번 클릭됨");
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "6",
                          style: TextStyleFamily.passwordTextStyle,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: deviceHeight * 0.08,
              width: deviceWidth-40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: deviceHeight * 0.08,
                    width: (deviceWidth-40)/3,
                    child: InkWell(
                      onTap: () {
                        print("7번 클릭됨");
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "7",
                          style: TextStyleFamily.passwordTextStyle,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: deviceHeight * 0.08,
                    width: (deviceWidth-40)/3,
                    child: InkWell(
                      onTap: () {
                        print("8번 클릭됨");
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "8",
                          style: TextStyleFamily.passwordTextStyle,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: deviceHeight * 0.08,
                    width: (deviceWidth-40)/3,
                    child: InkWell(
                      onTap: () {
                        print("9번 클릭됨");
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "9",
                          style: TextStyleFamily.passwordTextStyle,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: deviceHeight * 0.08,
              width: deviceWidth-40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: deviceHeight * 0.08,
                    width: (deviceWidth-40)/3,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => PasswordCheckScreen(widget.isBioAuthSupported)));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "",
                          style: TextStyleFamily.passwordTextStyle,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: deviceHeight * 0.08,
                    width: (deviceWidth-40)/3,
                    child: InkWell(
                      onTap: () {
                        print("0번 클릭됨");
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "0",
                          style: TextStyleFamily.passwordTextStyle,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: deviceHeight * 0.08,
                    width: (deviceWidth-40)/3,
                    child: InkWell(
                      onTap: () {
                        print("지우기 클릭됨");
                      },
                      child: Container(
                          alignment: Alignment.center,
                          child: SvgPicture.asset("lib/assets/icons/backspace.svg")
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}

//TODO 비밀번호 4자리 입력 완료시 PasswordCheckScreen으로 이동하면서 widget.isBioAuthSupporeted 넘겨주기
