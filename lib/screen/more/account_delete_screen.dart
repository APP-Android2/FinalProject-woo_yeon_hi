import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/dao/user_dao.dart';
import 'package:woo_yeon_hi/model/enums.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/style/text_style.dart';
import 'package:woo_yeon_hi/widget/more/account_delete_top_app_bar.dart';

import '../../model/user_model.dart';
import '../login/login_screen.dart';

class AccountDeleteScreen extends StatefulWidget {
  const AccountDeleteScreen({super.key});

  @override
  State<AccountDeleteScreen> createState() => _AccountDeleteScreenState();
}

class _AccountDeleteScreenState extends State<AccountDeleteScreen> {
  static const storage = FlutterSecureStorage();
  late String userAccount = "";
  late int loginType = 0;
  bool isAgreed = false;

  @override
  void initState() {
    super.initState();
    _asyncMethod();
  }
  
  Future<void> _asyncMethod() async {
    userAccount = (await storage.read(key: "loginAccount"))!;
    loginType = await getSpecificUserData(userAccount, 'login_type');
  }
  
  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const AccountDeleteTopAppBar(),
      body: Container(
        width: deviceWidth,
        height: deviceHeight,
        padding: const EdgeInsets.all(20),
        color: ColorFamily.cream,
        child: Column(
          children: [
            SizedBox(height: deviceHeight*0.05),
            InkWell(
              onTap: (){
                signOut();
                deleteUserData(userAccount);
                storage.deleteAll();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                        (Route<dynamic> route) => false);
              },
              child: Image.asset(
                'lib/assets/images/warning.png',
                height: 80,
              ),
            ),
            const SizedBox(height: 30),
            const Text("계정을 삭제하면", style: TextStyleFamily.smallTitleTextStyle),
            const Text("모든 데이터와 설정이 초기화됩니다.",
                style: TextStyleFamily.smallTitleTextStyle),
            const SizedBox(height: 30),
            const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("계정 삭제",
                  style: TextStyle(
                      fontSize: 15,
                      color: ColorFamily.pink,
                      fontFamily: FontFamily.mapleStoryLight)),
              Text("를 누르면 자동으로 로그아웃되며,",
                  style: TextStyleFamily.smallTitleTextStyle)
            ]),
            const Text("동일 계정으로는 30일 이내에 재가입이 불가능합니다.", style: TextStyleFamily.smallTitleTextStyle),
            const SizedBox(height: 30),
            const Text("만약 계정 삭제 취소를 원하는 경우,",
                style: TextStyle(
                fontSize: 12,
                color: ColorFamily.black,
                fontFamily: FontFamily.mapleStoryLight)),
            const Text("삭제일로부터 30일 이내에 해당 계정으로 로그인해주세요.",
                style: TextStyle(
                    fontSize: 12,
                    color: ColorFamily.black,
                    fontFamily: FontFamily.mapleStoryLight)),
            const SizedBox(height: 50),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 30),
                  const Text("위의 내용을 확인하였으며 동의합니다.",
                    style: TextStyle(
                        fontSize: 15,
                        color: ColorFamily.black,
                        fontFamily: FontFamily.mapleStoryLight)),
                  Checkbox(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                    side: const BorderSide(color: ColorFamily.black, width: 1.5),
                    checkColor: ColorFamily.white,
                    activeColor: ColorFamily.pink,
                    value: isAgreed,
                    onChanged: (bool? value) {
                      setState(() {
                        isAgreed = value!;
                      });},
                  ),
            ]),
            const SizedBox(height: 50),
            Material(
              color: ColorFamily.pink,
              elevation: 1,
              shadowColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(20.0),
              ),
              child: InkWell(
                  onTap: () {
                    if(isAgreed){
                      updateUserData(userAccount, 'user_state', 1);
                      signOut();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                              (Route<dynamic> route) => false);
                      Fluttertoast.showToast(
                          msg: "우연히 계정이 삭제 처리되었습니다.",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: ColorFamily.black,
                          textColor: ColorFamily.white,
                          fontSize: 14.0
                      );
                    }else{
                      Fluttertoast.showToast(
                          msg: "동의 항목을 체크해주세요",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: ColorFamily.black,
                          textColor: ColorFamily.white,
                          fontSize: 14.0
                      );
                    }
                  },
                  borderRadius:
                  BorderRadius.circular(20.0),
                  child: SizedBox(
                      height: 40,
                      width: deviceWidth*0.6,
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "계정 삭제",
                          style: TextStyleFamily.normalTextStyle,
                        ),
                      ))),
            ),
          ],
        ),
      ),
    );
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
