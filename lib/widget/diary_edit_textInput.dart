import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../style/color.dart';
import '../style/text_style.dart';

class DiaryEditTextInput extends StatefulWidget {
  const DiaryEditTextInput({super.key});

  @override
  State<DiaryEditTextInput> createState() => _DiaryEditTextInputState();
}

class _DiaryEditTextInputState extends State<DiaryEditTextInput> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 40,
      child: const Card(
        color: ColorFamily.white,
        surfaceTintColor: ColorFamily.white,
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // 제목
            Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: TextField(
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  maxLength: 20,

                  cursorColor: ColorFamily.black,
                  decoration: InputDecoration(
                    hintText: '제목을 입력해주세요.',
                    hintStyle: TextStyleFamily.hintTextStyle,
                    counter: SizedBox(),
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                        BorderSide(color: ColorFamily.black)),
                    border: UnderlineInputBorder(
                        borderSide:
                        BorderSide(color: ColorFamily.black)),
                    errorBorder: UnderlineInputBorder(
                        borderSide:
                        BorderSide(color: ColorFamily.black)),
                    focusedErrorBorder: UnderlineInputBorder(
                        borderSide:
                        BorderSide(color: ColorFamily.black)),
                    disabledBorder: UnderlineInputBorder(
                        borderSide:
                        BorderSide(color: ColorFamily.black)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide:
                        BorderSide(color: ColorFamily.black)),
                  ),
                  style: TextStyleFamily.normalTextStyle,
                )),
            // 내용
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: TextField(
                  maxLines: null,
                  expands: true,
                  keyboardType: TextInputType.multiline,
                  cursorColor: ColorFamily.black,
                  decoration: InputDecoration(
                    hintText: '내용을 입력해주세요.',
                    hintStyle: TextStyleFamily.hintTextStyle,
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                        BorderSide(color: ColorFamily.black)),
                    border: UnderlineInputBorder(
                        borderSide:
                        BorderSide(color: ColorFamily.black)),
                    errorBorder: UnderlineInputBorder(
                        borderSide:
                        BorderSide(color: ColorFamily.black)),
                    focusedErrorBorder: UnderlineInputBorder(
                        borderSide:
                        BorderSide(color: ColorFamily.black)),
                    disabledBorder: UnderlineInputBorder(
                        borderSide:
                        BorderSide(color: ColorFamily.black)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide:
                        BorderSide(color: ColorFamily.black)),
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
