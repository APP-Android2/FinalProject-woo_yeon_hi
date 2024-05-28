import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:woo_yeon_hi/screen/diary_detail_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/text_style.dart';

class DiaryGridView extends StatefulWidget {
  const DiaryGridView({super.key});

  @override
  State<DiaryGridView> createState() => _DiaryGridViewState();
}

class _DiaryGridViewState extends State<DiaryGridView> {
  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
        itemCount: 10,
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemBuilder: (context, index) => makeDiary(context));
  }
}

Widget makeDiary(BuildContext context) {
  return InkWell(
    onTap: (){
      Navigator.push(context, 
      MaterialPageRoute(builder: (context) => const DiaryDetailScreen()));
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
                child: Image.asset(
                  'lib/assets/images/test_couple.png',
                  fit: BoxFit.fitWidth,
                )),
            const SizedBox(
              height: 10,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "2024. 5.17.",
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
