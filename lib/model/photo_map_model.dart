class PhotoMap{
  int mapIdx; // 지도 번호
  int mapUserIdx; // 지도 생성 유저 번호
  int mapType; // 지도 유형
  String mapName; // 지도 이름
  String mapSnapshot; // 지도 사진 경로
  int mapState; // 지도 상태

  PhotoMap(
      {required this.mapIdx,
        required this.mapUserIdx,
        required this.mapType,
        required this.mapName,
        required this.mapSnapshot,
        required this.mapState});

  factory PhotoMap.fromData(Map<String, dynamic> data){
    return PhotoMap(
        mapIdx: data['map_idx'],
        mapUserIdx: data['map_user_idx'],
        mapType: data['map_type'],
        mapName: data['map_name'],
        mapSnapshot: data['map_snapshot'],
        mapState: data['map_state']);
  }
}