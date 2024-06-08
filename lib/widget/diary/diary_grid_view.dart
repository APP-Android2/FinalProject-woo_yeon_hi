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
  late int user_idx; // 유저 테이블 연동 할 것
  List<Diary> diaryList = [];
  late int filter_editor;
  late int filter_sort;
  late String filter_start;
  late String filter_end;

  @override
  void initState() {
    user_idx = 0;
    filter_editor = widget.provider.isSelected_editor.indexWhere((element) => element);
    filter_sort = widget.provider.isSelected_sort.indexWhere((element) => element);
    filter_start = widget.provider.startPeriod;
    filter_end = widget.provider.endPeriod;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getDiaryData(user_idx, filter_editor, filter_sort, filter_start, filter_end),
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return const Center(child: CircularProgressIndicator(color: ColorFamily.pink,));
        }else if(snapshot.hasError){
          return const Text("오류가 발생했습니다.\n잠시후에 다시 시도해주세요.", style: TextStyleFamily.normalTextStyle,);
        }else{
          var mapDataList = snapshot.data!;
          for(var mapData in mapDataList){
            diaryList.add(Diary.fromData(mapData));
          }
          return MasonryGridView.count(
              itemCount: diaryList.length,
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              itemBuilder: (context, index) {
                return FutureBuilder(
                    future: makeDiary(context, diaryList[index]),
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
      },
    );
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
                child: await getDiaryImagePath(diary.diaryImage)
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