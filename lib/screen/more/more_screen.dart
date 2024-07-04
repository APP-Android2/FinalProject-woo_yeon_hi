import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/screen/more/app_setting_screen.dart';
import 'package:woo_yeon_hi/screen/more/daily_summary_screen.dart';
import 'package:woo_yeon_hi/screen/more/help_screen.dart';
import 'package:woo_yeon_hi/screen/more/profile_edit_screen.dart';
import 'package:woo_yeon_hi/screen/more/ui_style_setting_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/style/text_style.dart';
import '../../provider/login_register_provider.dart';
import '../../widget/more/more_top_app_bar.dart';
import 'account_management_screen.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {

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
                child:
                    Consumer<UserProvider>(builder: (context, provider, child) {
                  return Column(
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
                                onTap: () {
                                  provider.image != null
                                      ? showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Dialog(
                                              child: Container(
                                                width: deviceWidth * 0.8,
                                                height: deviceHeight * 0.6,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: FileImage(File(
                                                        provider.image!.path)),
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ),
                                            );
                                          })
                                      : null;
                                },
                                borderRadius: BorderRadius.circular(65),
                                splashColor: Colors.transparent,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(65),
                                  child: provider.image != null
                                      ? Image.file(File(provider.image!.path),
                                          width: deviceWidth * 0.35,
                                          height: deviceWidth * 0.35,
                                          fit: BoxFit.cover)
                                      : Image.asset(
                                          provider.userProfileImage,
                                          width: deviceWidth * 0.35,
                                          height: deviceWidth * 0.35,
                                        ),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(provider.userNickname,
                                          style: const TextStyle(
                                              color: ColorFamily.black,
                                              fontSize: 16,
                                              fontFamily:
                                                  FontFamily.mapleStoryBold)),
                                      InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const ProfileEditScreen()))
                                                .then(
                                                    (value) => setState(() {}));
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
                                  const SizedBox(height: 15),
                                  SizedBox(
                                      width: deviceWidth * 0.4,
                                      child: Text(provider.profileMsg,
                                          style: const TextStyle(
                                              color: ColorFamily.black,
                                              fontSize: 12,
                                              fontFamily:
                                                  FontFamily.mapleStoryLight),
                                          maxLines: 4))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: deviceHeight * 0.05),
                      _buildMenuItem(
                          context,
                          '추억 모아보기',
                          'lib/assets/icons/box.svg',
                          const DailySummaryScreen()),
                      const SizedBox(height: 10),
                      _buildMenuItem(
                          context,
                          '화면 스타일 설정',
                          'lib/assets/icons/magicpen.svg',
                          const UiStyleSettingScreen()),
                      const SizedBox(height: 10),
                      _buildMenuItem(
                          context,
                          '도움말',
                          'lib/assets/icons/message-question.svg',
                          const HelpScreen()),
                      const SizedBox(height: 10),
                      _buildMenuItem(
                          context,
                          '계정 관리',
                          'lib/assets/icons/user_edit.svg',
                          const AccountManagementScreen()),
                      const SizedBox(height: 10),
                      _buildMenuItem(
                          context,
                          '앱 설정',
                          'lib/assets/icons/setting.svg',
                          const AppSettingScreen()),
                    ],
                  );
                })));
  }
}

Widget _buildMenuItem(
    BuildContext context, String title, String iconPath, Widget screen) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Material(
        color: ColorFamily.white,
        elevation: 1,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: InkWell(
          splashFactory: NoSplash.splashFactory,
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => screen));
          },
          borderRadius: BorderRadius.circular(10.0),
          child: SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: SvgPicture.asset(iconPath, width: 24, height: 24),
                  ),
                  Text(title, style: TextStyleFamily.normalTextStyle),
                  Container(
                      margin: const EdgeInsets.only(right: 10),
                      height: 24,
                      width: 24)
                ],
              )),
        )),
  );
}
