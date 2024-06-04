import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/screen/ledger_screen.dart';
import 'package:woo_yeon_hi/screen/footPrint/footprint_screen.dart';

import '../provider/tab_page_index_provider.dart';
import 'diary/diary_screen.dart';
import 'package:woo_yeon_hi/screen/main_screen_container.dart';

import '../style/color.dart';
import '../widget/main_bottom_navigation_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TabPageIndexProvider()),

          ChangeNotifierProvider(create: (context) => DiaryProvider()),
          ChangeNotifierProvider(create: (context) => FootprintProvider()),
          ChangeNotifierProvider(create: (context) => FootPrintSlidableProvider()),
          ChangeNotifierProvider(create: (context) => FootPrintDatePlanSlidableProvider()),
          ChangeNotifierProvider(create: (context) => FootprintDraggableSheetProvider()),
          ChangeNotifierProvider(create: (_) => TabPageIndexProvider()),
          ChangeNotifierProvider(create: (_) => LedgerCheckBoxProvider()),
          ChangeNotifierProvider(create: (_) => LedgerCarouselProvider()),
      ],
      child: MaterialApp(
        title: "WooYeonHi",
        theme: ThemeData(
            colorScheme: ColorScheme(
                  brightness: Brightness.light,
                  primary: Colors.white,
                  onPrimary: Colors.black,
                  secondary: Colors.white,
                  onSecondary: Colors.black,
                  error: Colors.red,
                  onError: Colors.white,
                  background: Colors.white,
                  onBackground: Colors.black,
                  surface: Colors.white,
                  onSurface: Colors.black,
            ),
            textSelectionTheme: const TextSelectionThemeData(
                    selectionHandleColor: ColorFamily.black),
                highlightColor: ColorFamily.gray,
                splashColor: ColorFamily.gray,
                useMaterial3: true),
        home: const DefaultTabController(
          initialIndex: 2,
          length: 5,
          child: Scaffold(
            backgroundColor: ColorFamily.white,
            bottomNavigationBar: MainBottomNavigationBar(),
            body: MainScreenContainer(),
          ),
        ),
      ),
    );
  }
}