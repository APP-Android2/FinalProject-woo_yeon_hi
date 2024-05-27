import 'package:flutter/material.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
class TextStyleFamily{
  /// 일반 텍스트 스타일. size 14, black
  static const TextStyle normalTextStyle = TextStyle(
      fontFamily: FontFamily.mapleStoryLight,
      fontSize: 14,
      color: ColorFamily.black
  );
  /// 일반 텍스트 스타일. size 14, pink
  static const TextStyle normalTextStyle_pink = TextStyle(
      fontFamily: FontFamily.mapleStoryLight,
      fontSize: 14,
      color: ColorFamily.pink
  );
  /// 앱바 타이틀 텍스트 스타일. size 20, black
  static const TextStyle appBarTitleBoldTextStyle = TextStyle(
      fontFamily: FontFamily.mapleStoryBold,
      fontSize: 20,
      color: ColorFamily.black
  );

  /// 앱바 타이틀 텍스트 스타일. size 15, black
  static const TextStyle appBarTitleLightTextStyle = TextStyle(
      fontFamily: FontFamily.mapleStoryLight,
      fontSize: 15,
      color: ColorFamily.black
  );

  /// 텍스트 필드 힌트 텍스트 스타일. size 14, gray
  static const TextStyle hintTextStyle = TextStyle(
    fontFamily: FontFamily.mapleStoryLight,
    fontSize: 14,
    color: ColorFamily.gray
  );
}