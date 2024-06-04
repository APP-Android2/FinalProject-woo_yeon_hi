import 'package:flutter/material.dart';
import 'package:woo_yeon_hi/style/color.dart';

import '../../widget/diary/diary_detail_album.dart';
import '../../widget/diary/diary_detail_content.dart';
import '../../widget/diary/diary_detail_top_app_bar.dart';
import '../../widget/diary/diary_detail_weather.dart';

class DiaryDetailScreen extends StatefulWidget {
  const DiaryDetailScreen({super.key});

  @override
  State<DiaryDetailScreen> createState() => _DiaryDetailScreenState();
}

class _DiaryDetailScreenState extends State<DiaryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorFamily.cream,
      appBar: const DiaryDetailTopAppBar(),
      body: Padding(
          padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 날짜, 쓴 사람, 날씨
                DiaryDetailWeather(),
                // 썸네일
                DiaryDetailAlbum()
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
                            child: DiaryDetailContent(),
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
