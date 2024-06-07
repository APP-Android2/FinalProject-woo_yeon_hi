import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/screen/footPrint/footprint_history_detail_screen.dart';
import 'package:woo_yeon_hi/screen/footPrint/footprint_history_edit_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/widget/footPrint/footprint_history_top_app_bar.dart';

import '../../provider/footprint_provider.dart';
import '../../style/text_style.dart';

class FootprintHistoryScreen extends StatefulWidget {
  const FootprintHistoryScreen({super.key});

  @override
  State<FootprintHistoryScreen> createState() => _FootprintHistoryScreenState();
}

class _FootprintHistoryScreenState extends State<FootprintHistoryScreen> {
  List<String> historyPlace = ["서교동", "역삼동", "이태원동", "명동", "한남동"];
  List<Widget> historyItems = [];

  @override
  Widget build(BuildContext context) {
    historyItems = List.generate(5, (index) => makeHistoryItem(context, index));
    return ChangeNotifierProvider(
      create: (context) => FootprintHistoryProvider(historyItems.length),
      child:
          Consumer<FootprintHistoryProvider>(builder: (context, provider, _) {
        return Scaffold(
          backgroundColor: ColorFamily.cream,
          appBar: const FootprintHistoryTopAppBar(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: ColorFamily.beige,
            shape: const CircleBorder(),
            child: SvgPicture.asset('lib/assets/icons/edit.svg'),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const FootprintHistoryEditScreen()));
            },
          ),
          body: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            provider.expandAll();
                          },
                          style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                          ),
                          child: Text(
                            "모두펼치기",
                            style: textStyle,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            provider.collapseAll();
                          },
                          style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                          ),
                          child: Text(
                            "모두접기",
                            style: textStyle,
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: historyPlace.length,
                          itemBuilder: (context, index) =>
                              makeHistory(context, index, provider))),
                ],
              )),
        );
      }),
    );
  }

  Widget makeHistory(
      BuildContext context, int index, FootprintHistoryProvider provider) {
    return ExpansionTile(
      key: UniqueKey(),
      controlAffinity: ListTileControlAffinity.leading,
      tilePadding: EdgeInsets.zero,
      shape: const Border(),
      backgroundColor: Colors.transparent,
      iconColor: ColorFamily.black,
      dense: true,
      initiallyExpanded: provider.isExpandedList[index],
      expansionAnimationStyle: AnimationStyle(
          curve: Curves.ease, duration: const Duration(milliseconds: 300)),
      onExpansionChanged: (isExpanded) {
        provider.setExpansionState(index, isExpanded);
      },
      title: Text(
        historyPlace[index],
        style: TextStyleFamily.normalTextStyle,
      ),
      children: [
        SizedBox(
            height: 120,
            child: ListView(
                scrollDirection: Axis.horizontal, children: historyItems))
      ],
    );
  }
  Widget makeHistoryItem(BuildContext context, int index) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => FootprintHistoryDetailScreen(historyPlace[index], index)));
      },
      child: SizedBox(
        width: 120,
        height: 120,
        child: Card(
          color: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 4,
          child: Stack(
            fit: StackFit.expand,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'lib/assets/images/test_couple.png',
                    fit: BoxFit.cover,
                  )),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Wrap(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xff393939).withOpacity(0.6),
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)), // 원하는 반지름 값
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              SizedBox(
                                  width: 120,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "한강 산책",
                                        style: historyCardTextStyle,
                                      )
                                    ],
                                  )),
                              SizedBox(
                                  width: 120,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "2024. 5. 14.",
                                        style: historyCardTextStyle,
                                      )
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}



TextStyle historyCardTextStyle = const TextStyle(
    fontFamily: FontFamily.mapleStoryLight,
    fontSize: 10,
    color: ColorFamily.white);

// 모두 펼치기, 모두 접기 텍스트 스타일
TextStyle textStyle = const TextStyle(
    fontFamily: FontFamily.mapleStoryLight,
    fontSize: 12,
    color: ColorFamily.black);
