import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/style/color.dart';

import '../../provider/diary_provider.dart';
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
    return ChangeNotifierProvider(
      create: (context) => DiaryProvider(),
      child: Consumer<DiaryProvider>(
        builder: (context, provider, _){
          return Scaffold(
            backgroundColor: ColorFamily.cream,
            appBar: DiaryEditTopAppBar(provider),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // 날짜, 쓴 사람, 날씨
                      DiaryEditWeather(provider),
                      // 썸네일 등록
                      DiaryEditAlbum(provider)
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
                                child: IntrinsicHeight(
                                  child: DiaryEditTextInput(provider),
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
        },
      ),
    );
  }
}
