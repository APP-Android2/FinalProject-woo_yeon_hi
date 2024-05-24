import 'package:flutter/material.dart';
import 'package:woo_yeon_hi/provider/tab_page_index_provider.dart';
import 'package:woo_yeon_hi/screen/register/connect_code_screen.dart';
import 'package:woo_yeon_hi/screen/register/register_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const WooYeonHi());
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
        title: "WooYeonHi",
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: ColorFamily.cream,
                brightness: Brightness.light
            ),
            useMaterial3: true
        ),
        home: ChangeNotifierProvider(
          create: (BuildContext context) => TabPageIndexProvider(),
          child: const DefaultTabController(
            initialIndex: 2,
            length: 5,
            child: Scaffold(
              // bottomNavigationBar: MainBottomNavigationBar(),
              body: ConnectCodeScreen(),
            ),
          ),
        )
    );
  }
}

