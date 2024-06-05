import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/provider/dDay_provider.dart';
import 'package:woo_yeon_hi/screen/dDay/dDay_make_custom_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';

class dDayAddListView extends StatefulWidget {
  const dDayAddListView({super.key});

  @override
  State<dDayAddListView> createState() => _dDayAddListViewState();
}

class _dDayAddListViewState extends State<dDayAddListView> {
  List<String> title = ["100일", "200일", "300일", "사귄지 1년", "발렌타인 데이", "화이트 데이"];
  List<String> date = [
    "2024. 9.13.(금)",
    "2024.12.23.(월)",
    "2025. 4. 1.(화)",
    "2025. 6. 5.(목)",
    "2025. 2.14.(목)",
    "2025. 3.14.(목)",
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => dDayAddProvider(title.length),
      child: Consumer<dDayAddProvider>(
        builder: (context, provider, _){
          return Padding(
            padding: const EdgeInsets.only(top: 30),
            child: ListView.builder(
                itemCount: title.length,
                itemBuilder: (context, index) => _makeList(index, provider)),
          );
        }
      ),
    );
  }

  Widget _makeList(int index, dDayAddProvider provider) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => const dDayMakeCustomScreen()));
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title[index],
                style: titleTextStyle,
              ),
              Row(
                children: [
                  Text(
                    date[index],
                    style: dateTextStyle,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Checkbox(
                      side: const BorderSide(color: ColorFamily.gray),
                    activeColor: ColorFamily.pink,
                      checkColor: ColorFamily.white,
                      value: provider.isChecked[index],
                      onChanged: (value) {
                        provider.toggleCheck(index);
                      }
                  )
                ],
              )
            ],
          ),
          const Divider(height: 30,color: ColorFamily.gray,)
        ],
      ),
    );
  }
}

TextStyle titleTextStyle = const TextStyle(
    fontFamily: FontFamily.mapleStoryLight,
    fontSize: 20,
    color: ColorFamily.black);

TextStyle dateTextStyle = const TextStyle(
    fontFamily: FontFamily.mapleStoryLight,
    fontSize: 14,
    color: ColorFamily.gray);
