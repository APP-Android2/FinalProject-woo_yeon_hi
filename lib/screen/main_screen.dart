import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/screen/ledger_screen.dart';
import 'package:woo_yeon_hi/screen/footPrint/footprint_screen.dart';

import '../provider/tab_page_index_provider.dart';
import 'diary/diary_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    var tabPageIndexProvider = Provider.of<TabPageIndexProvider>(context, listen:false);
    var currentPageIndex = tabPageIndexProvider.currentPageIndex;
    tabPageIndexProvider.addListener(() {
      // 화면의 순서값을 변경한다.
      setState(() {
        currentPageIndex = tabPageIndexProvider.currentPageIndex;
      });
    });
    return Container(
      alignment: Alignment.center,
      child: [
        const DiaryScreen(),
        LedgerScreen(),
        Text("home"),
        const FootprintScreen(),
        Text("more")
      ][currentPageIndex],
    );
  }
}
