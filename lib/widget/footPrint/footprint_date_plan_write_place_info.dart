import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:woo_yeon_hi/screen/footPrint/footprint_history_edit_place_screen.dart';

import '../../dialogs.dart';
import '../../provider/footprint_provider.dart';
import '../../style/color.dart';
import '../../style/font.dart';
import '../../style/text_style.dart';

class FootprintDatePlanWritePlaceInfo extends StatefulWidget {
  FootprintDatePlanWritePlaceInfo(this.provider, this.mapController, {super.key});
  FootPrintDatePlanSlidableProvider provider;
  NaverMapController mapController;

  @override
  State<FootprintDatePlanWritePlaceInfo> createState() => _FootprintDatePlanWritePlaceInfoState();
}

class _FootprintDatePlanWritePlaceInfoState extends State<FootprintDatePlanWritePlaceInfo> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        decoration: BoxDecoration(
          color: ColorFamily.white,
          borderRadius: BorderRadius.circular(15), // 모서리를 둥글게 설정
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7 - 40,
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7 - 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(child: Text(widget.provider.selectedPlace!.title, style: TextStyleFamily.normalTextStyle,)),
                              const SizedBox(width: 5,),
                              Flexible(
                                child: Text(widget.provider.selectedPlace!.category, style: const TextStyle(
                                    fontFamily: FontFamily.mapleStoryLight,
                                    fontSize: 10,
                                    color: ColorFamily.gray
                                ),),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 10,),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7 - 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(child: Text(widget.provider.selectedPlace!.roadAddress, style: TextStyleFamily.normalTextStyle,)),
                              ],
                            ))
                      ],
                    ),
                  ),
                  InkWell(
                    splashColor: ColorFamily.gray,
                    onTap: () async {
                      var coord = convertCoordinate(widget.provider.selectedPlace!.mapx, widget.provider.selectedPlace!.mapy);
                      var point = GeoPoint(coord.latitude, coord.longitude);
                      Map<String, dynamic> plan = {
                        "planed_place_name" : widget.provider.selectedPlace!.title,
                        "planed_place_position" : point,
                        "planed_place_memo" : widget.provider.memoController.text
                      };
                      widget.provider.addPlan(plan);
                      var coordinate = await _addMarkerOverlay(widget.provider, NLatLng(point.latitude, point.longitude));
                      await widget.mapController.updateCamera(NCameraUpdate.scrollAndZoomTo(
                        target: coordinate,
                        zoom: 16
                      ));
                      widget.provider.setPlace(null);
                    },
                    child: SvgPicture.asset('lib/assets/icons/add.svg'),
                  )
                ],
              ),
              // 메모
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: TextField(
                  controller: widget.provider.memoController,
                  maxLines: 5,
                  cursorColor: ColorFamily.black,
                  onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                  decoration: InputDecoration(
                    hintText: '메모',
                    hintStyle: TextStyleFamily.hintTextStyle,
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: ColorFamily.gray,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    // 사용자가 입력하지 않을 때의 테두리
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: ColorFamily.gray,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: ColorFamily.gray,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  style: TextStyleFamily.normalTextStyle,
                ),
              )
            ],
          ),
        ),

      ),
    );
  }

  Future<NLatLng> _addMarkerOverlay(
      FootPrintDatePlanSlidableProvider provider, NLatLng? position) async {
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

    widget.mapController.addOverlay(marker);
    return coordinate;
  }
}
