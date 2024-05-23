import 'package:flutter/material.dart';
import 'package:woo_yeon_hi/style/font.dart';
class TextStyleFamily{
  /// 일반 텍스트 스타일. size 14
  static const TextStyle normalTextStyle = TextStyle(fontFamily: FontFamily.mapleStoryLight, fontSize: 14);

  /// 앱바 타이틀 텍스트 스타일. size 20
  static const TextStyle appBarTitleBoldTextStyle = TextStyle(fontFamily: FontFamily.mapleStoryBold, fontSize: 20);

  /// 앱바 타이틀 텍스트 스타일. size 15
  static const TextStyle appBarTitleLightTextStyle = TextStyle(fontFamily: FontFamily.mapleStoryLight, fontSize: 15);
}