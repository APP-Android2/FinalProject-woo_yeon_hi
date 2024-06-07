import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:woo_yeon_hi/style/color.dart';

import '../../widget/diary/diary_edit_album.dart';
import '../../widget/diary/diary_edit_textInput.dart';
import '../../widget/diary/diary_edit_top_app_bar.dart';
import '../../widget/diary/diary_edit_weather.dart';

class DiaryEditScreen extends StatefulWidget {
  const DiaryEditScreen({super.key});

  @override
  State<DiaryEditScreen> createState() => _DiaryEditScreenState();
}

class _DiaryEditScreenState extends State<DiaryEditScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorFamily.cream,
      appBar: const DiaryEditTopAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 날짜, 쓴 사람, 날씨
                DiaryEditWeather(),
                // 썸네일 등록
                DiaryEditAlbum()
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            // 일기 작성
            Expanded(
                child: LayoutBuilder(
                    builder: (context, constraints){
                      return SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight
                          ),
                          child: const IntrinsicHeight(
                            child: DiaryEditTextInput(),
                          ),
                        ),
                      );
                    }
                )
            )
          ],
        ),
      ),
    );
  }
}
