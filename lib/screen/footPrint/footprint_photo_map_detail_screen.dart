import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/screen/footPrint/footprint_history_detail_screen.dart';
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

  // 뒤로가기, 히스토리 이동, 히스토리 작성 시 스냅 샷 저장
  static Future<void> capture(GlobalKey globalKey) async {
    var renderObject = globalKey.currentContext!.findRenderObject();
    if (renderObject is RenderRepaintBoundary) {
      var boundary = renderObject;
      final directory = (await getApplicationDocumentsDirectory()).path;

      ui.Image image = await boundary.toImage();
      ByteData? byteData =
      await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List? pngBytes = byteData!.buffer.asUint8List();
      File imgFile = File('$directory/screenshot.png');
      imgFile.writeAsBytes(pngBytes);
      print("FINISH CAPTURE ${imgFile.path}");
    }
  }
}

class _FootprintPhotoMapDetailScreenState
    extends State<FootprintPhotoMapDetailScreen> {
  late NaverMapController _mapController;
  var globalkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorFamily.cream,
      appBar: FootprintPhotoMapDetailTopappBar(globalkey),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorFamily.beige,
        shape: const CircleBorder(),
        child: SvgPicture.asset('lib/assets/icons/edit.svg', colorFilter: ColorFilter.mode(ColorFamily.black, BlendMode.srcIn),),
        onPressed: () {
          // 스냅샷 저장
          FootprintPhotoMapDetailScreen.capture(globalkey);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                  const FootprintHistoryEditScreen()));
        },
      ),
      body: ChangeNotifierProvider(
        create: (context) =>
            FootprintPhotoMapOverlayProvider(MapType.KOREA_SEOUL.type),
        child: Consumer<FootprintPhotoMapOverlayProvider>(
          builder: (context, provider, _) {
            return RepaintBoundary(
                key: globalkey,
                child: NaverMap(
                  onMapReady: (NaverMapController controller) {
                    _mapController = controller;
                    _preloadImages().then((_) {
                      // 마커 오버레이
                      _addMarkerOverlay(provider);
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
                )
            );
          },
        ),
      ),
    );
  }
  Future<void> _addMarkerOverlay(
      FootprintPhotoMapOverlayProvider provider) async {
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

    List<String> names = [
      "서교동",
      "역삼동",
      "이태원동",
      "명동",
      "한남동"
    ];

    for (var i = 0; i < majorCities.length; i++) {
      final markerWidget = PhotoMapMarker(imagePaths[i]);

      final iconImage = await NOverlayImage.fromWidget(
          widget: markerWidget, size: const Size(70, 80), context: context);

      final marker = NMarker(
        id: names[i],
        position: majorCities[i],
        icon: iconImage,
      );
      marker.setOnTapListener((overlay){
        Navigator.push(context, MaterialPageRoute(builder: (context) => FootprintHistoryDetailScreen(overlay.info.id, i)));
      });

      provider.addMarker(marker);
    }
  }

  Future<void> _preloadImages() async {
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
}

