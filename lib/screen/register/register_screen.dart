import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:woo_yeon_hi/provider/user_control_provider.dart';
import 'package:woo_yeon_hi/screen/login/password_enter_screen.dart';
import 'package:woo_yeon_hi/screen/register/code_connect_screen.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../style/color.dart';
import '../../widget/login/kakao_login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: ColorFamily.cream,
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 180),
            child: Image.asset(
              'lib/assets/images/wooyeonhi_logo.png',
              height: 300,
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: 200)),
          Material(
              color: ColorFamily.white,
              elevation: 0.5,
              shadowColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CodeConnectScreen()));
                },
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                    height: 48,
                    width: 340,
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 20),
                          child: Image.asset(
                            'lib/assets/images/google_logo.png',
                            height: 20,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            "구글 계정으로 등록하기",
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: FontFamily.mapleStoryLight),
                          ),
                        )
                      ],
                    )),
              )),
          Padding(padding: EdgeInsets.only(bottom: 10)),
          Material(
              color: Color(0xFFFEE500),
              elevation: 0.5,
              shadowColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: InkWell(
                onTap: () async {
                  if (await isKakaoTalkInstalled()) {
                    try {
                      await UserApi.instance.loginWithKakaoTalk();
                      print('카카오톡으로 로그인 성공');
                    } catch (error) {
                      print('카카오톡으로 로그인 실패 $error');

                      // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
                      // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
                      if (error is PlatformException &&
                          error.code == 'CANCELED') {
                        return;
                      }
                      // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
                      try {
                        await UserApi.instance.loginWithKakaoAccount();
                        print('카카오계정으로 로그인 성공');
                      } catch (error) {
                        print('카카오계정으로 로그인 실패 $error');
                      }
                    }
                  } else {
                    try {
                      await UserApi.instance.loginWithKakaoAccount();
                      print('카카오계정으로 로그인 성공');
                    } catch (error) {
                      print('카카오계정으로 로그인 실패 $error');
                    }
                  }

                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => PasswordEnterScreen()));
                },
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                    height: 48,
                    width: 340,
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 20),
                          child: Image.asset(
                            'lib/assets/images/kakaotalk_logo.png',
                            height: 20,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            "카카오 계정으로 등록하기",
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: FontFamily.mapleStoryLight,
                                color: Color(0xD9000000)),
                          ),
                        )
                      ],
                    )),
              )),
        ],
      ),
    ));
  }
}
