class Diary {
  int diaryIdx; // 교환일기 번호
  int diaryUserIdx; // 쓴 사람
  String diaryDate; // 쓴 날짜
  int diaryWeather; // 날씨 유형
  String diaryImage; // 교환일기 썸네일 이미지
  String diaryTitle; // 교환일기 제목
  String diaryContent; // 교환일기 내용
  bool diaryLoverCheck; // 연인이 확인 했는지 구분
  int diaryState; // 교환일기 상태

  Diary(
      {required this.diaryIdx,
      required this.diaryUserIdx,
      required this.diaryDate,
      required this.diaryWeather,
      required this.diaryImage,
      required this.diaryTitle,
      required this.diaryContent,
      required this.diaryLoverCheck,
      required this.diaryState});

  factory Diary.fromData(Map<String, dynamic> data){
    return Diary(
        diaryIdx: data['diary_idx'],
        diaryUserIdx: data['diary_user_idx'],
        diaryDate: data['diary_date'],
        diaryWeather: data['diary_weather'],
        diaryImage: data['diary_image'],
        diaryTitle: data['diary_title'],
        diaryContent: data['diary_content'],
        diaryLoverCheck: data['diary_lover_check'],
        diaryState: data['diary_state']);
  }
}
