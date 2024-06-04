import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geojson/geojson.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/widget/footPrint/footprint_history_edit_place_top_app_bar.dart';

import '../../model/enums.dart';
import '../../model/place_info.dart';
import '../../provider/footprint_provider.dart';
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

  @override
  void initState() {
    widget.provider.setPlace(null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


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
                        ))),
                FloatingSearchBar(
                  controller: searchBarController,
                  borderRadius: BorderRadius.circular(20),
                  automaticallyImplyBackButton: false,
                  iconColor: ColorFamily.black,
                  hint: "장소 검색",
                  hintStyle: TextStyleFamily.hintTextStyle,
                  queryStyle: TextStyleFamily.normalTextStyle,
                  backdropColor: Colors.transparent,
                  onQueryChanged: (query) {},
                  onSubmitted: (query) {
                    searchBarController.close();
                    _addMarkerOverlay(provider);
                    _mapController.updateCamera(NCameraUpdate.scrollAndZoomTo(
                        target: const NLatLng(37.5665, 126.9780), // 서울
                        zoom: 16));
                    setState(() {
                      widget.provider.setPlace("서울");
                    });
                  },
                  leadingActions: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: SvgPicture.asset('lib/assets/icons/arrow_back.svg'),
                    )
                  ],
                  builder: (context, transition) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Material(
                          color: Colors.white,
                          elevation: 4.0,
                          child:
                              Container(height: 300, color: ColorFamily.white)),
                    );
                  },
                ),
                widget.provider.selectedPlace != null
                    ? Positioned(
                        bottom: 40,
                        left: 20,
                        right: 20,
                        child: FootprintHistoryEditPlaceInfo(
                            "서울특별시청",
                            "특별,광역시청",
                            "서울 중구 세종대로 110 서울특별시청",
                            widget.provider))
                    : const SizedBox()
              ],
            ));
      }),
    );
  }

  Future<void> _addMarkerOverlay(
      FootprintPhotoMapOverlayProvider provider) async {
    _mapController.clearOverlays();
    final coordinate = const NLatLng(37.5665, 126.9780); // 서울

    final iconImage = await NOverlayImage.fromWidget(
        widget: SvgPicture.asset('lib/assets/icons/marker_fill.svg'),
        size: const Size(55, 55),
        context: context);

    final marker = NMarker(id: "", position: coordinate, icon: iconImage);

    _mapController.addOverlay(marker);
  }
}
