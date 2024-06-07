import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woo_yeon_hi/screen/more/app_setting_screen.dart';
import 'package:woo_yeon_hi/screen/more/daily_summary_screen.dart';
import 'package:woo_yeon_hi/screen/more/help_screen.dart';
import 'package:woo_yeon_hi/screen/more/profile_edit_screen.dart';
import 'package:woo_yeon_hi/screen/more/ui_style_setting_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/style/text_style.dart';
import '../../widget/more/more_top_app_bar.dart';
import 'account_management_screen.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreen();
}

class _MoreScreen extends State<MoreScreen> {
  late String userName;
  late String userNickName;
  late String profileMsg;

  @override
  void initState() {
    super.initState();

    userName = "김멋사"; // 유저 이름 가져오기
    userNickName = "멋쟁이사자"; // 유저 닉네임 가져오기
    profileMsg = "너와 함께할 때 가장 행복해!"; // 유저 상태 메시지 가져오기
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const MoreTopAppBar(),
      body: Container(
        height: deviceHeight,
        width: deviceWidth,
        padding: const EdgeInsets.all(20),
        color: ColorFamily.cream,
        child: Column(
          children: [
            SizedBox(height: deviceHeight * 0.02),
            SizedBox(
              width: deviceWidth - 40,
              child: Row(
                children: [
                  Material(
                    elevation: 1,
                    borderRadius: BorderRadius.circular(65),
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(65),
                      splashColor: Colors.transparent,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(65),
                        child: Image.asset(
                          'lib/assets/images/default_profile.png',
                          width: deviceWidth * 0.35,
                          height: deviceWidth * 0.35,
                        ), // Text(key['title']),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    height: deviceWidth * 0.3,
                    width: deviceWidth * 0.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(userNickName,
                                style: const TextStyle(
                                    color: ColorFamily.black,
                                    fontSize: 16,
                                    fontFamily: FontFamily.mapleStoryBold)),
                            InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ProfileEditScreen()));
                                },
                                child: SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: SvgPicture.asset(
                                      'lib/assets/icons/expand.svg',
                                      fit: BoxFit.none,
                                    )))
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                            width: deviceWidth * 0.4,
                            child:  Text(profileMsg,
                                style: const TextStyle(
                                    color: ColorFamily.black,
                                    fontSize: 12,
                                    fontFamily: FontFamily.mapleStoryLight),
                                maxLines: 3))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: deviceHeight * 0.05),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Material(
                  color: ColorFamily.white,
                  elevation: 1,
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const DailySummaryScreen()));
                    },
                    borderRadius: BorderRadius.circular(10.0),
                    child: SizedBox(
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: SvgPicture.asset(
                                  'lib/assets/icons/box.svg',
                                  width: 24,
                                  height: 24),
                            ),
                            const Text("추억 모아보기",
                                style: TextStyleFamily.normalTextStyle),
                            Container(
                                margin: const EdgeInsets.only(right: 10),
                                height: 24,
                                width: 24)
                          ],
                        )),
                  )),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Material(
                  color: ColorFamily.white,
                  elevation: 1,
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UiStyleSettingScreen(),
                          ));
                    },
                    borderRadius: BorderRadius.circular(10.0),
                    child: SizedBox(
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: SvgPicture.asset(
                                  'lib/assets/icons/magicpen.svg',
                                  width: 24,
                                  height: 24),
                            ),
                            const Text("화면 스타일 설정",
                                style: TextStyleFamily.normalTextStyle),
                            Container(
                                margin: const EdgeInsets.only(right: 10),
                                height: 24,
                                width: 24)
                          ],
                        )),
                  )),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Material(
                  color: ColorFamily.white,
                  elevation: 1,
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HelpScreen()));
                    },
                    borderRadius: BorderRadius.circular(10.0),
                    child: SizedBox(
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: SvgPicture.asset(
                                  'lib/assets/icons/message-question.svg'),
                            ),
                            const Text("도움말",
                                style: TextStyleFamily.normalTextStyle),
                            Container(
                                margin: const EdgeInsets.only(right: 10),
                                height: 24,
                                width: 24)
                          ],
                        )),
                  )),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Material(
                  color: ColorFamily.white,
                  elevation: 1,
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const AccountManagementScreen()));
                    },
                    borderRadius: BorderRadius.circular(10.0),
                    child: SizedBox(
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: SvgPicture.asset(
                                  'lib/assets/icons/user_edit.svg'),
                            ),
                            const Text("계정 관리",
                                style: TextStyleFamily.normalTextStyle),
                            Container(
                                margin: const EdgeInsets.only(right: 10),
                                height: 24,
                                width: 24)
                          ],
                        )),
                  )),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Material(
                  color: ColorFamily.white,
                  elevation: 1,
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AppSettingScreen()));
                    },
                    borderRadius: BorderRadius.circular(10.0),
                    child: SizedBox(
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: SvgPicture.asset(
                                  'lib/assets/icons/setting.svg'),
                            ),
                            const Text("앱 설정",
                                style: TextStyleFamily.normalTextStyle),
                            Container(
                                margin: const EdgeInsets.only(right: 10),
                                height: 24,
                                width: 24)
                          ],
                        )),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
