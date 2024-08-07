import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:woo_yeon_hi/screen/ledger/ledger_detail_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';

class LedgerTableCalendar extends StatefulWidget {
  const LedgerTableCalendar({super.key});

  @override
  State<LedgerTableCalendar> createState() => _LedgerTableCalendarState();
}

class _LedgerTableCalendarState extends State<LedgerTableCalendar> {

  // 선택된 날짜의 이벤트를 감시하는 값
  late final ValueNotifier<List<Event>> _selectedEvents;
  late final ValueNotifier<List<Event>> _selectedShowEvents;

  // format 상태 저장할 변수
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // 캘린더에 보여주는 지출, 수입 총액
  Map<DateTime, dynamic> _events = {
    DateTime.utc(2024, 4, 30): [Event('-120,000', '+20,000')],
    DateTime.utc(2024, 5, 30): [Event('-140,200', '+20,000')],
    DateTime.utc(2024, 5, 31): [Event('-160,200', '+20,000')],
    DateTime.utc(2024, 6, 1): [Event('-90,200', '+50,000')],
    DateTime.utc(2024, 6, 5): [Event('-100,200', '+20,000')],
  };

  // 지출, 수입에 대한 상세 데이터
  Map<DateTime, dynamic> _eventsShow = {
    DateTime.utc(2024, 4, 30): [Event('식비', '10,000'), Event('쇼핑', '110,000')],
    DateTime.utc(2024, 5, 30): [Event('식비', '20,000'), Event('운동', '120,000')],
    DateTime.utc(2024, 5, 31): [Event('택시', '30,000'), Event('운동', '130,000')],
    DateTime.utc(2024, 6, 1): [Event('택시', '10,000'), Event('운동', '70,000')],
    DateTime.utc(2024, 6, 5): [Event('식비', '20,000'), Event('쇼핑', '80,000')],
  };

  // DatePicker 기능
  void _showDateTimePicker() {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(2020, 1, 1),
      maxTime: DateTime(2030, 12, 31),
      onChanged: (date) {
        print('change $date');
      },
      onConfirm: (date) {
        setState(() {
          // 선택된 날짜 업데이트
          _selectedDay = date;

          // 포커스된 날짜 업데이트
          _focusedDay = date;

          // 선택된 날짜의 이벤트 조회
          _selectedShowEvents.value = _getEventsShowForDay(_selectedDay!);
        });
      },
      currentTime: _selectedDay,
      locale: LocaleType.ko,
    );
  }

  @override
  void initState() {
    super.initState();
    // 초기 선택된 날짜를 현재 포커스된 날짜로 설정
    _selectedDay = _focusedDay;
    // 초기 선택된 날짜의 이벤트 설정
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    _selectedShowEvents = ValueNotifier(_getEventsShowForDay(_selectedDay!));
  }

  @override
  void dispose() {
    // ValueNotifier의 리소스 해제
    _selectedEvents.dispose();
    _selectedShowEvents.dispose();
    super.dispose();
  }

  // 특정 날짜의 이벤트 목록을 반환하는 함수
  List<Event> _getEventsForDay(DateTime day) {
    // 해당 날짜에 이벤트가 없으면 빈 리스트 반환
    return _events[day] ?? [];
  }

  List<Event> _getEventsShowForDay(DateTime day) {
    // 해당 날짜에 이벤트가 없으면 빈 리스트 반환
    return _eventsShow[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    // 스크롤 가능한 단일 자식 위젯을 사용하여 전체 내용을 스크롤할 수 있게 한다.
    return Column(
      children: [
        calendarCustomHeader(),
        Container(
          child: TableCalendar<Event>(
            // 달력의 시작 날짜
            firstDay: DateTime.utc(2024, 04, 20),
            // 달력의 마지막 날짜
            lastDay: DateTime.utc(2024, 07, 20),
            // 현재 포커스된 날짜
            focusedDay: _focusedDay,
            // 특정 날짜의 이벤트를 로드
            eventLoader: _getEventsForDay,
            // 언어 설정
            locale: 'ko_KR',
            // 요일 부분의 높이 조절
            daysOfWeekHeight: 30,
            // 날짜 부분의 셀의 높이
            rowHeight: 80,
            // 헤더 지우기
            headerVisible: false,

            // 선택된 날짜 확인 (selectedBuilder)
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),

            // 날짜 선택 시 호출되는 함수
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                // 선택된 날짜 업데이트
                _selectedDay = selectedDay;
                // 포커스된 날짜 업데이트
                _focusedDay = focusedDay;
                // 선택된 날짜의 이벤트 업데이트
                _selectedEvents.value = _getEventsForDay(selectedDay);
                _selectedShowEvents.value = _getEventsShowForDay(selectedDay);
              });
            },

            // 페이지(월 이동) 스크롤 시 호출되는 함수
            onPageChanged: (focusedDay) {
              setState(() {
                _focusedDay = focusedDay;
              });
            },

            // 가로 스크롤 (위젯 내부 제스처)
            availableGestures: AvailableGestures.horizontalSwipe,

            calendarStyle: CalendarStyle(
              // 다른 달의 날짜
              outsideDaysVisible: true,
              // 마커 개수
              markersMaxCount: 0,
            ),

            calendarBuilders: CalendarBuilders(
              // 요일 관련
              dowBuilder: (context, day) {
                if (day.weekday == DateTime.sunday) {
                  // DateFormat.E(): 요일
                  // DateFormat.d(): 일자
                  final text = DateFormat.E('ko').format(day);
                  return Center(
                    child: Text(
                        text, style: TextStyle(fontSize: 15, color: Colors.red.shade300, fontFamily: FontFamily.mapleStoryBold)
                    ),
                  );
                } else if (day.weekday == DateTime.saturday) {
                  final text = DateFormat.E('ko').format(day);
                  return Center(
                    child: Text(
                        text, style: TextStyle(fontSize: 15, color: Colors.blue.shade300, fontFamily: FontFamily.mapleStoryBold)
                    ),
                  );
                }
                else{
                  final text = DateFormat.E('ko').format(day);
                  return Center(
                    child: Text(
                        text, style: TextStyle(fontSize: 15, color: ColorFamily.gray, fontFamily: FontFamily.mapleStoryBold)
                    ),
                  );
                }
              },

              // 범위에 포함 되어 있지 않은 날짜
              disabledBuilder: (context, day, focusedDay) {
                return Column(
                  children: [
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Text('${day.day}', style: TextStyle(fontSize: 14, color: ColorFamily.gray, fontFamily: FontFamily.mapleStoryLight, overflow: TextOverflow.ellipsis)),
                  ],
                );
              },

              // 모든 날짜 관련
              defaultBuilder: (context, day, focusedDay) {
                final events = _getEventsForDay(day);
                if (day.weekday == DateTime.sunday) {
                  return Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 10)),
                      Text('${day.day}', style: TextStyle(fontSize: 14, color: Colors.red.shade300, fontFamily: FontFamily.mapleStoryLight, overflow: TextOverflow.ellipsis)),

                      // 이벤트 목록
                      for (var event in events)
                        Container(
                            padding: EdgeInsets.symmetric(vertical: 2),
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Text(
                                  event.title1,
                                  style: TextStyle(fontSize: 10, color: ColorFamily.black, fontFamily: FontFamily.mapleStoryLight),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                Text(
                                  event.title2,
                                  style: TextStyle(fontSize: 10, color: ColorFamily.pink, fontFamily: FontFamily.mapleStoryLight),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ],
                            )
                        ),
                    ],
                  );
                }
                else if(day.weekday == DateTime.saturday){
                  return Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 10)),
                      Text('${day.day}', style: TextStyle(fontSize: 14, color: Colors.blue.shade300, fontFamily: FontFamily.mapleStoryLight, overflow: TextOverflow.ellipsis)),

                      // 이벤트 목록
                      for (var event in events)
                        Container(
                            padding: EdgeInsets.symmetric(vertical: 2),
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Text(
                                  event.title1,
                                  style: TextStyle(fontSize: 10, color: ColorFamily.black, fontFamily: FontFamily.mapleStoryLight),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                Text(
                                  event.title2,
                                  style: TextStyle(fontSize: 10, color: ColorFamily.pink, fontFamily: FontFamily.mapleStoryLight),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ],
                            )
                        ),
                    ],
                  );
                }
                else{
                  return Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 10)),
                      Text('${day.day}', style: TextStyle(fontSize: 14,
                          color: ColorFamily.black,
                          fontFamily: FontFamily.mapleStoryLight,
                          overflow: TextOverflow.ellipsis)),

                      // 이벤트 목록
                      for (var event in events)
                        Container(
                            padding: EdgeInsets.symmetric(vertical: 2),
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Text(
                                  event.title1,
                                  style: TextStyle(fontSize: 10, color: ColorFamily.black, fontFamily: FontFamily.mapleStoryLight),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                Text(
                                  event.title2,
                                  style: TextStyle(fontSize: 10, color: ColorFamily.pink, fontFamily: FontFamily.mapleStoryLight),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ],
                            )
                        ),
                    ],
                  );
                }
              },

              // 오늘 날짜 관련
              todayBuilder: (context, day, focusedDay) {
                final events = _getEventsForDay(day);
                return Column(
                  children: [
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Text('${day.day}', style: TextStyle(fontSize: 14, color: ColorFamily.pink, fontFamily: FontFamily.mapleStoryLight, overflow: TextOverflow.ellipsis)),

                    // 이벤트 목록
                    for (var event in events)
                      Container(
                          padding: EdgeInsets.symmetric(vertical: 2),
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Text(
                                event.title1,
                                style: TextStyle(fontSize: 10, color: ColorFamily.black, fontFamily: FontFamily.mapleStoryLight),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              Text(
                                event.title2,
                                style: TextStyle(fontSize: 10, color: ColorFamily.pink, fontFamily: FontFamily.mapleStoryLight),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                          )
                      ),
                  ],
                );
              },

              // 선택된 날짜 관련
              selectedBuilder: (context, day, focusedDay) {
                final events = _getEventsForDay(day);
                return Column(
                  children: [
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Container(
                      width: 60,
                      height: 70,
                      decoration: const BoxDecoration(
                          color: Color(0x50FEBE98),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Column(
                        children: [
                          Text('${day.day}', style: TextStyle(fontSize: 14,
                              color: day.weekday == DateTime.sunday ? Colors.red.shade300 : day.weekday == DateTime.saturday ? Colors.blue.shade300 : ColorFamily.black,
                              fontFamily: FontFamily.mapleStoryLight,
                              overflow: TextOverflow.ellipsis),
                          ),
                          // 이벤트 목록
                          for (var event in events)
                            Container(
                                padding: EdgeInsets.symmetric(vertical: 2),
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    Text(
                                      event.title1,
                                      style: TextStyle(fontSize: 10, color: ColorFamily.black, fontFamily: FontFamily.mapleStoryLight),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    Text(
                                      event.title2,
                                      style: TextStyle(fontSize: 10, color: ColorFamily.pink, fontFamily: FontFamily.mapleStoryLight),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ],
                                )
                            ),
                        ],
                      ),
                    ),
                  ],
                );
              },

              // 다른 달의 날짜 관련
              outsideBuilder: (context, day, focusedDay) {
                final events = _getEventsForDay(day);
                return Column(
                  children: [
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Text('${day.day}', style: TextStyle(fontSize: 14, color: ColorFamily.gray, fontFamily: FontFamily.mapleStoryLight, overflow: TextOverflow.ellipsis)),
                    // 이벤트 목록
                    for (var event in events)
                      Container(
                          padding: EdgeInsets.symmetric(vertical: 2),
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Text(
                                event.title1,
                                style: TextStyle(fontSize: 10, color: ColorFamily.gray, fontFamily: FontFamily.mapleStoryLight),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              Text(
                                event.title2,
                                style: TextStyle(fontSize: 10, color: ColorFamily.gray, fontFamily: FontFamily.mapleStoryLight),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                          )
                      ),
                  ],
                );
              },
            ),
          ),
        ),

        // _selectedEvents의 값이 변경될 때마다 builder 콜백을 호출하여 새로운 UI로 변경
        ValueListenableBuilder<List<Event>>(
          // 감시할 값
          valueListenable: _selectedShowEvents,
          builder: (context, value, _) {
            return ListView.builder(
              // ListTile의 리스트뷰의 높이를 자식 아이템들의 높이에 맞춰 설정
              shrinkWrap: true,
              // ListTile의 리스트뷰 자체의 스크롤을 비활성화
              physics: NeverScrollableScrollPhysics(),
              // 리스트 아이템의 개수를 _selectedEvents의 길이로 설정
              itemCount: value.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                  child: Material(
                    color: ColorFamily.white,
                    elevation: 1,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: ColorFamily.white),
                      child: ListTile(
                        leading: SvgPicture.asset('lib/assets/icons/spoon_fork.svg', width: 24, height: 24),
                        title: Text(value[index].title1, style: TextStyle(color: ColorFamily.black, fontSize: 14, fontFamily: FontFamily.mapleStoryLight)),
                        trailing: Text(value[index].title2 + '원', style: TextStyle(color: ColorFamily.black, fontSize: 10, fontFamily: FontFamily.mapleStoryLight)),
                        onTap: () {
                          // 화면 전환
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              // 보여질 다음 화면을 설정한다.
                              builder: (context) => LedgerDetailScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
        SizedBox(height: 80),
      ],
    );
  }

  // 커스텀 헤더 함수
  Widget calendarCustomHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 23),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              DateFormat.MMMM('ko').format(_focusedDay),
              style: TextStyle(fontSize: 20, color: ColorFamily.black, fontFamily: FontFamily.mapleStoryBold),
            ),
          ),

          // 제목 옆에 아이콘 추가
          InkWell(
              onTap: () {
                 print('월 이동 클릭');
                _showDateTimePicker();
              },
              child: Container(
                padding: EdgeInsets.all(8),
                child: Center(
                    child: SvgPicture.asset('lib/assets/icons/under_triangle.svg')
                ),
              )
          ),
        ],
      ),
    );
  }
}

// eventLoader에 사용.
class Event {
  // 이벤트 제목
  String title1;
  String title2;

  Event(this.title1, this.title2);

}