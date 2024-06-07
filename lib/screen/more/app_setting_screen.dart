import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local_auth/local_auth.dart';
import 'package:woo_yeon_hi/widget/more/app_setting_top_app_bar.dart';

import '../../style/color.dart';
import '../../style/text_style.dart';
import '../register/register_screen.dart';
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
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: const AppSettingTopAppBar(),
        body: Container(
            width: deviceWidth,
            height: deviceHeight,
            padding: const EdgeInsets.all(20),
            color: ColorFamily.cream,
            child: Column(
              children: [
                SizedBox(
                    width: deviceWidth-40,
                    height: 60,
                    child: Material(
                      color: ColorFamily.cream,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("알림 받기",style: TextStyleFamily.smallTitleTextStyle),
                              Switch(
                                  value: _appNoticeActivated,
                                  activeColor: ColorFamily.white,
                                  activeTrackColor: ColorFamily.pink,
                                  inactiveThumbColor: ColorFamily.gray,
                                  inactiveTrackColor: ColorFamily.white,
                                  trackOutlineColor:
                                  _appNoticeActivated ? null : MaterialStateProperty.all(ColorFamily.gray),
                                  trackOutlineWidth: const MaterialStatePropertyAll(1),
                                  onChanged: (bool value) {
                                    setState(() {
                                      _appNoticeActivated = value;
                                    });
                                  }),
                            ],
                          ),
                          const SizedBox(
                            height: 0.5,
                            child: Divider(color: ColorFamily.gray, thickness: 0.5),
                          )
                        ],
                      ),
                    )
                ),
                SizedBox(
                    width: deviceWidth-40,
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
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("앱 잠금 설정",style: TextStyleFamily.smallTitleTextStyle),
                                SvgPicture.asset("lib/assets/icons/expand.svg")
                              ],
                            ),
                            const SizedBox(
                              height: 0.5,
                              child: Divider(color: ColorFamily.gray, thickness: 0.5),
                            )
                          ],
                        ),
                      ),
                    )
                ),
                SizedBox(
                    width: deviceWidth-40,
                    height: 60,
                    child: const Material(
                      color: ColorFamily.cream,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("앱 버전",style: TextStyleFamily.smallTitleTextStyle),
                              Text("v 1.0",style: TextStyleFamily.smallTitleTextStyle),
                            ],
                          ),
                          SizedBox(
                            height: 0.5,
                            child: Divider(color: ColorFamily.gray, thickness: 0.5),
                          )
                        ],
                      ),
                    )
                ),
                SizedBox(
                    width: deviceWidth-40,
                    height: 60,
                    child: Material(
                      color: ColorFamily.cream,
                      child: InkWell(
                        onTap: (){
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => const RegisterScreen()),
                                  (Route<dynamic> route) => false);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(height: 5),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: const Text("로그아웃",style: TextStyleFamily.smallTitleTextStyle),
                            ),
                            const SizedBox(
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
