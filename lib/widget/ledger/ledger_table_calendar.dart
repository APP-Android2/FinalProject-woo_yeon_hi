import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:woo_yeon_hi/model/enums.dart';
import 'package:woo_yeon_hi/model/ledger_model.dart';
import 'package:woo_yeon_hi/provider/ledger_provider.dart';
import 'package:woo_yeon_hi/screen/ledger/ledger_detail_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';

class LedgerTableCalendar extends StatefulWidget {
  const LedgerTableCalendar({super.key});

  @override
  State<LedgerTableCalendar> createState() => _LedgerTableCalendarState();
}

class _LedgerTableCalendarState extends State<LedgerTableCalendar> {

  // 캘린더에 보여주는 지출, 수입 총액
  Map<DateTime, List<Ledger>> _groupEvents(List<Ledger> ledgers) {
    Map<DateTime, List<Ledger>> _showMainEvents = {};
    for (var ledger in ledgers) {
      DateTime date = DateTime.parse(ledger.ledgerDate).toLocal();
      DateTime day = DateTime(date.year, date.month, date.day);
      if (_showMainEvents[day] == null) {
        _showMainEvents[day] = [];
      }
      _showMainEvents[day]!.add(ledger);
    }
    return _showMainEvents;
  }

  // ledgerType(지출, 수입)에 따라 총 금액을 계산
  Map<String, int> calculateTotalMoney(List<Ledger> ledgers) {
    int expenditure = 0;
    int income = 0;

    for (var ledger in ledgers) {
      if (ledger.ledgerType.type == 0) {
        expenditure += ledger.ledgerAmount;
      }else if(ledger.ledgerType.type == 1) {
        income += ledger.ledgerAmount;
      }
    }
    return {
      'expenditure': expenditure,
      'income': income,
    };
  }

  // 캘린더 이벤트 텍스트에 콤마
  String formatNumber(int number) {
    final formatter = NumberFormat('#,###');
    return formatter.format(number);
  }

  String cleanCurrencyString(String value) {
    // 문자열에서 숫자만 추출
    final cleanedString = value.replaceAll(RegExp(r'[^0-9]'), '');
    // 문자열을 정수로 변환
    return cleanedString;
  }

  int sumCurrencyStrings(List<String> values) {
    int total = 0;

    for (var value in values) {
      String cleanedValue = cleanCurrencyString(value);
      if (cleanedValue.isNotEmpty) {
        total += int.parse(cleanedValue);
      }
    }
    return total;
  }

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
          //_selectedShowEvents.value = _getEventsShowForDay(_selectedDay!);
        });
      },
      currentTime: _selectedDay,
      locale: LocaleType.ko,
    );
  }
  
  // 이벤트 리스트의 카테고리 아이콘 정의
  String getIconPath(LedgerCategory category) {
    const categoryIconMap = {
      LedgerCategory.FOOD_EXPENSES: 'lib/assets/icons/spoon_fork.svg',
      LedgerCategory.CAFFE: 'lib/assets/icons/coffee_cup.svg',
      LedgerCategory.PUBLIC_TRANSPORT: 'lib/assets/icons/bus.svg',
      LedgerCategory.SHOPPING: 'lib/assets/icons/shopping_cart.svg',
      LedgerCategory.CULTURE: 'lib/assets/icons/culture_popcorn.svg',
      LedgerCategory.HOBBY: 'lib/assets/icons/hobby_puzzle.svg',
      LedgerCategory.DATE_WITH: 'lib/assets/icons/lover.svg',
      LedgerCategory.GAME: 'lib/assets/icons/game.svg',
      LedgerCategory.TRAVEL: 'lib/assets/icons/travel.svg',
      LedgerCategory.DWELLING: 'lib/assets/icons/maintain_home.svg',
      LedgerCategory.LIFE: 'lib/assets/icons/life_leaf.svg',
      LedgerCategory.ETC: 'lib/assets/icons/etc_more.svg',
      LedgerCategory.DEPOSIT: 'lib/assets/icons/money_deposit.svg',
      LedgerCategory.INCOME_ADD: 'lib/assets/icons/income_add.svg',
      LedgerCategory.INCOME_BONUS: 'lib/assets/icons/income_bonus.svg',
      LedgerCategory.INCOME_ETC: 'lib/assets/icons/etc_more.svg',
    };

    return categoryIconMap[category] ?? 'lib/assets/icons/etc_more.svg';
  }

  @override
  void initState() {
    super.initState();
    // 초기 선택된 날짜를 현재 포커스된 날짜로 설정
    _selectedDay = _focusedDay;
    // 초기 선택된 날짜의 이벤트 설정
    //_selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LedgerProvider>(
      builder: (context, ledgerProvider, child) {
        // 캘린더에 보여 줄 이벤트 (지출, 수입 내역)
        Map<DateTime, List<Ledger>> _showMainEvents = _groupEvents(ledgerProvider.ledgers);

        // 선택된 날짜의 이벤트를 필터링 (상세 이벤트 리스트)
        List<Ledger> selectedDayLedgers = ledgerProvider.ledgers
            .where((ledger) =>
            DateTime.parse(ledger.ledgerDate).toLocal().day == ledgerProvider.selectedDay.day &&
            DateTime.parse(ledger.ledgerDate).toLocal().month == ledgerProvider.selectedDay.month &&
            DateTime.parse(ledger.ledgerDate).toLocal().year == ledgerProvider.selectedDay.year).toList();

        // 지출, 수입의 계산 결과
        Map<String, int> totalMoney = calculateTotalMoney(selectedDayLedgers);

        return Column(
          children: [
            calendarCustomHeader(),
            Container(
              child: TableCalendar(
                // 달력의 시작 날짜
                firstDay: DateTime.utc(2023, 01, 01),
                // 달력의 마지막 날짜
                lastDay: DateTime.utc(2024, 12, 31),
                // 현재 포커스된 날짜
                //focusedDay: _focusedDay,
                focusedDay: ledgerProvider.focusedDay,
                // 특정 날짜의 이벤트를 로드
                // eventLoader: _getEventsForDay,
                eventLoader: (day) {
                  return _showMainEvents[day] ?? [];
                },
                // 언어 설정
                locale: 'ko_KR',
                // 요일 부분의 높이 조절
                daysOfWeekHeight: 30,
                // 날짜 부분의 셀의 높이
                rowHeight: 80,
                // 헤더 지우기
                headerVisible: false,

                // 선택된 날짜 확인 (selectedBuilder)
                selectedDayPredicate: (day) => isSameDay(ledgerProvider.selectedDay, day),

                // 날짜 선택 시 호출되는 함수
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    // 선택된 날짜 업데이트
                    ledgerProvider.setSelectedDay(selectedDay);
                    // 포커스된 날짜 업데이트
                    ledgerProvider.setFocusedDay(focusedDay);
                  });
                },

                // 페이지(월 이동) 스크롤 시 호출되는 함수
                onPageChanged: (focusedDay) {
                  setState(() {
                    ledgerProvider.setSelectedAndFocusedDay(focusedDay);

                    // 상단 베너 데이터 업데이트
                    ledgerProvider.updateTextsOnMonthChange(focusedDay);
                  });
                },

                // 가로 스크롤 (위젯 내부 제스처)
                availableGestures: AvailableGestures.horizontalSwipe,

                calendarStyle: const CalendarStyle(
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
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        Text('${day.day}', style: const TextStyle(fontSize: 14, color: ColorFamily.gray, fontFamily: FontFamily.mapleStoryLight, overflow: TextOverflow.ellipsis)),
                      ],
                    );
                  },

                  // 모든 날짜 관련
                  defaultBuilder: (context, date, focusedDay) {
                    DateTime day = DateTime(date.year, date.month, date.day);
                    List<Ledger> dayEvents = _showMainEvents[day] ?? [];
                    // 지출 총합
                    //int totalMoney = calculateTotalMoney(dayEvents);
                    Map<String, int> dayTotalMoney = calculateTotalMoney(dayEvents);


                    if (day.weekday == DateTime.sunday) {
                      return Column(
                        children: [
                          const Padding(padding: EdgeInsets.only(top: 10)),
                          Text('${day.day}', style: TextStyle(fontSize: 14, color: Colors.red.shade300, fontFamily: FontFamily.mapleStoryLight, overflow: TextOverflow.ellipsis)),

                          // 이벤트 목록
                          //for (var event in events)
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                if (dayTotalMoney['expenditure'] != 0)
                                  Text(
                                    '-${formatNumber(dayTotalMoney['expenditure']!)}',
                                    style: const TextStyle(fontSize: 10, color: ColorFamily.black, fontFamily: FontFamily.mapleStoryLight),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                if (dayTotalMoney['income'] != 0)
                                  Text(
                                    '+${formatNumber(dayTotalMoney['income']!)}',
                                    style: const TextStyle(fontSize: 10, color: ColorFamily.pink, fontFamily: FontFamily.mapleStoryLight),
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
                          const Padding(padding: EdgeInsets.only(top: 10)),
                          Text('${day.day}', style: TextStyle(fontSize: 14, color: Colors.blue.shade300, fontFamily: FontFamily.mapleStoryLight, overflow: TextOverflow.ellipsis)),

                          // 이벤트 목록
                          //for (var event in events)
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                if (dayTotalMoney['expenditure'] != 0)
                                  Text(
                                    '-${formatNumber(dayTotalMoney['expenditure']!)}',
                                    style: const TextStyle(fontSize: 10, color: ColorFamily.black, fontFamily: FontFamily.mapleStoryLight),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                if (dayTotalMoney['income'] != 0)
                                  Text(
                                    '+${formatNumber(dayTotalMoney['income']!)}',
                                    style: const TextStyle(fontSize: 10, color: ColorFamily.pink, fontFamily: FontFamily.mapleStoryLight),
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
                          const Padding(padding: EdgeInsets.only(top: 10)),
                          Text('${day.day}', style: const TextStyle(fontSize: 14,
                              color: ColorFamily.black,
                              fontFamily: FontFamily.mapleStoryLight,
                              overflow: TextOverflow.ellipsis)),

                          // 이벤트 목록
                          //for (var event in events)
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                if (dayTotalMoney['expenditure'] != 0)
                                  Text(
                                    '-${formatNumber(dayTotalMoney['expenditure']!)}',
                                    style: const TextStyle(fontSize: 10, color: ColorFamily.black, fontFamily: FontFamily.mapleStoryLight),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                if (dayTotalMoney['income'] != 0)
                                  Text(
                                    '+${formatNumber(dayTotalMoney['income']!)}',
                                    style: const TextStyle(fontSize: 10, color: ColorFamily.pink, fontFamily: FontFamily.mapleStoryLight),
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
                  todayBuilder: (context, date, focusedDay) {
                    DateTime day = DateTime(date.year, date.month, date.day);
                    List<Ledger> dayEvents = _showMainEvents[day] ?? [];
                    Map<String, int> dayTotalMoney = calculateTotalMoney(dayEvents);

                    return Column(
                      children: [
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        Text('${day.day}', style: const TextStyle(fontSize: 14, color: ColorFamily.pink, fontFamily: FontFamily.mapleStoryLight, overflow: TextOverflow.ellipsis)),

                        // 이벤트 목록
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              if (dayTotalMoney['expenditure'] != 0)
                                Text(
                                  '-${formatNumber(dayTotalMoney['expenditure']!)}',
                                  style: const TextStyle(fontSize: 10, color: ColorFamily.black, fontFamily: FontFamily.mapleStoryLight),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              if (dayTotalMoney['income'] != 0)
                                Text(
                                  '+${formatNumber(dayTotalMoney['income']!)}',
                                  style: const TextStyle(fontSize: 10, color: ColorFamily.pink, fontFamily: FontFamily.mapleStoryLight),
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
                  selectedBuilder: (context, date, focusedDay) {
                    DateTime day = DateTime(date.year, date.month, date.day);
                    List<Ledger> dayEvents = _showMainEvents[day] ?? [];
                    Map<String, int> dayTotalMoney = calculateTotalMoney(dayEvents);
                    print('dayTotalMoney: ${dayTotalMoney}');

                    // 이벤트 값 확인
                    print('선택된 이벤트 확인 Date: $day, Events: $dayEvents, TotalMoney: $totalMoney, dayTotalMoney: $dayTotalMoney');

                    return Column(
                      children: [
                        const Padding(padding: EdgeInsets.only(top: 10)),
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
                              Container(
                                padding: const EdgeInsets.symmetric(vertical: 2),
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    if (dayTotalMoney['expenditure'] != 0)
                                    Text(
                                      '-${formatNumber(dayTotalMoney['expenditure']!)}',
                                      style: const TextStyle(fontSize: 10, color: ColorFamily.black, fontFamily: FontFamily.mapleStoryLight),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    if (dayTotalMoney['income'] != 0)
                                    Text(
                                      '+${formatNumber(dayTotalMoney['income']!)}',
                                      style: const TextStyle(fontSize: 10, color: ColorFamily.pink, fontFamily: FontFamily.mapleStoryLight),
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
                  outsideBuilder: (context, date, focusedDay) {
                    DateTime day = DateTime(date.year, date.month, date.day);
                    List<Ledger> dayEvents = _showMainEvents[day] ?? [];
                    Map<String, int> dayTotalMoney = calculateTotalMoney(dayEvents);

                    return Column(
                      children: [
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        Text('${day.day}', style: const TextStyle(fontSize: 14, color: ColorFamily.gray, fontFamily: FontFamily.mapleStoryLight, overflow: TextOverflow.ellipsis)),
                        // 이벤트 목록
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              if (dayTotalMoney['expenditure'] != 0)
                                Text(
                                  '-${formatNumber(dayTotalMoney['expenditure']!)}',
                                  style: const TextStyle(fontSize: 10, color: ColorFamily.black, fontFamily: FontFamily.mapleStoryLight),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              if (dayTotalMoney['income'] != 0)
                                Text(
                                  '+${formatNumber(dayTotalMoney['income']!)}',
                                  style: const TextStyle(fontSize: 10, color: ColorFamily.pink, fontFamily: FontFamily.mapleStoryLight),
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

            // 상세 이벤트 항목
            Container(
              child: ListView.builder(
                // ListTile의 리스트뷰의 높이를 자식 아이템들의 높이에 맞춰 설정
                shrinkWrap: true,
                // ListTile의 리스트뷰 자체의 스크롤을 비활성화
                physics: const NeverScrollableScrollPhysics(),
                itemCount: selectedDayLedgers.length,
                itemBuilder: (context, index) {
                  final ledger = selectedDayLedgers[index];
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                    child: Material(
                      color: ColorFamily.white,
                      elevation: 1,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: ColorFamily.white),
                        child: ListTile(
                          leading: SvgPicture.asset(getIconPath(ledger.ledgerCategory), width: 24, height: 24),
                          title: Text('${ledger.ledgerTitle}', style: const TextStyle(color: ColorFamily.black, fontSize: 14, fontFamily: FontFamily.mapleStoryLight)),
                          trailing: Text('${ledger.ledgerType.type == 0 ? '-' : '+'}${formatNumber(ledger.ledgerAmount)!}원', style: const TextStyle(color: ColorFamily.black, fontSize: 10, fontFamily: FontFamily.mapleStoryLight)),
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
              ),
            ),
            const SizedBox(height: 80),
          ],
        );
      },
    );
  }

  // 커스텀 헤더 함수
  Widget calendarCustomHeader() {
    var ledgerProvider = Provider.of<LedgerProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 23),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              DateFormat.MMMM('ko').format(ledgerProvider.focusedDay),
              style: const TextStyle(fontSize: 20, color: ColorFamily.black, fontFamily: FontFamily.mapleStoryBold),
            ),
          ),

          // 제목 옆에 아이콘 추가
          InkWell(
              onTap: () {
                // DatePicker 기능
                DatePicker.showPicker(
                  context,
                  showTitleActions: true,
                  locale: LocaleType.ko,
                  onChanged: (date) {
                    print('설정 중 change $date');
                  },
                  onConfirm: (date) {
                    print('확인 클릭 onConfirm $date');
                    DateTime firstDayOfMonth = DateTime(date.year, date.month, 1);
                    ledgerProvider.setSelectedAndFocusedDay(firstDayOfMonth);
                  },
                  pickerModel: CustomMonthPicker(
                    currentTime: DateTime.now(),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(8),
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

// DatePicker 커스텀 class
class CustomMonthPicker extends CommonPickerModel {
  CustomMonthPicker({DateTime? currentTime, LocaleType? locale})
      : super(locale: locale) {
    this.currentTime = currentTime ?? DateTime.now();
    this.setLeftIndex(this.currentTime.year - 2023);
    this.setMiddleIndex(this.currentTime.month - 1);
    this.setRightIndex(0);
  }

  @override
  String? leftStringAtIndex(int index) {
    if (index >= 0 && index < (2025 - 2023)) {
      return (2023 + index).toString();
    } else {
      return null;
    }
  }

  @override
  String? middleStringAtIndex(int index) {
    if (index >= 0 && index < 12) {
      return (index + 1).toString().padLeft(2, '0');
    } else {
      return null;
    }
  }

  @override
  String? rightStringAtIndex(int index) {
    return null;
  }

  @override
  void setLeftIndex(int index) {
    super.setLeftIndex(index);
    this.currentTime = DateTime(2023 + index, this.currentTime.month);
  }

  @override
  void setMiddleIndex(int index) {
    super.setMiddleIndex(index);
    this.currentTime = DateTime(this.currentTime.year, index + 1);
  }

  @override
  void setRightIndex(int index) {
    super.setRightIndex(index);
  }

  @override
  List<int> layoutProportions() {
    return [3, 2, 0];
  }

  @override
  DateTime finalTime() {
    return currentTime;
  }
}