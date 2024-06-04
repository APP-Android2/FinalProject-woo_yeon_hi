import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/style/text_style.dart';

import '../../provider/footprint_provider.dart';

class FootprintHistoryEditPlaceInfo extends StatefulWidget {
  FootprintHistoryEditPlaceInfo(this.title, this.classfication, this.address, this.provider, {super.key});
  String title;
  String classfication;
  String address;
  FootprintHistoryEditProvider provider;

  @override
  State<FootprintHistoryEditPlaceInfo> createState() => _FootprintHistoryEditPlaceInfoState();
}

class _FootprintHistoryEditPlaceInfoState extends State<FootprintHistoryEditPlaceInfo> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        decoration: BoxDecoration(
          color: ColorFamily.white,
          borderRadius: BorderRadius.circular(15), // 모서리를 둥글게 설정
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7 - 40,
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7 - 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(widget.title, style: TextStyleFamily.normalTextStyle,),
                          const SizedBox(width: 5,),
                          Text(widget.classfication, style: const TextStyle(
                            fontFamily: FontFamily.mapleStoryLight,
                            fontSize: 10,
                            color: ColorFamily.gray
                          ),)
                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7 - 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(widget.address, style: TextStyleFamily.normalTextStyle,),
                          ],
                        ))
                  ],
                ),
              ),
              InkWell(
                splashColor: ColorFamily.gray,
                onTap: (){
                  _showDoneDialog(context, widget.provider);
                },
                child: SvgPicture.asset('lib/assets/icons/add.svg'),
              )
            ],
          ),
        ),

      ),
    );
  }
}


void _showDoneDialog(
    BuildContext context, FootprintHistoryEditProvider provider) {
  showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          surfaceTintColor: ColorFamily.white,
          backgroundColor: ColorFamily.white,
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "서울 지역을 선택하시겠습니까?",
                      style: TextStyleFamily.dialogTitleTextStyle,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                            style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(
                                    ColorFamily.gray)),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "취소",
                              style: TextStyleFamily.dialogButtonTextStyle,
                            )),
                        TextButton(
                            style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(
                                    ColorFamily.gray)),
                            onPressed: () {
                              Navigator.pop(context); // 다이얼로그 팝
                              Navigator.pop(context); // 지역 선택 페이지 팝
                            },
                            child: const Text(
                              "확인",
                              style: TextStyleFamily.dialogButtonTextStyle_pink,
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      });
}