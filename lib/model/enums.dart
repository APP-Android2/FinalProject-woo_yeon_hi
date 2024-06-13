import 'package:flutter_naver_map/flutter_naver_map.dart';

enum MapType {
  KOREA_SEOUL(0, "서울", 'lib/assets/images/korea_seoul.png',),
  KOREA_FULL(1, "대한민국", 'lib/assets/images/korea_full.png');

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

enum PhotoMapState{
  STATE_NORMAL(0),
  STATE_DELETE(1);

  final int state; // 상태
  const PhotoMapState(this.state);
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

enum LoginType {
  none(0),
  google(1),
  kakao(2); // logout

  const LoginType(this.value);
  final int value;
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

// 가계부 타입
enum LedgerType {
  EXPENDITURE(0, '지출'),
  INCOME(1, '수입');

  final int type;
  final String name;

  const LedgerType(this.type, this.name);

  int get value => type;

  static LedgerType fromValue(int value) {
    return LedgerType.values.firstWhere((e) => e.type == value);
  }
}

// 가계부 상태
enum LedgerState{
  STATE_NORMAL(0, '정상'),
  STATE_DELETE(1, '삭제');

  final int state;
  final String name;

  const LedgerState(this.state, this.name);

  int get value => state;

  static LedgerState fromValue(int value) {
    return LedgerState.values.firstWhere((e) => e.state == value);
  }
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
  int get value => number;

  // 문자열을 열거형으로 변환하는 static 메서드
  static LedgerCategory fromValue(int value) {
    return LedgerCategory.values.firstWhere((e) => e.number == value);
  }
}

enum HistoryState{
  STATE_NORMAL(0),
  STATE_DELETE(1);

  final int state; // 상태
  const HistoryState(this.state);
}

enum PlanState{
  STATE_NORMAL(0),
  STATE_SUCCESS(1),
  STATE_DELETE(2);

  final int state; // 상태
  const PlanState(this.state);
}