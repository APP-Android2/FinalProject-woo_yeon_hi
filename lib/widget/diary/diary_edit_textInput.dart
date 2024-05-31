import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/provider/diary_provider.dart';
import 'package:woo_yeon_hi/style/font.dart';

import '../../style/color.dart';
import '../../style/text_style.dart';

class DiaryEditTextInput extends StatefulWidget {
  const DiaryEditTextInput({super.key});

  @override
  State<DiaryEditTextInput> createState() => _DiaryEditTextInputState();
}

class _DiaryEditTextInputState extends State<DiaryEditTextInput> {

  @override
  Widget build(BuildContext context) {
    var diaryProvider = Provider.of<DiaryProvider>(context, listen:false);
    return SizedBox(
      width: MediaQuery.of(context).size.width - 40,
      child: Card(
        color: ColorFamily.white,
        surfaceTintColor: ColorFamily.white,
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // 제목
            Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                child: TextField(
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  maxLength: 20,
                  controller: diaryProvider.titleTextEditController,
                  cursorColor: ColorFamily.black,
                  decoration: const InputDecoration(
                    hintText: '제목을 입력해주세요.',
                    hintStyle: TextStyleFamily.hintTitleTextStyle,
                    border: InputBorder.none,
                    counter: SizedBox()
                  ),
                  style: const TextStyle(
                    fontFamily: FontFamily.mapleStoryLight,
                    fontSize: 20,
                    color: ColorFamily.black
                  ),
                )),
            // 내용
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: TextField(
                  maxLines: null,
                  controller: diaryProvider.contentTextEditController,
                  keyboardType: TextInputType.multiline,
                  cursorColor: ColorFamily.black,
                  scrollPhysics: const NeverScrollableScrollPhysics(),
                  decoration: const InputDecoration(
                    hintText: '내용을 입력해주세요.',
                    hintStyle: TextStyleFamily.hintTextStyle,
                    border: InputBorder.none,

                  ),
                  style: TextStyleFamily.normalTextStyle,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
