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

// 가계부 타입
enum LedgerType {
  EXPENDITURE(0, '지출'),
  INCOME(1, '수입');

  final int type;
  final String name;

  const LedgerType(this.type, this.name);
}

// 가계부 상태
enum LedgerState{
  STATE_NORMAL(0, '정상'),
  STATE_DELETE(1, '삭제');

  final int state;
  final String name;

  const LedgerState(this.state, this.name);
}

// 가계부 카테고리
enum LedgerCategory{
  FOOD_EXPENSES(0, '식비'), CAFFE(1, '카페'), PUBLIC_TRANSPORT(2, '교통'), SHOPPING(3, '쇼핑'),
  CULTURE(4, '문화'), HOBBY(5, '취미'), DATE_WITH(6, '데이트'), GAME(7, '오락'),
  TRAVEL(8, '여행'), DWELLING(9, '주거'), LIFE(10, '생활'), ETC(11, '기타'),
  DEPOSIT(12, '입금'), INCOME_ADD(13, '부수입'), INCOME_BONUS(14, '보너스'), INCOME_ETC(15, '기타');

  final int number;
  final String name;

  const LedgerCategory(this.number, this.name);

  // 열거형을 정수형으로 변환
  int get intValue => number;

  // 문자열을 열거형으로 변환하는 static 메서드
  static LedgerCategory fromString(int int) {
    return LedgerCategory.values.firstWhere((e) => e.number == int);
  }
}