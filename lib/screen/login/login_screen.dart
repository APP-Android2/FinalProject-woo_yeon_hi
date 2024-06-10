import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/provider/login_provider.dart';
import 'package:woo_yeon_hi/screen/login/password_enter_screen.dart';
import 'package:woo_yeon_hi/screen/login/account_processing_screen.dart';
import 'package:woo_yeon_hi/screen/register/code_connect_screen.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/style/text_style.dart';
import '../../model/enums.dart';
import '../../style/color.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _RegisterScreen();
}

class _RegisterScreen extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;

    return ChangeNotifierProvider(
        create: (context) => UserProvider(),
    child: Consumer<UserProvider>(
    builder: (context, provider, _) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: deviceWidth,
          color: ColorFamily.cream,
          padding: const EdgeInsets.all(20),
          child: Column(
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
                        onLongPress: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const PasswordEnterScreen()));
                        },
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
                              await provider.signInWithGoogle();
                              if (provider.loginSuccess == true) {
                                provider.setUserLoginType(LoginType.google);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CodeConnectScreen()));
                                showToast("구글 계정으로 로그인 되었습니다.");
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
                              await provider.signInWithKakao();
                              if (provider.loginSuccess == true) {
                                setState(() {
                                  provider.setUserLoginType(LoginType.kakao);
                                });
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const CodeConnectScreen()));
                                showToast("카카오 계정으로 로그인 되었습니다.");
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
          ),
      ));}));
  }

  showToast(String msg){
     Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: ColorFamily.black,
        textColor: ColorFamily.white,
        fontSize: 14.0);
  }
}
