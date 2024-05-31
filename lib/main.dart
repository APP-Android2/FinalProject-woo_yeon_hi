import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:woo_yeon_hi/provider/ledger_check_box_provider.dart';
import 'package:woo_yeon_hi/provider/tab_page_index_provider.dart';
import 'package:woo_yeon_hi/screen/main_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/widget/main_bottom_navigation_bar.dart';

void main() {
  // ko_KR 언어 설정을 위함
  initializeDateFormatting();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TabPageIndexProvider()),
        ChangeNotifierProvider(create: (_) => LedgerCheckBoxProvider()),
      ],
      child: WooYeonHi(),
    ),
  );
}

class WooYeonHi extends StatefulWidget {
  const WooYeonHi({super.key});

  @override
  State<WooYeonHi> createState() => _WooYeonHiState();
}

class _WooYeonHiState extends State<WooYeonHi> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "WooYeonHi",
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: ColorFamily.white,
                brightness: Brightness.light
            ),
            useMaterial3: true
        ),
        home: const DefaultTabController(
          initialIndex: 2,
          length: 5,
          child: Scaffold(
            bottomNavigationBar: MainBottomNavigationBar(),
            body: MainScreen(),
          ),
        ),
    );
  }
}

