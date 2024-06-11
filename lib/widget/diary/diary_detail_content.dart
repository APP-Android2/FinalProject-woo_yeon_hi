import 'package:flutter/material.dart';
import 'package:woo_yeon_hi/model/diary_model.dart';

import '../../style/color.dart';
import '../../style/font.dart';
import '../../style/text_style.dart';

class DiaryDetailContent extends StatefulWidget {
  DiaryDetailContent(this.diary, {super.key});
  Diary diary;

  @override
  State<DiaryDetailContent> createState() => _DiaryDetailContentState();
}

class _DiaryDetailContentState extends State<DiaryDetailContent> {
  final TextEditingController _titleTextEditController = TextEditingController();
  final TextEditingController _contentTextEditController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _titleTextEditController.text = widget.diary.diaryTitle;
    _contentTextEditController.text = widget.diary.diaryContent;

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
                  controller: _titleTextEditController,
                  cursorColor: ColorFamily.black,
                  enabled: false,
                  decoration: const InputDecoration(
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
                  controller: _contentTextEditController,
                  keyboardType: TextInputType.multiline,
                  cursorColor: ColorFamily.black,
                  scrollPhysics: const NeverScrollableScrollPhysics(),
                  enabled: false,
                  decoration: const InputDecoration(
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
