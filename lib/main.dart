import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:woo_yeon_hi/routes/routes_generator.dart';
import 'package:woo_yeon_hi/screen/register/register_screen.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env"); // .env 환경변수 파일 로드
  KakaoSdk.init(
    nativeAppKey: dotenv.env['KAKAO_NATIVE_APP_KEY'],
    javaScriptAppKey: dotenv.env['KAKAO_JAVA_SCRIPT_APP_KEY'],
  );
  await NaverMapSdk.instance.initialize(
    clientId: dotenv.env['NAVER_CLIENT_ID'],
    onAuthFailed: (ex){
      print(ex);
    }
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
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
      debugShowCheckedModeBanner: false,
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
          useMaterial3: true
      ),
      home: const RegisterScreen(),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
