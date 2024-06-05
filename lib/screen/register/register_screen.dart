import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:woo_yeon_hi/screen/register/code_connect_screen.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/style/text_style.dart';
import '../../style/color.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
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
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CodeConnectScreen()));
                          Fluttertoast.showToast(
                              msg: "구글 계정으로 로그인 되었습니다.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: ColorFamily.black,
                              textColor: ColorFamily.white,
                              fontSize: 14.0
                          );
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
                  onTap: () async {
                    if (await isKakaoTalkInstalled()) {
                      try {
                        await UserApi.instance.loginWithKakaoTalk();
                        Fluttertoast.showToast(
                            msg: "카카오톡 계정으로 로그인 되었습니다.",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: ColorFamily.black,
                            textColor: ColorFamily.white,
                            fontSize: 14.0
                        );
                      } catch (error) {
                        Fluttertoast.showToast(
                            msg: "카카오톡 계정 로그인에 실패하였습니다.",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: ColorFamily.black,
                            textColor: ColorFamily.white,
                            fontSize: 14.0
                        );

                        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
                        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
                        if (error is PlatformException &&
                            error.code == 'CANCELED') {
                          return;
                        }
                        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
                        try {
                          await UserApi.instance.loginWithKakaoAccount();
                          Fluttertoast.showToast(
                              msg: "카카오 계정으로 로그인 되었습니다.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: ColorFamily.black,
                              textColor: ColorFamily.white,
                              fontSize: 14.0
                          );
                        } catch (error) {
                          Fluttertoast.showToast(
                              msg: "카카오 계정 로그인에 실패하였습니다.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: ColorFamily.black,
                              textColor: ColorFamily.white,
                              fontSize: 14.0
                          );
                        }
                      }
                    } else {
                      try {
                        await UserApi.instance.loginWithKakaoAccount();
                        Fluttertoast.showToast(
                            msg: "카카오 계정으로 로그인 되었습니다.",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: ColorFamily.black,
                            textColor: ColorFamily.white,
                            fontSize: 14.0
                        );
                      } catch (error) {
                        Fluttertoast.showToast(
                            msg: "카카오 계정 로그인에 실패하였습니다.",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: ColorFamily.black,
                            textColor: ColorFamily.white,
                            fontSize: 14.0
                        );
                      }
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
