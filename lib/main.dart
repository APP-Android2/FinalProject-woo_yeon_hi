import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:woo_yeon_hi/provider/tab_page_index_provider.dart';
import 'package:woo_yeon_hi/screen/main_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/model/user_model.dart';
import 'package:woo_yeon_hi/routes/routes_generator.dart';
import 'package:woo_yeon_hi/screen/login/login_screen.dart';

import 'firebase_options.dart';
import 'model/enums.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env"); // .env 환경변수 파일 로드
  KakaoSdk.init(
    nativeAppKey: dotenv.env['KAKAO_NATIVE_APP_KEY'],
  );
  await NaverMapSdk.instance.initialize(
    clientId: dotenv.env['NAVER_MAP_CLIENT_ID'],
    onAuthFailed: (ex){
      print(ex);
    }
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  print(await KakaoSdk.origin);
  // ko_KR 언어 설정을 위함
  initializeDateFormatting().then((_) => runApp(const MainScreen()));
}

class WooYeonHi extends StatefulWidget {
  const WooYeonHi({super.key});

  @override
  State<WooYeonHi> createState() => _WooYeonHiState();
}


class _WooYeonHiState extends State<WooYeonHi> {

  static const storage = FlutterSecureStorage(); //flutter_secure_storage 사용을 위한 초기화 작업
  String userInfo = "";

  @override
  void initState() {
    super.initState();

    //비동기로 flutter secure storage 정보를 불러오는 작업.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }
  _asyncMethod() async {
    //read 함수를 통하여 key값에 맞는 정보를 불러오게 됩니다. 이때 불러오는 결과의 타입은 String 타입임을 기억해야 합니다.
    //(데이터가 없을때는 null을 반환을 합니다.)
    userInfo = (await storage.read(key: "loginData"))!;
    print(userInfo);

    // runApp(const MainScreen(loginData: "현재 로그인 계정 정보"));
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
    create: (context) => UserModel(userIdx: 0, loginType: 0, userAccount: '', userNickname: '', userBirth: DateTime.now(), userProfileImage: '', loverUserIdx: 0, loverNickname: '', homePresetType: 0, topBarType: 0, profileMessage: '', alarmsAllow: false, appLockState: 0, topBarActivate: false, lockPassword: [0, 0, 0, 0], userState: 2, loveDday: DateTime.now()),
    child:
      MaterialApp(
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
      home: const LoginScreen(),
      onGenerateRoute: RouteGenerator.generateRoute,
      ));
  }
}
