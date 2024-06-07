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
  /// 앱바 타이틀 텍스트 스타일. size 20, black, bold
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

  /// 텍스트 필드 타이틀 힌트 텍스트 스타일. size 20, gray
  static const TextStyle hintTitleTextStyle = TextStyle(
      fontFamily: FontFamily.mapleStoryLight,
      fontSize: 20,
      color: ColorFamily.gray
  );

  /// 다이얼로그 타이틀 텍스트 스타일. size 20, black, bold
  static const TextStyle dialogTitleTextStyle = TextStyle(
      fontFamily: FontFamily.mapleStoryBold,
      fontSize: 20,
      color: ColorFamily.black
  );

  /// 다이얼로그 버튼 텍스트 스타일. size 20, black
  static const TextStyle dialogButtonTextStyle = TextStyle(
      fontFamily: FontFamily.mapleStoryLight,
      fontSize: 20,
      color: ColorFamily.black
  );

  /// 다이얼로그 강조 버튼 텍스트 스타일. size 20, pink
  static const TextStyle dialogButtonTextStyle_pink = TextStyle(
      fontFamily: FontFamily.mapleStoryLight,
      fontSize: 20,
      color: ColorFamily.pink
  );
  /// 소제목 텍스트 스타일. size 15
  static const TextStyle smallTitleTextStyle = TextStyle(fontFamily: FontFamily.mapleStoryLight, fontSize: 15, color: ColorFamily.black);

  

  /// 비밀번호 입력 숫자 텍스트 스타일. size 20
  static const TextStyle passwordTextStyle = TextStyle(fontFamily: FontFamily.mapleStoryLight, fontSize: 20, color: ColorFamily.black);
}