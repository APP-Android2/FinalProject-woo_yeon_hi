import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:woo_yeon_hi/provider/ledger_carousel_provider.dart';
import 'package:woo_yeon_hi/provider/ledger_check_box_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:woo_yeon_hi/provider/diary_provider.dart';
import 'package:woo_yeon_hi/provider/footprint_provider.dart';
import 'package:woo_yeon_hi/provider/tab_page_index_provider.dart';
import 'package:woo_yeon_hi/screen/main_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/widget/main_bottom_navigation_bar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env"); // .env 환경변수 파일 로드
  await NaverMapSdk.instance.initialize(
    clientId: dotenv.env['NAVER_CLIENT_ID'],
    onAuthFailed: (ex){
      print(ex);
    }
  );
  // ko_KR 언어 설정을 위함
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
          ChangeNotifierProvider(create: (context) => FootprintDraggableSheetProvider()),
          ChangeNotifierProvider(create: (_) => TabPageIndexProvider()),
          ChangeNotifierProvider(create: (_) => LedgerCheckBoxProvider()),
          ChangeNotifierProvider(create: (_) => LedgerCarouselProvider()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
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
                body: MainScreen(),
              ),
            )));
  }
}
