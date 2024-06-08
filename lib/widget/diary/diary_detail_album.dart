import 'package:flutter/material.dart';
import 'package:woo_yeon_hi/dao/diary_dao.dart';
import 'package:woo_yeon_hi/model/diary_model.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/text_style.dart';

class DiaryDetailAlbum extends StatefulWidget {
  DiaryDetailAlbum(this.diary, {super.key});
  Diary diary;

  @override
  State<DiaryDetailAlbum> createState() => _DiaryDetailAlbumState();
}

class _DiaryDetailAlbumState extends State<DiaryDetailAlbum> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 110,
        height: 110,
        color: ColorFamily.white,
        child: FutureBuilder(
          future: getDiaryImagePath(widget.diary.diaryImage),
          builder: (context, snapshot) {
            if (snapshot.hasData == false) {
              return const SizedBox();
            } else if (snapshot.hasError) {
              return const Text(
                "network error",
                style: TextStyleFamily.normalTextStyle,
              );
            } else {
              return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: snapshot.data);
            }
          },
        ));
  }
}
