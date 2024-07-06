import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/dao/login_register_dao.dart';
import 'package:woo_yeon_hi/dao/user_dao.dart';
import 'package:woo_yeon_hi/dialogs.dart';
import 'package:woo_yeon_hi/provider/login_register_provider.dart';
import 'package:woo_yeon_hi/screen/login/account_processing_screen.dart';
import 'package:woo_yeon_hi/screen/register/code_connect_screen.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/style/text_style.dart';
import '../../style/color.dart';

import '../main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _RegisterScreen();
}

class _RegisterScreen extends State<LoginScreen> {
  static const storage = FlutterSecureStorage();
  bool loginSuccess = false;


  signInWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      Provider.of<UserProvider>(context, listen: false).setUserAccount(googleUser.email);
      setState(() {
        loginSuccess = true;
      });
    } else{
      showBlackToast("구글 계정 로그인에 실패하였습니다.");
    }
  }

  signInWithKakao() async {
    if (await isKakaoTalkInstalled()) {
      try {
        // 카카오톡 설치됨, 카카오톡으로 로그인 시도
        await UserApi.instance.loginWithKakaoTalk();
        await _fetchKakaoUserInfo();
      } catch (error) {
        print('카카오톡으로 로그인 실패 $error');
        showBlackToast("카카오 계정 로그인에 실패하였습니다.");
        if (error is PlatformException && error.code == 'CANCELED') {
          print('사용자가 로그인 취소');
          showBlackToast("카카오 계정 로그인을 취소하였습니다.");
          return;
        }

        print('카카오 계정으로 로그인 시도');
        try {
          await UserApi.instance.loginWithKakaoAccount();
          await _fetchKakaoUserInfo();
        } catch (error) {
          print('카카오 계정으로 로그인 실패 $error');
          showBlackToast("카카오 계정 로그인에 실패하였습니다.");
        }
      }
    } else {
      // 카카오톡 설치 안됨, 카카오계정으로 로그인 시도
      try {
        await UserApi.instance.loginWithKakaoAccount();
        await _fetchKakaoUserInfo();
      } catch (error) {
        showBlackToast("카카오 계정 로그인에 실패하였습니다.");
      }
    }
  }

  _fetchKakaoUserInfo() async {
    try {
      User user = await UserApi.instance.me();
      Provider.of<UserProvider>(context, listen: false).setUserAccount(user.id.toString());
      setState(() {
        loginSuccess = true;
      });
    } catch (error) {
      print('사용자 정보 요청 실패 $error');
      showBlackToast("사용자 정보 요청에 실패하였습니다.");
    }
  }


  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: deviceWidth,
          color: ColorFamily.cream,
          padding: const EdgeInsets.all(20),
          child: Consumer<UserProvider>(
            builder: (context, provider, child) {
          return Column(
            children: [
              SizedBox(height: deviceHeight * 0.2),
              Image.asset(
                'lib/assets/images/wooyeonhi_logo.png',
                height: deviceHeight * 0.35,
              ),
              SizedBox(height: deviceHeight * 0.18),
              Column(
                children: [
                  Material(
                      color: ColorFamily.white,
                      elevation: 0.5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: InkWell(
                        onTap: () async {
                          switch (await getSpecificUserData(provider.userIdx, "user_state")??2) {
                            case 0:
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MainScreen()));
                            case 1:
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const AccountProcessingScreen()));

                            case 2:
                              await signInWithGoogle();
                              if (loginSuccess == true) {
                                provider.setLoginType(1);
                                await storage.write(
                                    key: "userAccount",
                                    value: provider.userAccount);
                                await storage.write(
                                    key: "userIdx",
                                    value: "${provider.userIdx}");
                                await saveUserInfo(provider.userAccount);
                                var userIdx = await getUserSequence();
                                provider.setUserIdx(userIdx);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CodeConnectScreen()));
                                showBlackToast("구글 계정으로 로그인 되었습니다.");
                              }
                          }
                        },
                        borderRadius: BorderRadius.circular(20.0),
                        child: SizedBox(
                            height: deviceHeight * 0.06,
                            width: deviceWidth * 0.75,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: SvgPicture.asset(
                                        "lib/assets/icons/google_logo.svg",
                                        height: 24,
                                        width: 24)),
                                const Text("구글 계정으로 등록하기",
                                    style: TextStyleFamily.smallTitleTextStyle),
                                const SizedBox(height: 24, width: 24)
                              ],
                            )),
                      )),
                  const SizedBox(height: 10),
                  Material(
                      color: const Color(0xFFFEE500),
                      elevation: 0.5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: InkWell(
                        onTap: () async {
                          switch (provider.userState) {
                            case 0:
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                      const MainScreen()));
                            case 1:
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                  const AccountProcessingScreen()));

                            case 2:
                              await signInWithKakao();
                              if (loginSuccess == true) {
                                provider.setLoginType(2);
                                await storage.write(
                                    key: "userAccount",
                                    value: provider.userAccount);
                                await storage.write(
                                    key: "userIdx",
                                    value: "${provider.userIdx}");
                                await saveUserInfo(provider.userAccount);
                                var userIdx = await getUserSequence();
                                provider.setUserIdx(userIdx);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const CodeConnectScreen()));
                                showBlackToast("카카오 계정으로 로그인 되었습니다.");
                              }
                          }
                        },
                        borderRadius: BorderRadius.circular(20.0),
                        child: SizedBox(
                            height: deviceHeight * 0.06,
                            width: deviceWidth * 0.75,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: SvgPicture.asset(
                                        "lib/assets/icons/kakao_logo.svg",
                                        height: 24,
                                        width: 24)),
                                const Text("카카오 계정으로 등록하기",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: FontFamily.mapleStoryLight,
                                        color: Color(0xD9000000))),
                                const SizedBox(height: 24, width: 24)
                              ],
                            )),
                      )),
                ],
              ),
            ],
          );}
        )));
  }
}
