import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/dao/user_dao.dart';
import 'package:woo_yeon_hi/screen/home/home_screen_set1.dart';
import 'package:woo_yeon_hi/screen/home/home_screen_set2.dart';
import 'package:woo_yeon_hi/screen/home/home_screen_set4.dart';
import 'package:woo_yeon_hi/screen/login/password_enter_screen.dart';
import '../utils.dart';
import 'home/home_screen_set3.dart';
import '../model/enums.dart';
import '../model/user_model.dart';
import '../provider/diary_provider.dart';
import '../provider/footprint_provider.dart';
import '../provider/ledger_provider.dart';
import '../provider/tab_page_index_provider.dart';
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
          ChangeNotifierProvider(
              create: (context) => UserModel(
                  userIdx: 0,
                  loginType: 0,
                  userAccount: '',
                  userNickname: '기본닉네임',
                  userBirth: dateToString(DateTime.now()),
                  userProfileImage: 'lib/assets/images/default_profile.png',
                  loverUserIdx: 0,
                  loverNickname: '',
                  homePresetType: 0,
                  topBarType: 0,
                  profileMessage: '',
                  alarmsAllow: false,
                  topBarActivate: false,
                  userState: 0,
                  loveDday: dateToString(DateTime.now()),
                  appLockState: 0
              )),
          ChangeNotifierProvider(create: (context) => DiaryProvider()),
          ChangeNotifierProvider(create: (context) => FootprintProvider()),
          ChangeNotifierProvider(create: (context) => LedgerProvider()),
          ChangeNotifierProvider(
              create: (context) => FootPrintSlidableProvider()),
          ChangeNotifierProvider(
              create: (context) => FootPrintDatePlanSlidableProvider()),
          ChangeNotifierProvider(
              create: (context) => FootprintDraggableSheetProvider()),
          ChangeNotifierProvider(create: (_) => TabPageIndexProvider()),
        ],
        child: MaterialApp(
          title: "WooYeonHi",
          theme: ThemeData(
              colorScheme: const ColorScheme(
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
                selectionHandleColor: ColorFamily.black,
              ),
              highlightColor: ColorFamily.gray,
              splashColor: ColorFamily.gray,
              useMaterial3: true),
          debugShowCheckedModeBanner: false,
          home: const DefaultTabController(
            initialIndex: 2,
            length: 5,
            child: Scaffold(
              backgroundColor: ColorFamily.white,
              bottomNavigationBar: MainBottomNavigationBar(),
              body: MainScreenContainer(),
            ),
          ),
        ));
  }
}
