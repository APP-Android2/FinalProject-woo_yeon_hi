import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:woo_yeon_hi/provider/footprint_provider.dart';
import 'package:woo_yeon_hi/screen/footPrint/footprint_history_edit_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/text_style.dart';
import 'package:woo_yeon_hi/widget/footPrint/footprint_history_detail_top_app_bar.dart';

import '../../style/font.dart';

class FootprintHistoryDetailScreen extends StatefulWidget {
  FootprintHistoryDetailScreen(this.mapIdx, this.title, this.index, {super.key});
  int mapIdx;
  String title;
  int index;

  @override
  State<FootprintHistoryDetailScreen> createState() =>
      _FootprintHistoryDetailScreenState();
}

class _FootprintHistoryDetailScreenState
    extends State<FootprintHistoryDetailScreen> {
  // scroll controller.
  final AutoScrollController _controller = AutoScrollController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FootPrintHistoyDetailProvider(5),
      child: Consumer<FootPrintHistoyDetailProvider>(
        builder: (context, provider, _) {
          // 해당 인덱스로 스크롤을 이동합니다.
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _controller.scrollToIndex(
              widget.index,
              duration: const Duration(milliseconds: 300),
              preferPosition: AutoScrollPosition.middle,
            );
          });
          return Scaffold(
              backgroundColor: ColorFamily.cream,
              appBar: FootprintHistoryDetailTopAppBar(widget.title),
              body: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: ListView.builder(
                    controller: _controller,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return AutoScrollTag(
                          key: ValueKey(index),
                          controller: _controller,
                          index: index,
                          child: makeHistoryDeatil(context, index, widget.mapIdx, provider));
                    }),
              ));
        },
      ),
    );
  }
}

Widget makeHistoryDeatil(
    BuildContext context, int index, int mapIdx, FootPrintHistoyDetailProvider provider) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Column(
      children: [
        // 프로필 사진, 타이틀, 날짜, 메뉴
        SizedBox(
          width: MediaQuery.of(context).size.width - 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // 프로필 사진
                  SizedBox(
                    width: 56,
                    height: 56,
                    child: ClipOval(
                      child: Image.asset(
                        'lib/assets/images/text_profile.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  // 제목, 날짜
                  SizedBox(
                    width:
                        MediaQuery.of(context).size.width - 40 - 56 - 48 - 10,
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("한강 산책",
                                style: TextStyleFamily.dialogButtonTextStyle),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "2024. 3. 13.",
                              style: dateTextStyle,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              // 수정, 삭제
              IconButton(
                  onPressed: () {
                    _showModalBottomSheet(context, mapIdx);
                  },
                  icon: SvgPicture.asset('lib/assets/icons/menu_vertical.svg'))
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        // 사진
        Container(
          width: MediaQuery.of(context).size.width - 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: FlutterCarousel(
                items: List.generate(
                    5,
                    (index) => Image.asset(
                          'lib/assets/images/test_couple.png',
                          fit: BoxFit.contain,
                        )),
                options: CarouselOptions(
                  viewportFraction: 1.0,
                  showIndicator: true,
                  floatingIndicator: false,
                  aspectRatio: 2 / 3,
                  slideIndicator: const CircularSlideIndicator(
                      currentIndicatorColor: ColorFamily.pink,
                      indicatorBackgroundColor: ColorFamily.gray),
                ),
              )),
        ),
        const SizedBox(
          height: 10,
        ),
        // 내용
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 40 - 10,
                child: Text(
                  tmpContent,
                  style: TextStyleFamily.normalTextStyle,
                  overflow:
                      provider.isMoreList[index] ? TextOverflow.ellipsis : null,
                  maxLines: provider.isMoreList[index] ? 2 : null,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 40 - 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        if (provider.isMoreList[index]) {
                          provider.setMoreState(index, false);
                        } else {
                          provider.setMoreState(index, true);
                        }
                      },
                      child: Text(
                        provider.isMoreList[index] ? "더보기" : "접기",
                        style: contentMoreTextStyle,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        const Divider(
          height: 20,
          color: ColorFamily.gray,
        )
      ],
    ),
  );
}

TextStyle dateTextStyle = const TextStyle(
    fontFamily: FontFamily.mapleStoryLight,
    fontSize: 12,
    color: ColorFamily.black);

TextStyle contentMoreTextStyle = const TextStyle(
    fontFamily: FontFamily.mapleStoryLight,
    fontSize: 12,
    color: ColorFamily.gray);

String tmpContent =
    "비오는 날 한강 데이트는 로맨틱하고 아름다웠다. 우산을 나란히 쓰고 강변을 걷던 순간, 빗소리와 강물 소리가 행복한 기억으로 남았다. 카페에서는 따뜻한 커피를 마시며 서로를 더 깊게 알아갔고, 한강 위에서의 배 타기는 색다른 즐거움을 주었다. 마지막으로 함께 한 벤치에서 한강의 야경을 감상하며 소중한 순간을 공유했다. 오늘의 데이트는 우리에게 잊지 못할 특별한 경험이었다.";

void _showModalBottomSheet(BuildContext context, int mapIdx) {
  showModalBottomSheet(
      context: context,
      showDragHandle: true,
      backgroundColor: ColorFamily.white,
      builder: (context) {
        return Wrap(
          children: [
            Column(
              children: [
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    // 바텀 시트 다이얼로그 팝
                    Navigator.pop(context);
                    // 수정 페이지로
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FootprintHistoryEditScreen(mapIdx)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 5, 30, 15),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset('lib/assets/icons/edit.svg'),
                          const Text(
                            "수정",
                            style: TextStyleFamily.dialogButtonTextStyle,
                          ),
                          const SizedBox(
                            width: 24,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const Divider(
                  color: ColorFamily.gray,
                ),
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    _showDoneDialog(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 20, 30, 25),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset('lib/assets/icons/delete.svg',
                              colorFilter: const ColorFilter.mode(
                                  ColorFamily.pink, BlendMode.srcIn)),
                          const Text(
                            "삭제",
                            style: TextStyleFamily.dialogButtonTextStyle_pink,
                          ),
                          const SizedBox(
                            width: 24,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        );
      });
}

void _showDoneDialog(BuildContext context) {
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
                      "히스토리를 삭제하시겠습니까?",
                      style: TextStyleFamily.dialogButtonTextStyle,
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
                              Navigator.pop(context); // 바텀시트 팝
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
