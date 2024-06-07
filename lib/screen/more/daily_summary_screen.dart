import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/text_style.dart';
import 'package:woo_yeon_hi/widget/more/daily_summary_calendar.dart';
import 'package:woo_yeon_hi/widget/more/daily_summary_top_app_bar.dart';

import '../../model/dDay_model.dart';
import '../../style/font.dart';
import '../calendar/calendar_detail_screen.dart';
import '../diary/diary_detail_screen.dart';
import '../footPrint/footprint_history_detail_screen.dart';
import '../ledger/ledger_detail_screen.dart';

class DailySummaryScreen extends StatefulWidget {
  const DailySummaryScreen({super.key});

  @override
  State<DailySummaryScreen> createState() => _DailySummaryScreenState();
}

class _DailySummaryScreenState extends State<DailySummaryScreen> {
  late DateTime _summaryDay;
  late DateTime _selectedDay;
  bool summaryIndex = true;

  @override
  void initState() {
    super.initState();

    _summaryDay = DateTime.now();
    _selectedDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;
    List<Widget> dDayItems = List.generate(3, (index) => makeDdayItem(context,
        index,
        DateFormat('yyyy. M. d.')
            .format(_summaryDay)));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const DailySummaryTopAppBar(),
      body: Container(
        height: deviceHeight,
        width: deviceWidth,
        color: ColorFamily.cream,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        _summaryDay =
                            _summaryDay.subtract(const Duration(days: 1));
                      });
                    },
                    icon:
                        SvgPicture.asset("lib/assets/icons/arrow_left.svg")),
                Material(
                    color: ColorFamily.cream,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        showMaterialModalBottomSheet(
                            backgroundColor: ColorFamily.white,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20))),
                            context: context,
                            builder: (context) => SizedBox(
                                height: deviceHeight * 0.54,
                                child: Column(children: [
                                  const DailySummaryCalendar(),
                                  Material(
                                    color: ColorFamily.beige,
                                    elevation: 0.5,
                                    shadowColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0),
                                    ),
                                    child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            _summaryDay = _selectedDay;
                                          });
                                          Navigator.pop(context);
                                        },
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        child: SizedBox(
                                            width: deviceWidth - 40,
                                            height: 40,
                                            child: const Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                "확인",
                                                style: TextStyleFamily
                                                    .normalTextStyle,
                                              ),
                                            ))),
                                  ),
                                  const SizedBox(height: 20)
                                ])));
                      },
                      child: Column(
                        children: [
                          Text(DateFormat('yyyy. M. d.').format(_summaryDay),
                              style: TextStyleFamily.normalTextStyle),
                          const SizedBox(
                              height: 5,
                              width: 100,
                              child: Divider(
                                color: ColorFamily.black,
                                thickness: 0.5,
                              ))
                        ],
                      ),
                    )),
                IconButton(
                    onPressed: () {
                      setState(() {
                        if (DateFormat('yyyy. M. d.').format(_summaryDay) !=
                            DateFormat('yyyy. M. d.')
                                .format(DateTime.now())) {
                          _summaryDay =
                              _summaryDay.add(const Duration(days: 1));
                        }
                      });
                    },
                    icon:
                        SvgPicture.asset("lib/assets/icons/arrow_right.svg")),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: deviceWidth - 40,
              height: deviceHeight * 0.8,
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: DotsColor.scarlet),
                          ),
                          const SizedBox(width: 10),
                          const Text("디데이",
                              style: TextStyleFamily.smallTitleTextStyle)
                        ],
                      ),
                      const SizedBox(height: 10),
                      // 이벤트가 없을 경우
                      // const Padding(
                      //       padding: EdgeInsets.only(left: 20),
                      //       child: Text("이벤트가 없습니다.", style: TextStyleFamily.normalTextStyle)),
                      // SizedBox(
                      //   height: deviceHeight*0.11,
                      //   child:
                      //   Swiper(
                      //     scrollDirection: Axis.vertical,
                      //     viewportFraction: 1.0,
                      //     scale: 0.5,
                      //     itemBuilder:
                      //         (BuildContext context, int index) {
                      //       return dDayItems[index];
                      //     },
                      //     itemCount: dDayItems.length,
                      //     loop: false,
                      //     autoplay: false,
                      //   ),
                      // ),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 3,
                          itemBuilder: (context, index) => makeDdayItem(
                              context,
                              index,
                              DateFormat('yyyy. M. d.')
                                  .format(_summaryDay))),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: DotsColor.brown),
                          ),
                          const SizedBox(width: 10),
                          const Text("캘린더",
                              style: TextStyleFamily.smallTitleTextStyle)
                        ],
                      ),
                      const SizedBox(height: 10),
                      // 이벤트가 없을 경우 child
                      // const Padding(
                      //       padding: EdgeInsets.only(left: 20),
                      //       child: Text("이벤트가 없습니다.", style: TextStyleFamily.normalTextStyle),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: deviceWidth-60,
                          color: ColorFamily.white,
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 5,
                              itemBuilder: (context, index) => makeCalendarItem(
                                  context,
                                  index,
                                  DateFormat('yyyy. M. d.')
                                      .format(_summaryDay)),
                            separatorBuilder: (context, index) {
                              return const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Divider(color: ColorFamily.gray, thickness: 0.5,),
                              );
                            }
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      Row(
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: DotsColor.pastelYellow),
                          ),
                          const SizedBox(width: 10),
                          const Text("가계부",
                              style: TextStyleFamily.smallTitleTextStyle)
                        ],
                      ),
                      const SizedBox(height: 10),
                      // 이벤트가 없을 경우 child
                      // const Padding(
                      //       padding: EdgeInsets.only(left: 20),
                      //       child: Text("이벤트가 없습니다.", style: TextStyleFamily.normalTextStyle),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 5,
                          itemBuilder: (context, index) => makeLedgerItem(
                              context,
                              index,
                              DateFormat('yyyy. M. d.')
                                  .format(_summaryDay))),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: DotsColor.cyan),
                          ),
                          const SizedBox(width: 10),
                          const Text("교환일기",
                              style: TextStyleFamily.smallTitleTextStyle)
                        ],
                      ),
                      const SizedBox(height: 10),
                      // 이벤트가 없을 경우 child
                      // const Padding(
                      //       padding: EdgeInsets.only(left: 20),
                      //       child: Text("이벤트가 없습니다.", style: TextStyleFamily.normalTextStyle),
                      SizedBox(
                        height: deviceHeight * 0.2,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 4,
                            itemBuilder: (context, index) => makeDiaryItem(
                                context,
                                index,
                                DateFormat('yyyy. M. d.')
                                    .format(_summaryDay))),
                      ),
                      const SizedBox(height: 20),

                      Row(
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: DotsColor.pastelPink),
                          ),
                          const SizedBox(width: 10),
                          const Text("히스토리",
                              style: TextStyleFamily.smallTitleTextStyle)
                        ],
                      ),
                      const SizedBox(height: 10),
                      // 이벤트가 없을 경우 child
                      // const Padding(
                      //       padding: EdgeInsets.only(left: 20),
                      //       child: Text("이벤트가 없습니다.", style: TextStyleFamily.normalTextStyle),
                      SizedBox(
                        height: deviceHeight * 0.15,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 4,
                            itemBuilder: (context, index) => makeHistoryItem(
                                context,
                                index,
                                DateFormat('yyyy. M. d.')
                                    .format(_summaryDay))),
                      ),
                      const SizedBox(height: 20),

                      Row(
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: DotsColor.green),
                          ),
                          const SizedBox(width: 10),
                          const Text("데이트 플랜",
                              style: TextStyleFamily.smallTitleTextStyle)
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                          padding: const EdgeInsets.only(left: 20),
                          child: const Text("이벤트가 없습니다.",
                              style: TextStyleFamily
                                  .normalTextStyle) // 데이터가 없을 때
                          //TODO 데이터가 있을 때 child -> 해당 데이터 보여줄 컨테이너(누르면 해당 데이터 페이지로 이동)
                          ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// 디데이 아이템
Widget makeDdayItem(BuildContext context, int index, String summaryDay){
  List<dDayModel> dDayList = [
    dDayModel(title: "연애 D+", content: "오래오래 가자", count: "100일 째", date: "2024. 3.01. ~"),
    dDayModel(title: "생일", content: "우연녀 생일", count: "D-100", date: "2024. 8.25.(일)"),
    dDayModel(title: "200일", content: "만난지 200일 ♥️", count: "D-100", date: "2024. 8.25. (일)"),
  ];
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: SizedBox(
      width: MediaQuery.of(context).size.width - 40,
      child: Wrap(
        children: [
          Card(
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Column(
                children: [
                  // title, count
                  SizedBox(
                      width: MediaQuery.of(context).size.width - 40 - 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(dDayList[index].title, style: const TextStyle(
                              fontFamily: FontFamily.mapleStoryLight,
                              fontSize: 20,
                              color: ColorFamily.black
                          )),
                          Text(dDayList[index].count, style: const TextStyle(
                              fontFamily: FontFamily.mapleStoryBold,
                              fontSize: 20,
                              color: ColorFamily.pink
                          ))
                        ],
                      )
                  ),
                  const SizedBox(height: 20,),
                  // content, date
                  SizedBox(
                      width: MediaQuery.of(context).size.width - 40 - 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(dDayList[index].content, style: const TextStyle(
                              fontFamily: FontFamily.mapleStoryLight,
                              fontSize: 14,
                              color: ColorFamily.gray
                          )),
                          Text(dDayList[index].date, style: const TextStyle(
                              fontFamily: FontFamily.mapleStoryLight,
                              fontSize: 14,
                              color: ColorFamily.gray
                          ))
                        ],
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}


// 캘린더 아이템
Widget makeCalendarItem(BuildContext context, int index, String summaryDay) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const CalendarDetailScreen()));
      },
      child: Container(
        color: ColorFamily.white,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            SizedBox(
              width: 5,
              height: 35,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: ColorFamily.green,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              "롯데월드 $index",
              style: TextStyleFamily.normalTextStyle,
            ),
            const Spacer(),
            const Text(
              "10:00 ~ 12:00",
              style: TextStyleFamily.normalTextStyle,
            )
          ],
        ),
      ),
    ),
  );
}

// 가계부 아이템
Widget makeLedgerItem(BuildContext context, int index, String summaryDay) {
  return Container(
    height: 60,
    padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
    margin: const EdgeInsets.only(bottom: 5),
    child: Material(
      color: ColorFamily.white,
      elevation: 1,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: ColorFamily.white),
        child: ListTile(
          splashColor: Colors.transparent,
          leading: SvgPicture.asset('lib/assets/icons/spoon_fork.svg',
              width: 24, height: 24),
          title: const Text('식비',
              style: TextStyle(
                  color: ColorFamily.black,
                  fontSize: 14,
                  fontFamily: FontFamily.mapleStoryLight)),
          trailing: const Text("5,900" + '원',
              style: TextStyle(
                  color: ColorFamily.black,
                  fontSize: 10,
                  fontFamily: FontFamily.mapleStoryLight)),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => LedgerDetailScreen(),
              ),
            );
          },
        ),
      ),
    ),
  );
}

// 교환일기 아이템
Widget makeDiaryItem(BuildContext context, int index, String summaryDay) {
  return InkWell(
    onTap: () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const DiaryDetailScreen()));
    },
    child: Container(
      margin: EdgeInsets.only(right: 5),
      width: 130,
      child: Card(
        color: ColorFamily.white,
        surfaceTintColor: ColorFamily.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(summaryDay,
                      style: const TextStyle(
                          fontFamily: FontFamily.mapleStoryLight,
                          color: ColorFamily.black,
                          fontSize: 12)),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("우연남",
                      style: TextStyle(
                          fontFamily: FontFamily.mapleStoryLight,
                          color: ColorFamily.black,
                          fontSize: 12)),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}

// 히스토리 아이템
Widget makeHistoryItem(BuildContext context, int index, String summaryDay) {
  List<String> historyPlace = ["서교동", "역삼동", "이태원동", "명동", "한남동"];

  return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    FootprintHistoryDetailScreen(historyPlace[index], index)));
      },
      child: SizedBox(
        width: 130,
        height: 130,
        child: Card(
          color: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 1,
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
                          padding: EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              const SizedBox(
                                  width: 120,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text("한강 산책",
                                          style: TextStyle(
                                              fontFamily:
                                                  FontFamily.mapleStoryLight,
                                              fontSize: 10,
                                              color: ColorFamily.white))
                                    ],
                                  )),
                              SizedBox(
                                  width: 120,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(summaryDay,
                                          style: const TextStyle(
                                              fontFamily:
                                                  FontFamily.mapleStoryLight,
                                              fontSize: 10,
                                              color: ColorFamily.white))
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
      ));
}
