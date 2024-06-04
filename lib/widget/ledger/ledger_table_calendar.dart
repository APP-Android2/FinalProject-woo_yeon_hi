import 'package:flutter/material.dart';
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

  // format 상태 저장할 변수
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // 지출, 수입 상세 데이터 (클릭 시 보여주는 데이터)
  Map<DateTime, dynamic> _events = {
    DateTime.utc(2024, 5, 14): [Event('-118,911,500'), Event('+3,620,000')],
    DateTime.utc(2024, 5, 16): [Event('-355,200'), Event('+559,800')],
    DateTime.utc(2024, 5, 21): [Event('-35,200'), Event('+55,800')],
    DateTime.utc(2024, 5, 27): [Event('-553,235,200'), Event('+55,800')],
  };

  // 지출, 수입 데이터 (캘린더 화면에만 보이는 데이터)
  Map<DateTime, dynamic> _eventsShow = {
    DateTime.utc(2024, 5, 14): [Event('-118,911,500'), Event('+3,620,000')],
    DateTime.utc(2024, 5, 16): [Event('-355,200'), Event('+559,800')],
    DateTime.utc(2024, 5, 21): [Event('-35,200'), Event('+55,800')],
  };


  @override
  void initState() {
    super.initState();
    // 초기 선택된 날짜를 현재 포커스된 날짜로 설정
    _selectedDay = _focusedDay;
    // 초기 선택된 날짜의 이벤트 설정
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }


  @override
  void dispose() {
    // ValueNotifier의 리소스 해제
    _selectedEvents.dispose();
    super.dispose();
  }


  // 특정 날짜의 이벤트 목록을 반환하는 함수
  List<Event> _getEventsForDay(DateTime day) {
    // 해당 날짜에 이벤트가 없으면 빈 리스트 반환
    return _events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    // 스크롤 가능한 단일 자식 위젯을 사용하여 전체 내용을 스크롤할 수 있게 한다.
    return SingleChildScrollView(
      child: Column(
        children: [
          calendarCustomHeader(),
          Container(
            child: TableCalendar<Event>(
              // 달력의 시작 날짜
              firstDay: DateTime.utc(2024, 04, 20),
              // 달력의 마지막 날짜
              lastDay: DateTime.utc(2024, 06, 20),
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

              // 선택된 날짜인지 확인
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
                });
              },

              // 페이지(월) 변경 시 호출되는 함수
              onPageChanged: (focusedDay) => _focusedDay = focusedDay,

              calendarStyle: CalendarStyle(
                // 다른 달의 날짜
                outsideDaysVisible: false,
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
                  return Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 10)),
                      Text('${day.day}', style: TextStyle(fontSize: 14, color: ColorFamily.black, fontFamily: FontFamily.mapleStoryLight, overflow: TextOverflow.ellipsis)),

                      // 이벤트 목록
                      for (var event in events)
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 2),
                          alignment: Alignment.center,
                          child: Text(
                            event.title,
                            style: TextStyle(fontSize: 10, color: ColorFamily.black, fontFamily: FontFamily.mapleStoryLight),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                    ],
                  );
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
                          child: Text(
                            event.title,
                            style: TextStyle(fontSize: 10, color: ColorFamily.black, fontFamily: FontFamily.mapleStoryLight),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
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
                            Text('${day.day}', style: TextStyle(fontSize: 14, color: ColorFamily.black, fontFamily: FontFamily.mapleStoryLight, overflow: TextOverflow.ellipsis)),
                            // 이벤트 목록
                            for (var event in events)
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 2),
                                alignment: Alignment.center,
                                child: Text(
                                  event.title,
                                  style: TextStyle(fontSize: 10, color: ColorFamily.black, fontFamily: FontFamily.mapleStoryLight),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                          ],
                        ),
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
            valueListenable: _selectedEvents,
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
                          title: Text('식비', style: TextStyle(color: ColorFamily.black, fontSize: 14, fontFamily: FontFamily.mapleStoryLight)),
                          trailing: Text(value[index].title + '원', style: TextStyle(color: ColorFamily.black, fontSize: 10, fontFamily: FontFamily.mapleStoryLight)),
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
      ),
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
  String title;

  Event(this.title);
}