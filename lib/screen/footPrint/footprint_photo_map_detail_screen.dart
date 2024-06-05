import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
            child: SvgPicture.asset('lib/assets/icons/edit.svg', colorFilter: ColorFilter.mode(ColorFamily.black, BlendMode.srcIn),),
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
              _preloadImages(context).then((_) {
                _addMarkerOverlay(provider); // 마커 오버레이
              });
            },
            onMapTapped: (NPoint point, NLatLng latLng) {
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

    List<String> imagePaths = [
      'lib/assets/images/puppy1.jpg',
      'lib/assets/images/puppy2.jpg',
      'lib/assets/images/puppy3.jpg',
      'lib/assets/images/puppy4.jpg',
      'lib/assets/images/puppy5.jpg',
    ];

    for (var i = 0 ; i< majorCities.length ; i++) {
      final markerWidget = PhotoMapMarker(imagePaths[i]);

      final iconImage = await NOverlayImage.fromWidget(
          widget: markerWidget,
          size: const Size(70, 80),
          context: context);

      final marker = NMarker(
        id: "marker_$i",
        position: majorCities[i],
        icon: iconImage,
      );

      provider.addMarker(marker);
    }
  }
}

Future<void> _preloadImages(BuildContext context) async {
  List<String> imagePaths = [
    'lib/assets/images/puppy1.jpg',
    'lib/assets/images/puppy2.jpg',
    'lib/assets/images/puppy3.jpg',
    'lib/assets/images/puppy4.jpg',
    'lib/assets/images/puppy5.jpg',
  ];

  for (String path in imagePaths) {
    final imageProvider = AssetImage(path);
    await precacheImage(imageProvider, context);
  }
}