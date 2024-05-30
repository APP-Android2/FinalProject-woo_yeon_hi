import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/tab_page_index_provider.dart';
import 'more/more_screen.dart';

class MainScreenContainer extends StatefulWidget {
  const MainScreenContainer({super.key});

  @override
  State<MainScreenContainer> createState() => _MainScreenContainerState();
}

class _MainScreenContainerState extends State<MainScreenContainer> {

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
        Text("diary"),
        Text("ledger"),
        Text("home"),
        Text("foot_print"),
        MoreScreen()
      ][currentPageIndex],
    );
  }
}