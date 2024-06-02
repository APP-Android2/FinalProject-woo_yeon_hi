import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:woo_yeon_hi/widget/footPrint/footprint_photo_map_detail_top_app_bar.dart';

import '../../style/color.dart';
import 'footprint_history_edit_screen.dart';

class FootprintPhotoMapDetailScreen extends StatefulWidget {
  const FootprintPhotoMapDetailScreen({super.key});

  @override
  State<FootprintPhotoMapDetailScreen> createState() => _FootprintPhotoMapDetailScreenState();
}

class _FootprintPhotoMapDetailScreenState extends State<FootprintPhotoMapDetailScreen> {
  // NaverMapController 객체의 비동기 작업 완료를 나타내는 Completer 생성
  final Completer<NaverMapController> mapControllerCompleter = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorFamily.cream,
      appBar: const FootprintPhotoMapDetailTopappBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorFamily.beige,
        shape: const CircleBorder(),
        child: SvgPicture.asset('lib/assets/icons/edit.svg'),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const FootprintHistoryEditScreen()));
        },
      ),
      body:NaverMap(
        options: const NaverMapViewOptions(),
        onMapReady: (controller) {
        },
      ),

    );
  }
}
