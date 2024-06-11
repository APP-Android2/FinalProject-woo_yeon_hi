import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/dao/history_dao.dart';
import 'package:woo_yeon_hi/dao/photo_map_dao.dart';
import 'package:woo_yeon_hi/model/history_model.dart';
import 'package:woo_yeon_hi/screen/footPrint/footprint_history_detail_screen.dart';
import 'package:woo_yeon_hi/style/text_style.dart';
import 'package:woo_yeon_hi/widget/footPrint/footprint_photo_map_detail_top_app_bar.dart';

import '../../model/enums.dart';
import '../../provider/footprint_provider.dart';
import '../../style/color.dart';
import '../../widget/footPrint/footprint_photo_map_marker.dart';
import 'footprint_history_edit_screen.dart';

class FootprintPhotoMapDetailScreen extends StatefulWidget {
  FootprintPhotoMapDetailScreen(this.mapIdx, this.mapName, {super.key});
  int mapIdx;
  String mapName;
  int user_idx = 0;

  @override
  State<FootprintPhotoMapDetailScreen> createState() =>
      _FootprintPhotoMapDetailScreenState();

  // 뒤로가기, 히스토리 이동, 히스토리 작성 시 스냅 샷 저장
  static Future<void> capture(GlobalKey globalKey, int userIdx, int mapIdx) async {
    var renderObject = globalKey.currentContext!.findRenderObject();
    if (renderObject is RenderRepaintBoundary) {
      var boundary = renderObject;
      ui.Image image = await boundary.toImage();
      ByteData? byteData =
      await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List? pngBytes = byteData!.buffer.asUint8List();
      uploadPhotoMapImage(pngBytes, "snapshot_${userIdx}_$mapIdx");
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
      appBar: FootprintPhotoMapDetailTopappBar(globalkey, widget.mapIdx, widget.mapName),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorFamily.beige,
        shape: const CircleBorder(),
        child: SvgPicture.asset('lib/assets/icons/edit.svg', colorFilter: const ColorFilter.mode(ColorFamily.black, BlendMode.srcIn),),
        onPressed: () {
          // 스냅샷 저장
          FootprintPhotoMapDetailScreen.capture(globalkey, widget.user_idx, widget.mapIdx);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                  FootprintHistoryEditScreen(widget.mapIdx))).then((value) => setState(() {
                    // 지도 새로고침
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FootprintPhotoMapDetailScreen(widget.mapIdx, widget.mapName)));
          }));
        },
      ),
      body: ChangeNotifierProvider(
        create: (context) =>
            FootprintPhotoMapOverlayProvider(MapType.KOREA_SEOUL.type),
        child: Consumer<FootprintPhotoMapOverlayProvider>(
          builder: (context, provider, _) {
            return FutureBuilder(
              future: getHistory(widget.user_idx, widget.mapIdx),
              builder: (context, snapshot){
                if(snapshot.hasData == false){
                  return const SizedBox();
                }else if (snapshot.hasError){
                  return const Center(child: Text("network error", style: TextStyleFamily.normalTextStyle,),);
                }else{
                  return RepaintBoundary(
                      key: globalkey,
                      child: NaverMap(
                        onMapReady: (NaverMapController controller) {
                          _mapController = controller;
                          _preloadImages(snapshot.data!).then((_) {
                            // 마커 오버레이
                            _addMarkerOverlay(provider, snapshot.data!);
                          });
                        },
                        options: NaverMapViewOptions(
                            scaleBarEnable: false,
                            logoClickEnable: false,
                            minZoom: provider.overlayInfo!.zoom,
                            locale: NLocale.fromLocale(const Locale('ko', 'KR')),  // 지도 언어 한국어
                            initialCameraPosition: NCameraPosition(
                              target: provider.overlayInfo!.coordinate,
                              zoom: provider.overlayInfo!.zoom,
                            )),
                      )
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
  Future<void> _addMarkerOverlay(
      FootprintPhotoMapOverlayProvider provider, List<History> historyList) async {
    await _addMarker(provider, historyList);
    _mapController.addOverlayAll(provider.markers.toSet());
  }

  Future<void> _addMarker(FootprintPhotoMapOverlayProvider provider, List<History> historyList) async {
    for (var i = 0; i < historyList.length; i++) {
      var image = await getHistoryImage(historyList[i].historyImage[0]);
      final markerWidget = PhotoMapMarker(image);

      final iconImage = await NOverlayImage.fromWidget(
          widget: markerWidget, size: const Size(70, 80), context: context);

      final marker = NMarker(
        id: "${historyList[i].historyIdx}",
        position: NLatLng(historyList[i].historyLocation.latitude, historyList[i].historyLocation.longitude),
        icon: iconImage,
      );
      marker.setOnTapListener((overlay){
        Navigator.push(context, MaterialPageRoute(builder: (context) => FootprintHistoryDetailScreen(widget.mapIdx, overlay.info.id, i)));
      });

      provider.addMarker(marker);
    }
  }

  Future<void> _preloadImages(List<History> historyList) async {
    for(var history in historyList){
      final imageURL = await FirebaseStorage.instance.ref('image/history/${history.historyImage[0]}').getDownloadURL();
      final imageProvider = NetworkImage(imageURL);
      await precacheImage(imageProvider, context);
    }
  }
}

