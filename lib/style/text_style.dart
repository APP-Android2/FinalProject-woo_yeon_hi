import 'package:flutter/material.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
class TextStyleFamily{
  /// 일반 텍스트 스타일. size 14
  static const TextStyle normalTextStyle = TextStyle(fontFamily: FontFamily.mapleStoryLight, fontSize: 14, color: ColorFamily.black);

  /// 소제목 텍스트 스타일. size 15
  static const TextStyle smallTitleTextStyle = TextStyle(fontFamily: FontFamily.mapleStoryLight, fontSize: 15, color: ColorFamily.black);

  /// 앱바 타이틀 텍스트 스타일. size 20
  static const TextStyle appBarTitleBoldTextStyle = TextStyle(fontFamily: FontFamily.mapleStoryBold, fontSize: 20, color: ColorFamily.black);

  /// 앱바 타이틀 텍스트 스타일. size 15
  static const TextStyle appBarTitleLightTextStyle = TextStyle(fontFamily: FontFamily.mapleStoryLight, fontSize: 15, color: ColorFamily.black);

  /// 비밀번호 입력 숫자 텍스트 스타일. size 20
  static const TextStyle passwordTextStyle = TextStyle(fontFamily: FontFamily.mapleStoryLight, fontSize: 20, color: ColorFamily.black);

}