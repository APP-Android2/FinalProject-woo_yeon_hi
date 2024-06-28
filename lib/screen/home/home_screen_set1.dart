import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/style/text_style.dart';
import 'package:woo_yeon_hi/widget/home/home_top_app_bar.dart';

class HomeScreenSet1 extends StatefulWidget {
  const HomeScreenSet1({super.key});

  @override
  State<HomeScreenSet1> createState() => _HomeScreenState1();
}

class _HomeScreenState1 extends State<HomeScreenSet1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeTopAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            color: const Color(0xffFCF8F5),
            child: Column(
              children: [
                const SizedBox(height: 20),
                _dDay(),
                const SizedBox(height: 20),
                _calendar(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _dDay() {
    return _cardContainer(
      Row(
        children: [
          const Text("디데이", style: TextStyle(color: ColorFamily.black, fontSize: 20, fontFamily: FontFamily.mapleStoryLight)),
          SizedBox(
            width: 40, // 원하는 너비
            height: 40, // 원하는 높이
            child: FittedBox(
              child: IconButton(
                icon: SvgPicture.asset('lib/assets/icons/expand.svg'),
                onPressed: () {
                  // 버튼이 눌렸을 때의 액션
                },
              ),
            ),
          )
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(child: Image.asset('lib/assets/images/test_wooyeon_man.jpg', width: 75, height: 75)),
              const SizedBox(height: 5),
              const Text("우연남", style: TextStyle(fontSize: 14, color: ColorFamily.black, fontFamily: FontFamily.mapleStoryLight)),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('lib/assets/icons/like.svg'),
              const SizedBox(height: 5),
              const Text(
                '100일',
                style: TextStyle(fontFamily: FontFamily.mapleStoryLight),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(child: Image.asset('lib/assets/images/test_wooyeon_women.jpg', width: 75, height: 75)),
              const SizedBox(height: 5),
              const Text("우연녀", style: TextStyle(fontSize: 14, color: Colors.black, fontFamily: FontFamily.mapleStoryLight)),
            ],
          ),
        ],
      ),
      120,
    );
  }

  Widget _calendar() {
    CalendarFormat _calendarFormat = CalendarFormat.month;
    DateTime _focusedDay = DateTime.now();
    DateTime? _selectedDay;

    final kToday = DateTime.now();
    final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
    final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

    return _cardContainer(
        Row(
          children: [
            const Text("캘린더", style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: FontFamily.mapleStoryLight)),
            SizedBox(
              width: 40, // 원하는 너비
              height: 40, // 원하는 높이
              child: FittedBox(
                child: IconButton(
                  icon: SvgPicture.asset('lib/assets/icons/expand.svg'),
                  onPressed: () {
                    // 버튼이 눌렸을 때의 액션
                  },
                ),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TableCalendar(
                locale: 'ko_KR',
                headerStyle: const HeaderStyle(
                  titleCentered: true,
                  titleTextStyle: TextStyleFamily.appBarTitleBoldTextStyle,
                  formatButtonVisible: false,
                ),
                firstDay: kFirstDay,
                lastDay: kLastDay,
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(_selectedDay, selectedDay)) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  }
                },
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
              ),
              const SizedBox(height: 10),
              Container(
                height: 50,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: ColorFamily.beige,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("11:50 AM", style: TextStyle(fontSize: 16, fontFamily: FontFamily.mapleStoryLight)),
                    Text("우연녀와 점심 데이트", style: TextStyle(fontSize: 16, fontFamily: FontFamily.mapleStoryLight)),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 50,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: ColorFamily.beige,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("13:00 PM", style: TextStyle(fontSize: 16, fontFamily: FontFamily.mapleStoryLight)),
                    Text("우연녀와 보드카페", style: TextStyle(fontSize: 16, fontFamily: FontFamily.mapleStoryLight)),
                  ],
                ),
              ),
            ],
          ),
        ),
        null);
  }

  Widget _cardContainer(Widget title, Widget child, double? height) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        title,
        const SizedBox(height: 8),
        Container(
          width: 320,
          height: height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 1,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: child,
        )
      ],
    );
  }
}
