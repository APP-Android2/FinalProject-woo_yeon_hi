import 'package:flutter/material.dart';
import 'package:woo_yeon_hi/screen/main_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';
import 'package:woo_yeon_hi/style/font.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  KakaoSdk.init(
    nativeAppKey: '62a1ea96953fba93f6d4e5b355e2d455',
    javaScriptAppKey: '71b46fb5f5a68ad3d8aaa257ffa704fa',
  );

  initializeDateFormatting().then((_) => runApp(WooYeonHi()));

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
      home: MainScreen(),

    );
  }
}
