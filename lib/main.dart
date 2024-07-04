import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:woo_yeon_hi/provider/login_register_provider.dart';
import 'package:woo_yeon_hi/provider/more_provider.dart';
import 'package:woo_yeon_hi/screen/login/password_enter_screen.dart';
import 'package:woo_yeon_hi/screen/main_screen.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/routes/routes_generator.dart';
import 'package:woo_yeon_hi/screen/login/login_screen.dart';
import 'package:woo_yeon_hi/utils.dart';

import 'firebase_options.dart';

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

  initializeDateFormatting().then((_) async {
    final userData = await fetchUserData();

    runApp(MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => UserProvider())
        ],
        child: WooYeonHi(
          userIdx: userData['userIdx'],
          userAccount: userData['userAccount'],
          alarmsAllow: userData['alarmsAllow'],
          appLockState: userData['appLockState'],
          homePresetType: userData['homePresetType'],
          loginType: userData['loginType'],
          loveDday: userData['loveDday'],
          loverIdx: userData['loverIdx'],
          profileMessage: userData['profileMessage'],
          topBarActivate: userData['topBarActivate'],
          topBarType: userData['topBarType'],
          userBirth: userData['userBirth'],
          userNickname: userData['userNickname'],
          userProfileImage: userData['userProfileImage'],
          userState: userData['userState'],
        )));
  });
}

class WooYeonHi extends StatefulWidget {
  WooYeonHi(
      {super.key,
      required this.userIdx,
      required this.userAccount,
      required this.alarmsAllow,
      required this.appLockState,
      required this.homePresetType,
      required this.loginType,
      required this.loveDday,
      required this.loverIdx,
      required this.profileMessage,
      required this.topBarActivate,
      required this.topBarType,
      required this.userBirth,
      required this.userNickname,
      required this.userProfileImage,
      required this.userState});

  final int userIdx;
  final String userAccount;
  final bool alarmsAllow;
  final int appLockState;
  final int homePresetType;
  final int loginType;
  final String loveDday;
  final int loverIdx;
  final String profileMessage;
  final bool topBarActivate;
  final int topBarType;
  final String userBirth;
  final String userNickname;
  final String userProfileImage;
  final int userState;

  @override
  State<WooYeonHi> createState() => _WooYeonHiState();
}

class _WooYeonHiState extends State<WooYeonHi> {
  @override
  build(BuildContext context) {

    Provider.of<UserProvider>(context, listen: false).setUserAllData(widget.userIdx, widget.userAccount, widget.alarmsAllow, widget.appLockState, widget.homePresetType, widget.loginType, widget.loveDday, widget.loverIdx, widget.profileMessage, widget.topBarActivate, widget.topBarType, widget.userBirth, widget.userNickname, widget.userProfileImage, widget.userState);

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => CalendarProvider()),
          ChangeNotifierProvider(create: (context) => PasswordProvider()),
        ],
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
          home: widget.userIdx == 0
              ? const LoginScreen()
              : widget.userState == 1
                  ? const LoginScreen()
                  : widget.appLockState == 0
                      ? const MainScreen()
                      : const PasswordEnterScreen(),
          onGenerateRoute: RouteGenerator.generateRoute,
        ));
  }
}
