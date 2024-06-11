import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/style/text_style.dart';
import 'package:woo_yeon_hi/widget/home/home_top_app_bar.dart';

import '../calendar/calendar_screen.dart';
import '../dDay/dDay_screen.dart';

class HomeScreenSet4 extends StatefulWidget {
  const HomeScreenSet4({super.key});

  @override
  State<HomeScreenSet4> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenSet4> {
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
                _datePlan(),
                const SizedBox(height: 20),
                _accountBook(),
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => dDayScreen()));
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

  Widget _datePlan() {
    final controller = PageController(viewportFraction: 1, keepPage: true);
    final pages = List.generate(
        4,
            (index) => const Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("제주도 여행", style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: FontFamily.mapleStoryLight)),
            Text("2024.6.13(수) - 2024.6.17(월)",
                style: TextStyle(color: Colors.black, fontSize: 12, fontFamily: FontFamily.mapleStoryLight)),
            Text("2024.5.17 작성 by 우연녀",
                textAlign: TextAlign.right,
                style: TextStyle(color: Colors.black, fontSize: 10, fontFamily: FontFamily.mapleStoryLight)),
          ],
        ));

    return _cardContainer(
      const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("데이트 플랜", style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: FontFamily.mapleStoryLight)),
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(top: 16, left: 20, right: 20, bottom: 5),
        child: Column(
          children: <Widget>[
            Expanded(
              child: PageView.builder(
                controller: controller,
                itemCount: pages.length,
                itemBuilder: (_, index) {
                  return pages[index % pages.length];
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: ColorFamily.beige,
              ),
              child: SmoothPageIndicator(
                controller: controller,
                count: pages.length,
                effect: const ScrollingDotsEffect(
                  dotHeight: 11,
                  dotWidth: 11,
                  activeDotColor: ColorFamily.pink,
                  dotColor: ColorFamily.white,
                ),
              ),
            ),
          ],
        ),
      ),
      100,
    );
  }

  Widget _accountBook() {
    return _cardContainer(
      const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("가계부", style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: FontFamily.mapleStoryLight)),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ClipRRect(
            child: Material(
              child: IconButton(
                onPressed: () {},
                icon: SvgPicture.asset('lib/assets/icons/arrow_left.svg'),
              ),
            ),
          ),
          const Text("10월", style: TextStyle(color: Colors.black, fontSize: 24, fontFamily: FontFamily.mapleStoryLight)),
          ClipRRect(
            child: Material(
              child: IconButton(
                onPressed: () {},
                icon: SvgPicture.asset('lib/assets/icons/arrow_right.svg'),
              ),
            ),
          ),
          Container(width: 2, height: 70, color: ColorFamily.pink),
          const Text("526,300원 소비", style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: FontFamily.mapleStoryLight))
        ],
      ),
      100,
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CalendarScreen()));
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
                blurRadius: 4,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: child,
        )
      ],
    );
  }
}
