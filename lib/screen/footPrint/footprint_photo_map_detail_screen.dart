import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geojson/geojson.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/model/place_info.dart';
import 'package:woo_yeon_hi/widget/footPrint/footprint_photo_map_detail_top_app_bar.dart';

import '../../model/enums.dart';
import '../../provider/footprint_provider.dart';
import '../../style/color.dart';
import '../../widget/footPrint/footprint_photo_map_marker.dart';
import 'footprint_history_edit_screen.dart';

class FootprintPhotoMapDetailScreen extends StatefulWidget {
  const FootprintPhotoMapDetailScreen({super.key});

  @override
  State<FootprintPhotoMapDetailScreen> createState() =>
      _FootprintPhotoMapDetailScreenState();
}

class _FootprintPhotoMapDetailScreenState
    extends State<FootprintPhotoMapDetailScreen> {
  late NaverMapController _mapController;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          FootprintPhotoMapOverlayProvider(MapType.KOREA_FULL.type),
      child: Consumer<FootprintPhotoMapOverlayProvider>(
          builder: (context, provider, _) {
        return Scaffold(
          backgroundColor: ColorFamily.cream,
          appBar: const FootprintPhotoMapDetailTopappBar(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: ColorFamily.beige,
            shape: const CircleBorder(),
            child: SvgPicture.asset('lib/assets/icons/edit.svg'),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const FootprintHistoryEditScreen()));
            },
          ),
          body: NaverMap(
            onMapReady: (NaverMapController controller) {
              _mapController = controller;
              _addPlaceOverlay(provider);
              _addMarkerOverlay(provider);
            },
            onMapTapped: (NPoint point, NLatLng latLng) {
              // 화면상의 좌표 (x, y)
              //print("enung NPoint : $point");

              // 실제 장소의 위도, 경도 (latitude, longitude)
              print("enung NLatLng : $latLng");
            },
            options: NaverMapViewOptions(
                scaleBarEnable: false,
                logoClickEnable: false,
                minZoom: provider.overlayInfo!.zoom,
                initialCameraPosition: NCameraPosition(
                  target: provider.overlayInfo!.coordinate,
                  zoom: provider.overlayInfo!.zoom,
                )),
          ),
        );
      }),
    );
  }

  Future<void> _addPlaceOverlay(FootprintPhotoMapOverlayProvider provider) async {
    await _loadmapdata(provider);
    _mapController.addOverlayAll(provider.polygonOverlays.toSet());
  }

  Future<void> _addMarkerOverlay(FootprintPhotoMapOverlayProvider provider) async {
    await _addMarker(provider);
    _mapController.addOverlayAll(provider.markers.toSet());
  }


  Future<void> _addMarker(FootprintPhotoMapOverlayProvider provider) async {
    List<NLatLng> majorCities = [
      const NLatLng(37.5665, 126.9780), // 서울
      const NLatLng(35.1796, 129.0756), // 부산
      const NLatLng(35.8714, 128.6014), // 대구
      const NLatLng(37.4563, 126.7052), // 인천
      const NLatLng(35.1595, 126.8526) // 광주
    ];

    List<String> images = [
      'lib/assets/images/puppy1.jpg',
      'lib/assets/images/puppy2.jpg',
      'lib/assets/images/puppy3.jpg',
      'lib/assets/images/puppy4.jpg',
      'lib/assets/images/puppy5.jpg',
    ];


    for (var i = 0 ; i< majorCities.length ; i++) {
      final iconImage = await NOverlayImage.fromWidget(
          widget: PhotoMapMarker(images[i]),
          size: const Size(70, 80),
          context: context);


      final marker = NMarker(
          id: "${provider.markers.length}",
          position: majorCities[i],
          icon: iconImage);

      provider.addMarker(marker);
    }
  }

  Future<void> _loadmapdata(FootprintPhotoMapOverlayProvider provider) async {
    final geojson = GeoJson();
    // GeoJson에서 데이터를 추출 하는 중이라 데이터 호출
    final data = await rootBundle.loadString(provider.mapType!.path);

    // data를 geojson으로 가공
    await geojson.parse(data);

    // 현재 데이터의 위도,경도에 맞춰서 _polygon에 넣는다.
    // polygon 값들이 여러개 일 경우에 맞춰 for문 적용
    for (final feature in geojson.features) {
      final geoJsonMultiPolygon = feature.geometry as GeoJsonMultiPolygon;
      final properties =
          feature.properties; // AREA_CD, AREA_ENG_NM, AREA_KOR_NM
      final _CD = properties?['AREA_CD'];
      final _ENG_NM = properties?['AREA_ENG_NM'];
      final _KOR_NM = properties?['AREA_KOR_NM'];
      for (final polygon in geoJsonMultiPolygon.polygons) {
        final geoseries = polygon.geoSeries; // 한 구역안의 존재하는 polygon들
        List<NLatLng> _polygonPoints = []; // polygon 좌표들
        for (final geoserie in geoseries) {
          for (final geopoint in geoserie.geoPoints) {
            _polygonPoints.add(NLatLng(geopoint.latitude, geopoint.longitude));
          }
        }
        // 오버레이 좌표 리스트의 처음과 끝은 같아야한다.
        _polygonPoints.add(_polygonPoints.first);

        // polygon 좌표로 NPolygonOverlay를 만든다.
        var overlay = NPolygonOverlay(
            id: "${provider.polygonOverlays.length}",
            coords: _polygonPoints,
            color: Colors.transparent,
            outlineColor: Colors.transparent,
            outlineWidth: 1);
        // 해당 구역을 클릭 했을 때 리스너
        overlay.setOnTapListener((overlay) {
          final id  = int.parse(overlay.info.id);
          final infos = provider.polygonInfos;
          print("enung ${id}");
          print(
              "enung ${infos[id]!.korNm}");
        });
        provider.addInfo(provider.polygonOverlays.length,
            PlaceInfo(cd: _CD, engNm: _ENG_NM, korNm: _KOR_NM));
        provider.addOverlay(overlay);
      }
    }
  }
}
