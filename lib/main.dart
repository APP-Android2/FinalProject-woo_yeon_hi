import 'package:flutter/material.dart';
import 'package:woo_yeon_hi/provider/tab_page_index_provider.dart';
import 'package:woo_yeon_hi/routes/routes_generator.dart';
import 'package:woo_yeon_hi/screen/register/register_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {

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
      home: const DefaultTabController(
        initialIndex: 2,
        length: 5,
        child: Scaffold(
          body: RegisterScreen(),
        ),
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

