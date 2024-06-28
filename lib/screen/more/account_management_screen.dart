import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:woo_yeon_hi/main.dart';
import 'package:woo_yeon_hi/screen/more/account_delete_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/widget/more/account_management_top_app_bar.dart';

import '../../dao/user_dao.dart';
import '../../style/font.dart';
import '../../style/text_style.dart';
import '../../utils.dart';

class AccountManagementScreen extends StatefulWidget {
  const AccountManagementScreen({super.key});

  @override
  State<AccountManagementScreen> createState() => _AccountManagementScreenState();
}

class _AccountManagementScreenState extends State<AccountManagementScreen> {
  static const storage = FlutterSecureStorage();
  late String userAccount;
  late int userIdx;
  late int loginType;
  late String appLockState;
  bool _isLoading = true; // Loading 상태를 나타내는 변수

  @override
  void initState() {
    super.initState();
    _asyncMethod();
  }

  Future<void> _asyncMethod() async {
    userAccount = (await storage.read(key: "userAccount"))!;
    userIdx = stringToInt((await storage.read(key: "userIdx"))!);
    appLockState = (await storage.read(key: "appLockState"))!;
    loginType = await getSpecificUserData(userIdx, 'login_type');
    setState(() {
      _isLoading = false; // 데이터 로드가 완료되면 로딩 상태를 false로 설정
    });
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery
        .of(context)
        .size
        .width;
    var deviceHeight = MediaQuery
        .of(context)
        .size
        .height;

    if (_isLoading) {
      // 로딩 중인 상태를 표시
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
          appBar: const AccountManagementTopAppBar(),
          body: Container(
              width: deviceWidth,
              height: deviceHeight,
              padding: const EdgeInsets.all(20),
              color: ColorFamily.cream,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 15),
                    alignment: Alignment.centerLeft,
                    child: const Text("로그인 계정 정보",
                        style: TextStyleFamily.smallTitleTextStyle),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: deviceWidth - 40,
                    child: Material(
                        borderRadius: BorderRadius.circular(20),
                        color: ColorFamily.white,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.all(3),
                          height: 60,
                          child: Row(
                            children: [
                              Container(
                                  padding: const EdgeInsets.fromLTRB(
                                      10, 2, 0, 0),
                                  child:
                                  loginType == 2
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
                              const SizedBox(width: 20),
                              Text(userAccount,
                                  style:
                                  TextStyleFamily.normalTextStyle)
                            ],
                          ),
                        )),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                      width: deviceWidth - 40,
                      height: 60,
                      child: Material(
                        color: ColorFamily.cream,
                        child: InkWell(
                          splashFactory: NoSplash.splashFactory,
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (
                                context) => const AccountDeleteScreen()));
                          },
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("계정 삭제",
                                      style: TextStyleFamily
                                          .smallTitleTextStyle),
                                  SvgPicture.asset(
                                      "lib/assets/icons/expand.svg")
                                ],
                              ),
                              const SizedBox(
                                height: 0.5,
                                child: Divider(
                                    color: ColorFamily.gray,
                                    thickness: 0.5),
                              )
                            ],
                          ),
                        ),
                      ))
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
    updateSpecificUserData(userIdx, 'login_type', 0);
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
