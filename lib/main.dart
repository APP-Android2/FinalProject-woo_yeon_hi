import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:woo_yeon_hi/provider/diary_provider.dart';
import 'package:woo_yeon_hi/provider/footprint_provider.dart';
import 'package:woo_yeon_hi/provider/tab_page_index_provider.dart';
import 'package:woo_yeon_hi/screen/main_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/widget/main_bottom_navigation_bar.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(const WooYeonHi()));
}

class WooYeonHi extends StatefulWidget {
  const WooYeonHi({super.key});

  @override
  State<WooYeonHi> createState() => _WooYeonHiState();
}

class _WooYeonHiState extends State<WooYeonHi> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => TabPageIndexProvider()),
          ChangeNotifierProvider(create: (context) => DiaryProvider()),
          ChangeNotifierProvider(create: (context) => FootprintProvider()),
          ChangeNotifierProvider(create: (context) => FootPrintSlidableProvider()),
          ChangeNotifierProvider(create: (context) => FootPrintDatePlanSlidableProvider()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "WooYeonHi",
            theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  seedColor: ColorFamily.white,
                ),
                textSelectionTheme: const TextSelectionThemeData(selectionHandleColor: ColorFamily.black),
                highlightColor: ColorFamily.gray,
                splashColor: ColorFamily.gray,
                useMaterial3: true),
            home: const DefaultTabController(
              initialIndex: 2,
              length: 5,
              child: Scaffold(
                backgroundColor: ColorFamily.white,
                bottomNavigationBar: MainBottomNavigationBar(),
                body: MainScreen(),
              ),
            )));
  }
}
