import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/style/text_style.dart';

import '../../dialogs.dart';
import '../../provider/footprint_provider.dart';

class FootprintHistoryEditPlaceInfo extends StatefulWidget {
  FootprintHistoryEditPlaceInfo(this.provider, {super.key});
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
                          Flexible(child: Text(widget.provider.selectedPlace!.title, style: TextStyleFamily.normalTextStyle,)),
                          const SizedBox(width: 5,),
                          Flexible(
                            child: Text(widget.provider.selectedPlace!.category, style: const TextStyle(
                              fontFamily: FontFamily.mapleStoryLight,
                              fontSize: 10,
                              color: ColorFamily.gray
                            ),),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7 - 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(child: Text(widget.provider.selectedPlace!.roadAddress, style: TextStyleFamily.normalTextStyle,)),
                          ],
                        ))
                  ],
                ),
              ),
              InkWell(
                splashColor: ColorFamily.gray,
                onTap: (){
                  dialogTitleWithContent(
                      context,
                      widget.provider.selectedPlace!.title,
                      "지역을 선택하시겠습니까?",
                          () => _onCancle_back(context),
                          () => _onConfirm_back(context));
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

void _onCancle_back(BuildContext context){
  Navigator.pop(context);
}

void _onConfirm_back(BuildContext context){
  Navigator.pop(context); // 다이얼로그 팝
  Navigator.pop(context); // 일기 작성 페이지 팝
}
