import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/dao/history_dao.dart';
import 'package:woo_yeon_hi/model/enums.dart';
import 'package:woo_yeon_hi/model/history_model.dart';
import 'package:woo_yeon_hi/model/photo_map_model.dart';
import 'package:woo_yeon_hi/screen/footPrint/footprint_history_detail_screen.dart';
import 'package:woo_yeon_hi/screen/footPrint/footprint_history_edit_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/widget/footPrint/footprint_history_top_app_bar.dart';

import '../../dao/photo_map_dao.dart';
import '../../provider/footprint_provider.dart';
import '../../retrofit_interface/reverse_geo_coding_api.dart';
import '../../style/text_style.dart';

class FootprintHistoryScreen extends StatefulWidget {
  FootprintHistoryScreen(this.userIdx, this.photoMap, {super.key});
  int userIdx;
  PhotoMap photoMap;

  @override
  State<FootprintHistoryScreen> createState() => FootprintHistoryScreenState();
}

class FootprintHistoryScreenState extends State<FootprintHistoryScreen> {
  late Map<String, List<History>> historyMap;
  final Dio _reverseGCDio = Dio();
  late ReverseGeoCodingApi _reverseGCApi;

  @override
  Widget build(BuildContext context) {
    setHttp();
    return Scaffold(
      backgroundColor: ColorFamily.cream,
      appBar: FootprintHistoryTopAppBar(widget.photoMap),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorFamily.beige,
        shape: const CircleBorder(),
        child: SvgPicture.asset('lib/assets/icons/edit.svg'),
        onPressed: () {
          // 히스토리 작성
          Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          FootprintHistoryEditScreen(widget.photoMap)))
              .then((value) => setState(() {}));
        },
      ),
      body: FutureBuilder(
          future:
              getHisotryCategorization(widget.userIdx, widget.photoMap.mapIdx),
          builder: (context, snapshot) {
            if (snapshot.hasData == false) {
              return const Center(
                  child: CircularProgressIndicator(
                color: ColorFamily.pink,
              ));
            } else if (snapshot.hasError) {
              return const Center(
                  child: Text(
                "network error",
                style: TextStyleFamily.normalTextStyle,
              ));
            } else {
              historyMap = snapshot.data! as Map<String, List<History>>;
              return ChangeNotifierProvider(
                  create: (context) =>
                      FootprintHistoryProvider(historyMap.keys.length),
                  child: Consumer<FootprintHistoryProvider>(
                      builder: (context, provider, _) {
                    return Padding(
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
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.transparent),
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
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.transparent),
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
                                    itemCount: historyMap.keys.length,
                                    itemBuilder: (context, index) =>
                                        makeHistory(context, index, provider,
                                            historyMap.keys.toList()[index]))),
                          ],
                        ));
                  }));
            }
          }),
    );
    ;
  }

  Widget makeHistory(BuildContext context, int index,
      FootprintHistoryProvider provider, String key) {
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
        key,
        style: TextStyleFamily.normalTextStyle,
      ),
      children: [
        SizedBox(
            height: 120,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: historyMap[key]!.length,
                itemBuilder: (context, itemIndex) => makeHistoryItem(
                    context,
                    itemIndex,
                    widget.photoMap,
                    historyMap[key]![itemIndex],
                    key)))
      ],
    );
  }

  Widget makeHistoryItem(BuildContext context, int index, PhotoMap photoMap,
      History history, String key) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FootprintHistoryDetailScreen(
                        photoMap, index, historyMap[key]!)))
            .then((value) => setState(() {
              print("testtest");
        }));
      },
      child: SizedBox(
        width: 120,
        height: 120,
        child: Card(
          color: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 4,
          child: Stack(
            fit: StackFit.expand,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FutureBuilder(
                    future: getHistoryImage(history.historyImage.first),
                    builder: (context, snapshot) {
                      if (snapshot.hasData == false) {
                        return const SizedBox();
                      } else if (snapshot.hasError) {
                        return const Center(
                            child: Text(
                          "network error",
                          style: TextStyleFamily.normalTextStyle,
                        ));
                      } else {
                        return snapshot.data!;
                      }
                    },
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
                                        history.historyTitle,
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
                                        history.historyDate,
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

  Future<void> setHttp() async {
    await dotenv.load(fileName: ".env");
    _reverseGCDio.options.headers = {
      'X-NCP-APIGW-API-KEY-ID': dotenv.env['X-NCP-APIGW-API-KEY-ID'],
      'X-NCP-APIGW-API-KEY': dotenv.env['X-NCP-APIGW-API-KEY'],
    };
    _reverseGCApi = ReverseGeoCodingApi(_reverseGCDio);
  }

  Future<Map> getHisotryCategorization(int userIdx, int mapIdx) async {
    Map<String, List<History>> historyCategory = {};

    var historyList = await getHistory(userIdx, mapIdx);

    for (var history in historyList) {
      var map = await getPhotoMapByMapIdx(mapIdx);
      var place = await reverseGeoCoding(history.historyLocation, map.mapType);

      if (place != null) {
        if (historyCategory[place] != null) {
          historyCategory[place]!.add(history);
        } else {
          historyCategory[place] = [history];
        }
      }
    }

    return historyCategory;
  }

  Future<String?> reverseGeoCoding(GeoPoint coords, int mapType) async {
    try {
      final response = await _reverseGCApi.reverseGeocode(
          "${coords.longitude},${coords.latitude}", "legalcode", "json");
      var result = response.results.first;

      if (MapType.fromType(mapType)!.type == MapType.KOREA_FULL.type) {
        // 지도 타입이 한국 전체 지도인경우 00시 00구까지 리턴
        return "${result.region.area1.name} ${result.region.area2.name}";
      } else {
        // 그 외 지도 타입은 좀 더 세부적인 정보 리턴
        return "${result.region.area2.name} ${result.region.area3.name}";
      }
    } catch (e) {
      print("");
      print("Error: $e");
      print("");
    }
    return null;
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
