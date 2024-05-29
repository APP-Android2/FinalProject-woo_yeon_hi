import 'package:flutter/material.dart';
import 'package:woo_yeon_hi/provider/tab_page_index_provider.dart';
import 'package:woo_yeon_hi/provider/user_control_provider.dart';
import 'package:woo_yeon_hi/routes/routes_generator.dart';
import 'package:woo_yeon_hi/screen/register/register_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';
import 'package:woo_yeon_hi/widget/login/kakao_login.dart';
import 'package:woo_yeon_hi/widget/register/google_sign_in.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  KakaoSdk.init(
    nativeAppKey: '62a1ea96953fba93f6d4e5b355e2d455',
    javaScriptAppKey: '71b46fb5f5a68ad3d8aaa257ffa704fa',
  );

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
      home: RegisterScreen(),

      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

