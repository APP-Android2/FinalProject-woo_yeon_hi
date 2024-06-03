import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local_auth/local_auth.dart';
import 'package:woo_yeon_hi/widget/more/app_setting_top_app_bar.dart';

import '../../style/color.dart';
import '../../style/text_style.dart';
import 'app_lock_setting_screen.dart';

class AppSettingScreen extends StatefulWidget {
  const AppSettingScreen({super.key});

  @override
  State<AppSettingScreen> createState() => _AppSettingScreenState();
}

class _AppSettingScreenState extends State<AppSettingScreen> {

  final LocalAuthentication auth = LocalAuthentication();

  var _appNoticeActivated = false;
  late bool _isBioAuthSupported;

  @override
  void initState() {
    super.initState();
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(() => _isBioAuthSupported = isSupported),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppSettingTopAppBar(),
        body: Container(
            padding: EdgeInsets.all(20),
            color: ColorFamily.cream,
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 60,
                    child: Material(
                      color: ColorFamily.cream,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(height: 5),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("알림 받기",style: TextStyleFamily.smallTitleTextStyle),
                                Switch(
                                    value: _appNoticeActivated,
                                    activeColor: ColorFamily.white,
                                    activeTrackColor: ColorFamily.pink,
                                    inactiveThumbColor: ColorFamily.gray,
                                    inactiveTrackColor: ColorFamily.white,
                                    trackOutlineWidth: MaterialStatePropertyAll(0.5),
                                    onChanged: (bool value) {
                                      setState(() {
                                        _appNoticeActivated = value;
                                      });
                                    }),
                              ],
                            ),
                          ),
                          Container(
                            height: 0.5,
                            child: Divider(color: ColorFamily.gray, thickness: 0.5),
                          )
                        ],
                      ),
                    )
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 60,
                    child: Material(
                      color: ColorFamily.cream,
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AppLockSettingScreen(isBioAuthSupported: _isBioAuthSupported)));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(height: 5),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("앱 잠금 설정",style: TextStyleFamily.smallTitleTextStyle),
                                  SvgPicture.asset("lib/assets/icons/expand.svg")
                                ],
                              ),
                            ),
                            Container(
                              height: 0.5,
                              child: Divider(color: ColorFamily.gray, thickness: 0.5),
                            )
                          ],
                        ),
                      ),
                    )
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 60,
                    child: Material(
                      color: ColorFamily.cream,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(height: 5),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("앱 버전",style: TextStyleFamily.smallTitleTextStyle),
                                Text("v 1.0",style: TextStyleFamily.smallTitleTextStyle),
                              ],
                            ),
                          ),
                          Container(
                            height: 0.5,
                            child: Divider(color: ColorFamily.gray, thickness: 0.5),
                          )
                        ],
                      ),
                    )
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 60,
                    child: Material(
                      color: ColorFamily.cream,
                      child: InkWell(
                        onTap: (){
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(height: 5),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text("로그아웃",style: TextStyleFamily.smallTitleTextStyle),
                            ),
                            Container(
                              height: 0.5,
                              child: Divider(color: ColorFamily.gray, thickness: 0.5),
                            )
                          ],
                        ),
                      ),
                    )
                ),
              ],
            )
        ) );
  }
}
