import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/dao/user_dao.dart';
import 'package:woo_yeon_hi/screen/main_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/widget/login/password_reset_top_app_bar.dart';

import '../../dao/more_dao.dart';
import '../../dialogs.dart';
import '../../provider/login_register_provider.dart';
import '../../provider/more_provider.dart';
import '../../style/text_style.dart';
import '../register/code_connect_screen.dart';

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({super.key});

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {

  String _authCode = getRandomString(6);
  DateTime? _timerStartTime;

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;

    return Consumer2<UserProvider, AuthCodeProvider>(
        builder: (context, userProvider, authCodeProvider, child) {
    return Scaffold(
        appBar: const PasswordResetTopAppBar(),
        body: Container(
            width: deviceWidth,
            height: deviceHeight,
            padding: const EdgeInsets.all(20),
            color: ColorFamily.cream,
            child: SingleChildScrollView(
              child: Column(children: [
                SizedBox(height: deviceHeight * 0.02),
                Container(
                  padding: const EdgeInsets.only(left: 30),
                  alignment: Alignment.centerLeft,
                  child: const Text("로그인 계정 정보",
                      style: TextStyleFamily.smallTitleTextStyle),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: deviceWidth - 80,
                  child: Material(
                      borderRadius: BorderRadius.circular(20),
                      color: ColorFamily.white,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(3),
                        height: deviceHeight * 0.065,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                                padding: const EdgeInsets.fromLTRB(10, 2, 0, 0),
                                child:
                                    userProvider.loginType == 2
                                        ? const Text("카카오 로그인",
                                            style: TextStyle(
                                                color: ColorFamily.black,
                                                fontFamily:
                                                    FontFamily.mapleStoryLight,
                                                fontSize: 12))
                                        : const Text("구글 로그인",
                                            style: TextStyle(
                                                color: ColorFamily.black,
                                                fontFamily:
                                                    FontFamily.mapleStoryLight,
                                                fontSize: 12))),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(userProvider.userAccount,
                                  style: TextStyleFamily.normalTextStyle),
                            ),
                          ],
                        ),
                      )),
                ),
                const SizedBox(height: 50),
                Container(
                  padding: const EdgeInsets.only(left: 30),
                  alignment: Alignment.centerLeft,
                  child: const Text("인증코드 입력",
                      style: TextStyleFamily.smallTitleTextStyle),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: deviceWidth - 80,
                  child: Row(children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 10),
                        height: deviceHeight * 0.05,
                        child: TextFormField(
                          onTapOutside: (event) {
                            FocusScope.of(context).unfocus();
                          },
                          controller: authCodeProvider.authNumberTextEditController,
                          decoration: const InputDecoration(
                              counter: SizedBox(),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: ColorFamily.black)),
                            errorStyle: TextStyle(
                              color: ColorFamily.black,
                              fontSize: 12,
                              fontFamily: FontFamily.mapleStoryLight,
                            ),
                          ),
                          autovalidateMode: authCodeProvider.showError
                              ? AutovalidateMode.always
                              : AutovalidateMode.disabled,
                          validator: (value) {
                            return '코드가 일치하지 않습니다.';
                          },
                          cursorColor: ColorFamily.black,
                          textAlign: TextAlign.center,
                          maxLength: 6,
                          style: const TextStyle(
                              color: ColorFamily.black,
                              fontSize: 20,
                              fontFamily: FontFamily.mapleStoryLight),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Material(
                      color: ColorFamily.beige,
                      borderRadius: BorderRadius.circular(20),
                      elevation: 0.5,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () async {
                          if(authCodeProvider.isAuthCodeGenerated){
                            await deleteAuthCodeData(userProvider.userIdx);
                          }

                          setState(() {
                            _timerStartTime = DateTime.now();
                            _authCode = getRandomString(6);
                          });

                          //TODO 인증번호를 로그인 계정으로 전송
                          await saveAuthCodeData(_authCode, userProvider.userIdx);
                          authCodeProvider.setIsAuthCodeGenerated(true);
                          authCodeProvider.setIsAuthCodeExpired(false);
                          authCodeProvider.setAuthCodeText(_authCode);
                          showBlackToast("인증코드가 전송되었습니다.");
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: deviceHeight * 0.045,
                          width: deviceWidth * 0.3,
                          child: authCodeProvider.isAuthCodeGenerated
                              ? const Text(
                              "재요청",
                              style: TextStyleFamily.normalTextStyle)
                              : const Text(
                              "인증 요청",
                              style: TextStyleFamily.normalTextStyle)
                        ),
                      ),
                    )
                  ]),
                ),
                authCodeProvider.isAuthCodeGenerated
                ? SizedBox(
                  width: deviceWidth - 80,
                  child: Row(children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 10),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      alignment: Alignment.center,
                      height: deviceHeight * 0.045,
                      width: deviceWidth * 0.3,
                      child:
                      authCodeProvider.isAuthCodeExpired
                      ? const Text(
                          "인증코드가 만료되었습니다.",
                          style: TextStyle(
                              color: ColorFamily.black,
                              fontSize: 11,
                              fontFamily: FontFamily
                                  .mapleStoryLight))
                      : TimerCountdown(
                          format: CountDownTimerFormat.minutesSeconds,
                          enableDescriptions: false,
                          timeTextStyle: const TextStyle(
                              color: ColorFamily.black,
                              fontSize: 12,
                              fontFamily: FontFamily.mapleStoryLight),
                          colonsTextStyle: const TextStyle(
                              color: ColorFamily.black,
                              fontSize: 12,
                              fontFamily: FontFamily.mapleStoryLight),
                          spacerWidth: 2,
                          endTime: _timerStartTime != null
                              ? _timerStartTime!.add(const Duration(minutes:5))
                              : DateTime.now().add(const Duration(minutes:5)),
                          onEnd: () async {
                            await deleteAuthCodeData(userProvider.userIdx);
                            authCodeProvider.setIsAuthCodeExpired(true);
                          }),
                    ),
                  ]),
                )
                :SizedBox(width: deviceWidth - 80, height: 40),
                const SizedBox(height: 15),
                SizedBox(
                  width: deviceWidth - 80,
                  height: deviceHeight * 0.045,
                  child: Material(
                    color: ColorFamily.beige,
                    elevation: 0.5,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: InkWell(
                      onTap: () async {
                        var code = await isVerifiedCode(_authCode, userProvider.userIdx);
                        code != null
                        ? code == authCodeProvider.authNumberTextEditController.text
                          ? {authCodeProvider.setShowError(false),
                             await deleteAuthCodeData(userProvider.userIdx),
                             await updateSpecificUserData(userProvider.userIdx, 'app_lock_state', 0),
                             userProvider.setLockPassword([0, 0, 0, 0]),
                             Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>
                              const MainScreen()), (route) => false),
                        await Future.delayed(const Duration(milliseconds: 200), () {
                          showBlackToast("앱 잠금을 초기화하였습니다.");
                        })
                            }
                          : authCodeProvider.setShowError(true)
                        : showBlackToast("유효하지 않은 코드입니다.");
                      },
                      borderRadius: BorderRadius.circular(20.0),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "확인",
                          style: TextStyleFamily.normalTextStyle,
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            )));});
  }
}
