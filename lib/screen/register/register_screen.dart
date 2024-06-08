import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/screen/login/password_enter_screen.dart';
import 'package:woo_yeon_hi/screen/register/code_connect_screen.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/style/text_style.dart';
import '../../model/enums.dart';
import '../../model/user_model.dart';
import '../../style/color.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../main_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {

  bool loginSuccess = false;

  signInWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      print('email = ${googleUser.email}');
      print('id = ${googleUser.id}');

      setState(() {
        userProvider.userAccount = googleUser.email;
        loginSuccess = true;
      });
    }else{
      loginSuccess = false;
    }
  }

  void signInWithKakao() async {
    if (await isKakaoTalkInstalled()) {
      try {
        await UserApi.instance.loginWithKakaoTalk();
        setState(() {
          loginSuccess = true;
        });
      } catch (error) {
        print("에러1?: $error");
        Fluttertoast.showToast(
            msg: "카카오톡 계정 로그인에 실패하였습니다.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: ColorFamily.black,
            textColor: ColorFamily.white,
            fontSize: 14.0
        );
        setState(() {
          loginSuccess = false;
        });

        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException &&
            error.code == 'CANCELED') {
          print("에러2?: $error");
          return;
        }
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          await UserApi.instance.loginWithKakaoAccount();
          setState(() {
            loginSuccess = true;
          });
        } catch (error) {
          print("에러3?: $error");
          Fluttertoast.showToast(
              msg: "카카오 계정 로그인에 실패하였습니다.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: ColorFamily.black,
              textColor: ColorFamily.white,
              fontSize: 14.0
          );
          setState(() {
            loginSuccess = false;
          });
        }
      }
    } else {
      try {
        await UserApi.instance.loginWithKakaoAccount();
        setState(() {
          loginSuccess = true;
        });
      } catch (error) {
        print("에러4?: $error");
        Fluttertoast.showToast(
            msg: "카카오 계정 로그인에 실패하였습니다.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: ColorFamily.black,
            textColor: ColorFamily.white,
            fontSize: 14.0
        );
        setState(() {
          loginSuccess = false;
        });
      }
    }
  }

  dynamic userProvider;

  @override
  void initState() {
    super.initState();

    userProvider = Provider.of<UserModel>(context, listen: false);
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
          child: Column(
            children: [
              SizedBox(height: deviceHeight*0.2),
              Image.asset(
                'lib/assets/images/wooyeonhi_logo.png',
                height: deviceHeight*0.35,
              ),
              SizedBox(height: deviceHeight*0.25),
              Column(
                children: [
                  Material(
                      color: ColorFamily.white,
                      elevation: 0.5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: InkWell(
                        onLongPress: (){
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PasswordEnterScreen()));
                        },
                        onTap: () async {
                          await signInWithGoogle();
                          if(loginSuccess == true) {
                            setState(() {
                              userProvider.loginType = LoginType.google;
                            });
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (
                                        context) => const CodeConnectScreen()));
                            Fluttertoast.showToast(
                                msg: "구글 계정으로 로그인 되었습니다.",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: ColorFamily.black,
                                textColor: ColorFamily.white,
                                fontSize: 14.0
                            );
                          }
                        },
                        borderRadius: BorderRadius.circular(20.0),
                        child: SizedBox(
                            height: deviceHeight*0.06,
                            width: deviceWidth*0.75,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: SvgPicture.asset(
                                        "lib/assets/icons/google_logo.svg",
                                        height: 24,
                                        width: 24)),
                                const Text(
                                  "구글 계정으로 등록하기",
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
                  onTap: () {
                    signInWithKakao();
                    if(loginSuccess == true) {
                      setState(() {
                        userProvider.loginType = LoginType.kakao;
                      });
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CodeConnectScreen()));
                      Fluttertoast.showToast(
                          msg: "카카오 계정으로 로그인 되었습니다.",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: ColorFamily.black,
                          textColor: ColorFamily.white,
                          fontSize: 14.0
                      );
                    }
                  },
                  borderRadius: BorderRadius.circular(20.0),
                  child: SizedBox(
                      height: deviceHeight*0.06,
                      width: deviceWidth*0.75,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              padding: const EdgeInsets.only(left: 20),
                              child: SvgPicture.asset(
                                  "lib/assets/icons/kakao_logo.svg",
                                  height: 24,
                                  width: 24)),
                          const Text(
                              "카카오 계정으로 등록하기",
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
          ),
        ));
  }
}
