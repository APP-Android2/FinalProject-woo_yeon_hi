import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/screen/main_screen_container.dart';

import '../provider/tab_page_index_provider.dart';
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
      ],
      child: MaterialApp(
        title: "WooYeonHi",
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: ColorFamily.cream,
                brightness: Brightness.light
            ),
            useMaterial3: true
        ),
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