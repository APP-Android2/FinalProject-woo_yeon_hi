import 'package:flutter/material.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/widget/footPrint/footprint_history_edit_place_top_app_bar.dart';

import '../../provider/footprint_provider.dart';
import '../../style/text_style.dart';

class FootprintHistoryEditPlaceScreen extends StatefulWidget {
  FootprintHistoryEditPlaceScreen(this.provider, {super.key});
  FootprintHistoryEditProvider provider;

  @override
  State<FootprintHistoryEditPlaceScreen> createState() => _FootprintHistoryEditPlaceScreenState();
}

class _FootprintHistoryEditPlaceScreenState extends State<FootprintHistoryEditPlaceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorFamily.cream,
      appBar: const FootprintHistoryEditPlaceTopAppBar(),
      body: Center(
        child: AspectRatio(
          aspectRatio: 1/2,
          child: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: (){
              _showDoneDialog(context, widget.provider);
            },
            child: Image.asset('lib/assets/images/korea_full.png', fit: BoxFit.contain,),
          ),
        ),
      )

    );
  }
}

void _showDoneDialog(BuildContext context, FootprintHistoryEditProvider provider) {
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
                              provider.setPlace("서울");
                              Navigator.pop(context); // 다이얼로그 팝
                              Navigator.pop(context); // 지역 선택 페이지 팝
                            },
                            child: const Text(
                              "확인",
                              style:
                              TextStyleFamily.dialogButtonTextStyle_pink,
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


