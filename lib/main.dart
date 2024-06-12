import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:woo_yeon_hi/provider/tab_page_index_provider.dart';
import 'package:woo_yeon_hi/screen/login/password_enter_screen.dart';
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
import 'package:woo_yeon_hi/utils.dart';

import 'dao/user_dao.dart';
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
      onAuthFailed: (ex) {
        print(ex);
      });
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  String userAccount =
      (await const FlutterSecureStorage().read(key: "loginAccount")) ?? "";
  String appLockState =
      (await const FlutterSecureStorage().read(key: "appLockState")) ?? "0";
 int userState = await getSpecificUserData(userAccount, 'user_state')?? 2;

  initializeDateFormatting().then((_) async {

    if(appLockState == "0"){
      runApp(const MainScreen());
    }else{
      runApp(WooYeonHi(userAccount: userAccount, appLockState: appLockState, userState: userState));
    }
  });
}

class WooYeonHi extends StatefulWidget {
  WooYeonHi(
      {super.key,
      required this.userAccount,
      required this.appLockState,
      required this.userState});

  String userAccount;
  String appLockState;
  int userState;

  @override
  State<WooYeonHi> createState() => _WooYeonHiState();
}

class _WooYeonHiState extends State<WooYeonHi> {
  @override
  build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => UserModel(
            userIdx: 0,
            loginType: 0,
            userAccount: '',
            userNickname: '',
            userBirth: dateToString(DateTime.now()),
            userProfileImage: '',
            loverUserIdx: 0,
            loverNickname: '',
            homePresetType: 0,
            topBarType: 0,
            profileMessage: '',
            alarmsAllow: false,
            topBarActivate: false,
            userState: 2,
            loveDday: dateToString(DateTime.now())),
        child: MaterialApp(
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
              useMaterial3: true),
          home: widget.userAccount == ""
              ? const LoginScreen()
              : widget.userState == 1
                  ? const LoginScreen()
                  : widget.appLockState == "0"
                      ? const MainScreen()
                      : const PasswordEnterScreen(),
          onGenerateRoute: RouteGenerator.generateRoute,
        ));
  }
}
