import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/retrofit_interface/place_search_api.dart';
import 'package:woo_yeon_hi/style/color.dart';

import '../../provider/footprint_provider.dart';
import '../../retrofit_interface/reverse_geo_coding_api.dart';
import '../../style/font.dart';
import '../../style/text_style.dart';
import '../../widget/footPrint/footprint_history_edit_place_info.dart';

class FootprintHistoryEditPlaceScreen extends StatefulWidget {
  FootprintHistoryEditPlaceScreen(this.provider, this.mapType, {super.key});
  FootprintHistoryEditProvider provider;
  int mapType;

  @override
  State<FootprintHistoryEditPlaceScreen> createState() =>
      _FootprintHistoryEditPlaceScreenState();
}

class _FootprintHistoryEditPlaceScreenState
    extends State<FootprintHistoryEditPlaceScreen> {
  late NaverMapController _mapController;
  final searchBarController = FloatingSearchBarController();
  final Dio _searchDio = Dio();
  final Dio _reverseGCDio = Dio();
  late PlaceSearchApi _placeSearchApi;
  late ReverseGeoCodingApi _reverseGCApi;
  

  @override
  Widget build(BuildContext context) {
    setHttp();
    return ChangeNotifierProvider(
      create: (context) => FootprintPhotoMapOverlayProvider(widget.mapType),
      child: Consumer<FootprintPhotoMapOverlayProvider>(
          builder: (context, provider, _) {
        return Scaffold(
            backgroundColor: ColorFamily.cream,
            // appBar: const FootprintHistoryEditPlaceTopAppBar(),
            resizeToAvoidBottomInset: false,
            body: Stack(
              children: [
                NaverMap(
                    onMapReady: (NaverMapController controller) {
                      _mapController = controller;
                    },
                    onSymbolTapped: (NSymbolInfo symbolInfo) async {
                      var roadaddr = await reverseGeoCoding(symbolInfo.position);
                      // 검색창 심볼 이름 삽입
                      searchBarController.query = symbolInfo.caption;
                      // 심볼 이름으로 검색
                      await searchPlace(symbolInfo.caption);
                      // 첫 번째 항목으로 selectedPlace 설정
                      widget.provider.setPlace(widget.provider.searchPlaces[0]);

                      // 검색 결과 비우기
                      widget.provider.clearSearchPlace();
                      // 정보 변경
                      widget.provider.changeSelectedPlaceInfo(symbolInfo.caption, roadaddr!);
                      // 마커 찍기
                      var coordinate = await _addMarkerOverlay(provider, symbolInfo.position);
                      // 카메라 이동
                      _mapController.updateCamera(NCameraUpdate.scrollAndZoomTo(
                          target: coordinate,
                          zoom: 16));

                      setState(() {});

                    },
                    options: NaverMapViewOptions(
                        consumeSymbolTapEvents: false,
                        locale: NLocale.fromLocale(const Locale('ko', 'KR')),
                        scaleBarEnable: false,
                        logoClickEnable: false,
                        minZoom: provider.overlayInfo!.zoom,
                        initialCameraPosition: NCameraPosition(
                          target: provider.overlayInfo!.coordinate,
                          zoom: provider.overlayInfo!.zoom,
                        ))),
                FloatingSearchBar(
                  controller: searchBarController,
                  borderRadius: BorderRadius.circular(20),
                  automaticallyImplyBackButton: false,
                  iconColor: ColorFamily.black,
                  hint: "장소 검색",
                  hintStyle: TextStyleFamily.hintTextStyle,
                  queryStyle: TextStyleFamily.normalTextStyle,
                  clearQueryOnClose: false,
                  onSubmitted: (query) async {
                    // 검색
                    await searchPlace(query);
                  },
                  leadingActions: [
                    IconButton(
                      onPressed: () {
                        widget.provider.setPlace(null);
                        Navigator.pop(context);
                      },
                      icon: SvgPicture.asset('lib/assets/icons/arrow_back.svg'),
                    )
                  ],
                  builder: (context, transition) {
                    if (widget.provider.searchPlaces.isNotEmpty) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Material(
                            color: Colors.white,
                            elevation: 4.0,
                            child: SizedBox(
                              height: 300,
                              child: ListView.builder(
                                  itemCount:
                                      widget.provider.searchPlaces.length,
                                  itemBuilder: (context, index) =>
                                      makeSearchResultItem(
                                          context, index, provider)),
                            )),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                // 하단 카드뷰 생성
                widget.provider.selectedPlace != null
                    ? Positioned(
                        bottom: 40,
                        left: 20,
                        right: 20,
                        child: FootprintHistoryEditPlaceInfo(widget.provider))
                    : const SizedBox()
              ],
            ));
      }),
    );
  }

  Future<NLatLng> _addMarkerOverlay(
      FootprintPhotoMapOverlayProvider provider, NLatLng? position) async {
    _mapController.clearOverlays();
    late NLatLng coordinate;
    if(position != null){
      coordinate = position;
    }else{
      // 좌표계 변환
      coordinate = convertCoordinate(widget.provider.selectedPlace!.mapx,
          widget.provider.selectedPlace!.mapy);
    }


    final iconImage = await NOverlayImage.fromWidget(
        widget: SvgPicture.asset('lib/assets/icons/marker_fill.svg'),
        size: const Size(55, 55),
        context: context);

    final marker = NMarker(id: "", position: coordinate, icon: iconImage);

    _mapController.addOverlay(marker);
    return coordinate;
  }

  Future<void> setHttp() async {
    await dotenv.load(fileName: ".env");
    _searchDio.options.headers = {
      'X-Naver-Client-Id': dotenv.env['NAVER_SEARCH_CLIENT_ID'],
      'X-Naver-Client-Secret': dotenv.env['NAVER_SEARCH_CLIENT_SECRET'],
    };
    _placeSearchApi = PlaceSearchApi(_searchDio);
    
    _reverseGCDio.options.headers = {
      'X-NCP-APIGW-API-KEY-ID' : dotenv.env['X-NCP-APIGW-API-KEY-ID'],
      'X-NCP-APIGW-API-KEY': dotenv.env['X-NCP-APIGW-API-KEY'],
    };
    _reverseGCApi = ReverseGeoCodingApi(_reverseGCDio);
  }

  Future<void> searchPlace(String query) async {
    try {
      final response = await _placeSearchApi.search(query, 5);
      widget.provider.clearSearchPlace();
      for (var item in response.items) {
        widget.provider.addSearchPlace(item);
      }
      setState(() {});
    } catch (e) {
      print("");
      print("Error: $e");
      print("");
    }
  }
  
  Future<String?> reverseGeoCoding(NLatLng coords) async {
    try{
      final response = await _reverseGCApi.reverseGeocode("${coords.longitude},${coords.latitude}", "roadaddr", "json");

      var result = response.results.first;
      var region = result.region;

      var roadaddr = result.land!.number2.isEmpty
          ?"${region.area1.name} ${region.area2.name} ${region.area3.name} ${region.area4.name} ${result.land!.number1}"
          :"${region.area1.name} ${region.area2.name} ${region.area3.name} ${region.area4.name} ${result.land!.number1}-${result.land!.number2}";

      return roadaddr;
    } catch (e) {
      print("");
      print("Error: $e");
      print("");
    }
    return null;
  }

  Widget makeSearchResultItem(BuildContext context, int index,
      FootprintPhotoMapOverlayProvider provider) {
    return InkWell(
      onTap: () async {
        widget.provider.setPlace(widget.provider.searchPlaces[index]);
        // 검색 결과 비우기
        widget.provider.clearSearchPlace();
        // 서치바 닫음
        searchBarController.close();
        // 마커 찍기
        var coordinate = await _addMarkerOverlay(provider, null);
        // 카메라 이동
        await _mapController.updateCamera(NCameraUpdate.scrollAndZoomTo(
            target: coordinate, // 서울
            zoom: 16));
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  child: Text(
                    widget.provider.searchPlaces[index].title,
                    style: TextStyleFamily.normalTextStyle,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Flexible(
                  child: Text(
                    widget.provider.searchPlaces[index].category,
                    style: const TextStyle(
                        fontFamily: FontFamily.mapleStoryLight,
                        fontSize: 10,
                        color: ColorFamily.gray),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Flexible(
                    child: Text(
                  widget.provider.searchPlaces[index].roadAddress,
                  style: TextStyleFamily.normalTextStyle,
                )),
              ],
            ),
            const Divider(
              color: ColorFamily.gray,
              thickness: 0.5,
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}

NLatLng convertCoordinate(String x, String y) {
  var double_x = double.tryParse(x) ?? 0.0;
  var double_y = double.tryParse(y) ?? 0.0;

  var converted = NLatLng(
    (double_y / pow(10.0, y.length - 2)),
    (double_x / pow(10.0, x.length - 3)),
  );
  return converted;
}
