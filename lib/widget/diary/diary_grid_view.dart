import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:woo_yeon_hi/dao/diary_dao.dart';
import 'package:woo_yeon_hi/model/enums.dart';
import 'package:woo_yeon_hi/provider/diary_provider.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/text_style.dart';

import '../../model/diary_model.dart';
import '../../screen/diary/diary_detail_screen.dart';
import '../../screen/diary/diary_unchecked_screen.dart';

class DiaryGridView extends StatefulWidget {
  DiaryGridView(this.provider, {super.key});
  DiaryProvider provider;
  @override
  State<DiaryGridView> createState() => _DiaryGridViewState();
}

class _DiaryGridViewState extends State<DiaryGridView> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // executes after build
      var user_idx = 0;
      var unCheckedDiary = isReadAll(user_idx, widget.provider.diaryData);
      if(unCheckedDiary != null){
        Navigator.push(context, MaterialPageRoute(builder: (context) => DiaryUncheckedScreen(unCheckedDiary)));
      }

    });
    return MasonryGridView.count(
        itemCount: widget.provider.diaryData.length,
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemBuilder: (context, index) {
          return FutureBuilder(
              future: makeDiary(context, widget.provider.diaryData[index]),
              builder: (context, widgetSnapshot){
                if(widgetSnapshot.hasData == false){
                  return const SizedBox();
                }else if(widgetSnapshot.hasError){
                  return const Center(
                    child: Text("이미지 다운 에러", style: TextStyleFamily.normalTextStyle,),
                  );
                }else{
                  return widgetSnapshot.data!;
                }
              });
        });
  }
}

Future<Widget> makeDiary(BuildContext context, Diary diary) async {
  return InkWell(
    onTap: (){
      Navigator.push(context, 
      MaterialPageRoute(builder: (context) => DiaryDetailScreen(diary)));
    },
    child: Card(
      color: ColorFamily.white,
      surfaceTintColor: ColorFamily.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            AspectRatio(
                aspectRatio: 1.0,
                child: await getDiaryImage(diary.diaryImage)
                // child: await getDiaryImagePath(diary.diaryImage)
              
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  diary.diaryDate,
                  style: TextStyleFamily.normalTextStyle,
                ),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "우연남",
                  style: TextStyleFamily.normalTextStyle,
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}

Diary? isReadAll(int user_index, List<Diary> diaryList) {
  for (var diary in diaryList) {
    // 자신이 쓴게 아니고, 읽지 않았다면
    if (diary.diaryUserIdx != user_index && !diary.diaryLoverCheck) {
      return diary;
    }
  }
  return null;
}