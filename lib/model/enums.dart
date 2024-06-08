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

enum DiaryWeather{
  SUNNY(0, 'lib/assets/images/sunny.png'),
  CLOUDY(1, 'lib/assets/images/cloudy.png'),
  RAINY(2, 'lib/assets/images/rainy.png'),
  SNOWY(3, 'lib/assets/images/snowy.png');

  final int type; // 날씨 타입
  final String image; // 날씨 이미지
  const DiaryWeather(this.type, this.image);

  static DiaryWeather? fromType(int type){
    for (var value in DiaryWeather.values) {
      if (value.type == type) {
        return value;
      }
    }
    return null; // 해당 type 값이 없을 경우 null 반환
  }
}

enum DiaryState{
  STATE_NORMAL(0),
  STATE_DELETE(1);

  final int state; // 상태
  const DiaryState(this.state);
}

enum DiaryEditorState{
  EDITOR_ALL(0, "전체"),
  EDITOR_USER(1, "나"),
  EDITOR_LOVER(2, "상대방");

  final int type;
  final String detail;
  const DiaryEditorState(this.type, this.detail);

  static DiaryEditorState? fromType(int type){
    for (var value in DiaryEditorState.values) {
      if (value.type == type) {
        return value;
      }
    }
    return null; // 해당 type 값이 없을 경우 null 반환
  }

  static List<String> getDetails(){
    List<String> result = [];
    for(var value in DiaryEditorState.values){
      result.add(value.detail);
    }
    return result;
  }
}

enum DiarySortState{
  SORT_DESC(0, "최신순"),
  SORT_ASC(1, "오래된순");

  final int type;
  final String detail;
  const DiarySortState(this.type, this.detail);

  static DiarySortState? fromType(int type){
    for (var value in DiarySortState.values) {
      if (value.type == type) {
        return value;
      }
    }
    return null; // 해당 type 값이 없을 경우 null 반환
  }

  static List<String> getDetails(){
    List<String> result = [];
    for(var value in DiarySortState.values){
      result.add(value.detail);
    }
    return result;
  }
}
