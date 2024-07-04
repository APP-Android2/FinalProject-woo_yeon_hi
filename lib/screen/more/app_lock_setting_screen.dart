import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/provider/more_provider.dart';
import 'package:woo_yeon_hi/screen/more/password_setting_screen.dart';
import 'package:woo_yeon_hi/style/font.dart';

import '../../dao/user_dao.dart';
import '../../provider/login_register_provider.dart';
import '../../style/color.dart';
import '../../style/text_style.dart';
import '../../widget/more/app_lock_setting_top_app_bar.dart';
import 'package:local_auth_android/local_auth_android.dart';

class AppLockSettingScreen extends StatefulWidget {
  const AppLockSettingScreen({super.key});

  @override
  State<AppLockSettingScreen> createState() => _AppLockSettingScreenState();
}

class _AppLockSettingScreenState extends State<AppLockSettingScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  bool _isAuthenticating = false;
  late bool _isBioAuthSupported;

  @override
  void initState() {
    super.initState();
  }

  Future<bool> _asyncMethod() async {
    _isBioAuthSupported = await auth.isDeviceSupported();
    return _isBioAuthSupported;
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;

    return FutureBuilder(
        future: _asyncMethod(),
        builder: (context, snapshot) {
          if (snapshot.hasData == false) {
            return const SizedBox();
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                "network error",
                style: TextStyleFamily.normalTextStyle,
              ),
            );
          } else {
            Provider.of<BioAuthProvider>(context, listen: false)
                .setBioAuthSupported(_isBioAuthSupported);

            return Scaffold(
                appBar: const AppLockSettingTopAppBar(),
                body: Container(
                    width: deviceWidth,
                    height: deviceHeight,
                    padding: const EdgeInsets.all(20),
                    color: ColorFamily.cream,
                    child: Consumer<UserProvider>(
                        builder: (context, provider, child) {
                      return Column(
                        children: [
                          SizedBox(
                              width: deviceWidth - 40,
                              height: 60,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("잠금 설정",
                                          style: TextStyleFamily
                                              .smallTitleTextStyle),
                                      Switch(
                                          value: provider.appLockState == 0
                                              ? false
                                              : true,
                                          activeColor: ColorFamily.white,
                                          activeTrackColor: ColorFamily.pink,
                                          inactiveThumbColor: ColorFamily.gray,
                                          inactiveTrackColor: ColorFamily.white,
                                          trackOutlineColor:
                                              provider.appLockState != 0
                                                  ? MaterialStateProperty.all(
                                                      Colors.transparent)
                                                  : MaterialStateProperty.all(
                                                      ColorFamily.gray),
                                          trackOutlineWidth:
                                              const MaterialStatePropertyAll(1),
                                          onChanged: (bool value) async {
                                            if (provider.appLockState == 0) {
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          PasswordSettingScreen()));
                                            } else {
                                              provider.setAppLockState(0);
                                              await updateSpecificUserData(
                                                  provider.userIdx,
                                                  'app_lock_state',
                                                  0);
                                            }
                                          })
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 0.5,
                                    child: Divider(
                                        color: ColorFamily.gray,
                                        thickness: 0.5),
                                  )
                                ],
                              )),
                          _isBioAuthSupported
                              ? SizedBox(
                                  width: deviceWidth - 40,
                                  height: 60,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                              "생체 인증 (Touch ID, Face ID)",
                                              style: TextStyleFamily
                                                  .smallTitleTextStyle),
                                          Switch(
                                              value: provider.appLockState == 2
                                                  ? true
                                                  : false,
                                              activeColor: ColorFamily.white,
                                              activeTrackColor:
                                                  ColorFamily.pink,
                                              inactiveThumbColor:
                                                  ColorFamily.gray,
                                              inactiveTrackColor:
                                                  ColorFamily.white,
                                              trackOutlineColor: provider
                                                          .appLockState ==
                                                      2
                                                  ? MaterialStateProperty.all(
                                                      Colors.transparent)
                                                  : MaterialStateProperty.all(
                                                      ColorFamily.gray),
                                              trackOutlineWidth:
                                                  const MaterialStatePropertyAll(
                                                      1),
                                              onChanged: (bool value) async {
                                                provider.appLockState == 0
                                                    ? {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "앱 잠금 설정을 먼저 해주세요.",
                                                            toastLength: Toast
                                                                .LENGTH_SHORT,
                                                            gravity:
                                                                ToastGravity
                                                                    .BOTTOM,
                                                            timeInSecForIosWeb:
                                                                1,
                                                            backgroundColor:
                                                                ColorFamily
                                                                    .black,
                                                            textColor:
                                                                ColorFamily
                                                                    .white,
                                                            fontSize: 14.0),
                                                        setState(() {
                                                          value = false;
                                                        })
                                                      }
                                                    : provider.appLockState == 1
                                                        ? await _authenticateWithBiometrics()
                                                            ? {
                                                                provider
                                                                    .setAppLockState(
                                                                        2),
                                                                await updateSpecificUserData(
                                                                    provider
                                                                        .userIdx,
                                                                    'app_lock_state',
                                                                    2),
                                                                ScaffoldMessenger.of(context).showSnackBar(
                                                                    const SnackBar(
                                                                        content:
                                                                            Text(
                                                                          '생체인증이 활성화되었습니다.',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                                style: TextStyleFamily.normalTextStyle
                                                                        ),
                                                                        backgroundColor:
                                                                            ColorFamily
                                                                                .pink,
                                                                        duration:
                                                                            Duration(seconds: 1)))
                                                              }
                                                            : setState(() {
                                                                value = false;
                                                              })
                                                        : {
                                                            _cancelAuthentication(),
                                                            provider
                                                                .setAppLockState(
                                                                    1),
                                                            await updateSpecificUserData(
                                                                provider
                                                                    .userIdx,
                                                                'app_lock_state',
                                                                1),
                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                                const SnackBar(
                                                                    content:
                                                                        Text(
                                                                      '생체인증이 비활성화되었습니다.',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                          style: TextStyleFamily.normalTextStyle,
                                                                    ),
                                                                    backgroundColor:
                                                                        ColorFamily
                                                                            .pink,
                                                                    duration: Duration(
                                                                        seconds:
                                                                            1)))
                                                          };
                                              })
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 0.5,
                                        child: Divider(
                                            color: ColorFamily.gray,
                                            thickness: 0.5),
                                      )
                                    ],
                                  ))
                              : SizedBox(
                                  width: deviceWidth - 40,
                                  height: 60,
                                  child: const Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("생체 인증 (Touch ID, Face ID)",
                                              style: TextStyleFamily
                                                  .smallTitleTextStyle),
                                        ],
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                            "기기에 생체 인증 사용 설정이 안 되어 있거나, 생체 인증을 지원하지 않는 기기입니다.",
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontFamily:
                                                    FontFamily.mapleStoryLight,
                                                color: ColorFamily.gray)),
                                      ),
                                      SizedBox(
                                        height: 0.5,
                                        child: Divider(
                                            color: ColorFamily.gray,
                                            thickness: 0.5),
                                      )
                                    ],
                                  )),
                        ],
                      );
                    })));
          }
        });
  }

  Future<bool> _authenticateWithBiometrics() async {
    bool authenticated = false;

    try {
      setState(() {
        _isAuthenticating = true;
      });
      authenticated = await auth.authenticate(
        authMessages: [
          const AndroidAuthMessages(
            biometricHint: '',
            biometricNotRecognized: '생체정보가 일치하지 않습니다.',
            biometricRequiredTitle: '생체정보가 필요합니다.',
            biometricSuccess: '스캔 완료',
            cancelButton: '취소',
            deviceCredentialsRequiredTitle: '생체정보가 필요합니다.',
            deviceCredentialsSetupDescription: '기기 설정으로 이동하여 생체정보를 등록하세요.',
            goToSettingsButton: '설정',
            goToSettingsDescription: '기기 설정으로 이동하여 생체정보를 등록하세요.',
            signInTitle: '생체정보 스캔',
          )
        ],
        localizedReason: '기기에 등록된 생체정보를 스캔해주세요.',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
      });
      return _isAuthenticating;
    }
    if (!mounted) {
      return _isAuthenticating;
    }
    return authenticated;
  }

  Future<void> _cancelAuthentication() async {
    await auth.stopAuthentication();
    setState(() => _isAuthenticating = false);
  }
}
