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
import 'package:intl/date_symbol_data_local.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';
import 'package:woo_yeon_hi/style/font.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env"); // .env 환경변수 파일 로드
  KakaoSdk.init(
    nativeAppKey: '62a1ea96953fba93f6d4e5b355e2d455',
    javaScriptAppKey: '71b46fb5f5a68ad3d8aaa257ffa704fa',
  );
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
    return MaterialApp(
      title: "WooYeonHi",
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: ColorFamily.cream,
              brightness: Brightness.light
          ),
          useMaterial3: true
      ),
      home: MainScreen(),

    );
  }
}
