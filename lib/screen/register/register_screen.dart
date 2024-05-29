import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:woo_yeon_hi/screen/login/password_enter_screen.dart';
import 'package:woo_yeon_hi/screen/register/code_connect_screen.dart';
import 'package:woo_yeon_hi/style/font.dart';

import '../../style/color.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PasswordEnterScreen()));
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
                            "카카오톡 계정으로 등록하기",
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: FontFamily.mapleStoryLight,color: Color(0xD9000000)),
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
