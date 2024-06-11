import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/widget/more/app_setting_top_app_bar.dart';

import '../../dao/user_dao.dart';
import '../../model/enums.dart';
import '../../model/user_model.dart';
import '../../style/color.dart';
import '../../style/text_style.dart';
import '../login/login_screen.dart';
import 'app_lock_setting_screen.dart';

class AppSettingScreen extends StatefulWidget {
  const AppSettingScreen({super.key});

  @override
  State<AppSettingScreen> createState() => _AppSettingScreenState();
}

class _AppSettingScreenState extends State<AppSettingScreen> {
  static const storage =
      FlutterSecureStorage(); //flutter_secure_storage 사용을 위한 초기화 작업
  late String userAccount = "";
  late bool alarmsAllow = false;
  late int loginType = 0;

  final LocalAuthentication auth = LocalAuthentication();

  late bool _isBioAuthSupported;
  late bool switchValue = false;
  bool _isLoading = true; // Loading 상태를 나타내는 변수

  @override
  void initState() {
    super.initState();
    auth.isDeviceSupported().then(
          (bool isSupported) =>
              setState(() => _isBioAuthSupported = isSupported),
        );
    _asyncMethod();
  }

  Future<void> _asyncMethod() async {
    userAccount = (await storage.read(key: "loginAccount"))!;
    alarmsAllow = await getSpecificUserData(userAccount, 'alarms_allow');
    loginType = await getSpecificUserData(userAccount, 'login_type');

    setState(() {
      switchValue = alarmsAllow; // homePresetType을 가져온 후에 presetIndex 설정
      _isLoading = false; // 데이터 로드가 완료되면 로딩 상태를 false로 설정
    });
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;

    if (_isLoading) {
      // 로딩 중인 상태를 표시
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
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
                      width: deviceWidth - 40,
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
                                const Text("알림 받기",
                                    style: TextStyleFamily.smallTitleTextStyle),
                                Switch(
                                    value: switchValue,
                                    activeColor: ColorFamily.white,
                                    activeTrackColor: ColorFamily.pink,
                                    inactiveThumbColor: ColorFamily.gray,
                                    inactiveTrackColor: ColorFamily.white,
                                    trackOutlineColor: switchValue
                                        ? MaterialStateProperty.all(
                                            Colors.transparent)
                                        : MaterialStateProperty.all(
                                            ColorFamily.gray),
                                    trackOutlineWidth:
                                        const MaterialStatePropertyAll(1),
                                    onChanged: (bool value) async {
                                      setState(() {
                                        switchValue = value;
                                      });
                                      await updateUserData(userAccount, 'alarms_allow', switchValue);
                                    }),
                              ],
                            ),
                            const SizedBox(
                              height: 0.5,
                              child: Divider(
                                  color: ColorFamily.gray, thickness: 0.5),
                            )
                          ],
                        ),
                      )),
                  SizedBox(
                      width: deviceWidth - 40,
                      height: 60,
                      child: Material(
                        color: ColorFamily.cream,
                        child: InkWell(
                          splashFactory: NoSplash.splashFactory,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AppLockSettingScreen(
                                        bioAuth: _isBioAuthSupported)));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("앱 잠금 설정",
                                      style:
                                          TextStyleFamily.smallTitleTextStyle),
                                  SvgPicture.asset(
                                      "lib/assets/icons/expand.svg")
                                ],
                              ),
                              const SizedBox(
                                height: 0.5,
                                child: Divider(
                                    color: ColorFamily.gray, thickness: 0.5),
                              )
                            ],
                          ),
                        ),
                      )),
                  SizedBox(
                      width: deviceWidth - 40,
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
                                Text("앱 버전",
                                    style: TextStyleFamily.smallTitleTextStyle),
                                Text("v 1.0",
                                    style: TextStyleFamily.smallTitleTextStyle),
                              ],
                            ),
                            SizedBox(
                              height: 0.5,
                              child: Divider(
                                  color: ColorFamily.gray, thickness: 0.5),
                            )
                          ],
                        ),
                      )),
                  SizedBox(
                      width: deviceWidth - 40,
                      height: 60,
                      child: Material(
                        color: ColorFamily.cream,
                        child: InkWell(
                          splashFactory: NoSplash.splashFactory,
                          onTap: () async {
                            await storage.delete(key: "loginData");
                            signOut();
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()),
                                (Route<dynamic> route) => false);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(height: 5),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: const Text("로그아웃",
                                    style: TextStyleFamily.smallTitleTextStyle),
                              ),
                              const SizedBox(
                                height: 0.5,
                                child: Divider(
                                    color: ColorFamily.gray, thickness: 0.5),
                              )
                            ],
                          ),
                        ),
                      )),
                ],
              )));
    }
  }

  void signOut() async {
    switch (loginType) {
      case 1:
        await GoogleSignIn().signOut();
        break;
      case 2:
        try {
          await UserApi.instance.logout();
          print('로그아웃 성공, SDK에서 토큰 삭제');
        } catch (error) {
          print('로그아웃 실패, SDK에서 토큰 삭제 $error');
        }
        break;
      case 0:
        break;
    }
    updateUserData(userAccount, 'login_type', 0);
  }
}
