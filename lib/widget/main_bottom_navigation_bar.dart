import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/provider/tab_page_index_provider.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/text_style.dart';

class MainBottomNavigationBar extends StatefulWidget {
  const MainBottomNavigationBar({super.key});

  @override
  State<MainBottomNavigationBar> createState() => _MainBottomNavigationBarState();
}

class _MainBottomNavigationBarState extends State<MainBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    var tabPageIndexProvider = Provider.of<TabPageIndexProvider>(context, listen: false);

    return TabBar(
      indicatorColor: Colors.transparent,
      unselectedLabelColor: ColorFamily.black,
      labelColor: ColorFamily.pink,
      labelStyle: TextStyleFamily.normalTextStyle,
      unselectedLabelStyle: TextStyleFamily.normalTextStyle,
      tabs: [
        Tab(
          text: "일기",
          icon: SvgPicture.asset(
            'lib/assets/icons/diary.svg',
            colorFilter: ColorFilter.mode(
                tabPageIndexProvider.currentPageIndex == 0
                  ? ColorFamily.pink
                  : ColorFamily.black,
                BlendMode.srcIn),
          ),
        ),
        Tab(
          text: "가계부",
          icon: SvgPicture.asset(
            'lib/assets/icons/piggy_bank.svg',
            colorFilter: ColorFilter.mode(
                tabPageIndexProvider.currentPageIndex == 1
                    ? ColorFamily.pink
                    : ColorFamily.black,
                BlendMode.srcIn),
          ),
        ),
        Tab(
          text: "홈",
          icon: SvgPicture.asset(
            'lib/assets/icons/home.svg',
            colorFilter: ColorFilter.mode(
                tabPageIndexProvider.currentPageIndex == 2
                    ? ColorFamily.pink
                    : ColorFamily.black,
                BlendMode.srcIn),
          ),
        ),
        Tab(
          text: "발자국",
          icon: SvgPicture.asset(
            'lib/assets/icons/foot_print.svg',
            colorFilter: ColorFilter.mode(
                tabPageIndexProvider.currentPageIndex == 3
                    ? ColorFamily.pink
                    : ColorFamily.black,
                BlendMode.srcIn),),
        ),
        Tab(
          text: "더보기",
          icon: SvgPicture.asset(
            'lib/assets/icons/more.svg',
            colorFilter: ColorFilter.mode(
                tabPageIndexProvider.currentPageIndex == 4
                    ? ColorFamily.pink
                    : ColorFamily.black,
                BlendMode.srcIn),),
        ),
      ],

      onTap: (value){
        setState(() {
          tabPageIndexProvider.setCurrentPageIndex(value);
        });
      },

    );
  }
}
