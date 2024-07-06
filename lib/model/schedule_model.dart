class Schedule {
  int scheduleIdx;
  int scheduleUserIdx;
  String scheduleStartDate;
  String scheduleFinishDate;
  String scheduleStartTime;
  String scheduleFinishTime;
  String scheduleTitle;
  int scheduleColor;
  String scheduleMemo;
  int scheduleState;


  Schedule({
    required this.scheduleIdx,
    required this.scheduleUserIdx,
    required this.scheduleStartDate,
    required this.scheduleFinishDate,
    required this.scheduleStartTime,
    required this.scheduleFinishTime,
    required this.scheduleTitle,
    required this.scheduleColor,
    required this.scheduleMemo,
    required this.scheduleState,
  });
}