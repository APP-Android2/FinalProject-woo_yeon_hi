import 'package:flutter_naver_map/flutter_naver_map.dart';

enum MapType {
  KOREA_SEOUL(0, "서울", 'lib/assets/geojsons/korea_seoul.geojson'),
  KOREA_FULL(1, "대한민국", 'lib/assets/geojsons/korea_full.geojson');

  final int type;
  final String name;
  final String path;
  const MapType(this.type, this.name, this.path);

  static MapType? fromType(int type) {
    for (var value in MapType.values) {
      if (value.type == type) {
        return value;
      }
    }
    return null; // 해당 type 값이 없을 경우 null 반환
  }
}

enum OverlayInfo {
  /// 서울 지도
  KOREA_SEOUL(0, 37.5665, 126.9780, 9),
  /// 한국 전체 지도
  KOREA_FULL(1, 36.5551, 127.7818, 5.8);

  final int type;
  final double latitude;
  final double longitude;
  final double zoom;
  const OverlayInfo(this.type, this.latitude, this.longitude, this.zoom);

  NLatLng get coordinate => NLatLng(latitude, longitude);

  static OverlayInfo? fromType(int type) {
    for (var value in OverlayInfo.values) {
      if (value.type == type) {
        return value;
      }
    }
    return null; // 해당 type 값이 없을 경우 null 반환
  }

}

enum ScheduleState {
  STATE_NORMAL(0),
  STATE_DELETE(1);

  final int state;  // 상태
  const ScheduleState(this.state);
}

enum ScheduleColorType {
  FIRST_COLOR(0),
  SECOND_COLOR(1),
  THIRD_COLOR(2),
  FOURTH_COLOR(3),
  FIFTH_COLOR(4),
  SIXTH_COLOR(5),
  SEVENTH_COLOR(6),
  EIGHTH_COLOR(7);

  final int state;
  const ScheduleColorType(this.state);
}