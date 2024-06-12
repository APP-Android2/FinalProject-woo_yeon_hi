import 'package:cloud_firestore/cloud_firestore.dart';

class History {
  int historyIdx; // 히스토리 번호
  int historyMapIdx; // 포토맵 지도 번호
  String historyPlaceName; // 히스토리 지명
  GeoPoint historyLocation; // 히스토리 좌표
  int historyUserIdx; // 히스토리 작성자 번호
  String historyTitle; // 히스토리 제목
  String historyDate; // 히스토리 작성일
  String historyContent; // 히스토리 내용
  List<dynamic> historyImage; // 히스토리 이미지 경로 배열
  int historyState; // 히스토리 상태

  History(
      {required this.historyIdx,
      required this.historyMapIdx,
      required this.historyPlaceName,
      required this.historyLocation,
      required this.historyUserIdx,
      required this.historyTitle,
      required this.historyDate,
      required this.historyContent,
      required this.historyImage,
      required this.historyState});

  factory History.fromData(Map<String, dynamic> data) {
    return History(
      historyIdx: data['history_idx'],
      historyMapIdx: data['history_map_idx'],
      historyPlaceName: data['history_place_name'],
      historyLocation: data['history_location'],
      historyUserIdx: data['history_user_idx'],
      historyTitle: data['history_title'],
      historyDate: data['history_date'],
      historyContent: data['history_content'],
      historyImage: data['history_image'],
      historyState: data['history_state']);
  }
}
