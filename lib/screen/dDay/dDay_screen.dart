import 'package:flutter/material.dart';
import 'package:woo_yeon_hi/style/color.dart';

import '../../widget/dDay/dDay_list_view.dart';
import '../../widget/dDay/dDay_top_app_bar.dart';

class dDayScreen extends StatefulWidget {
  const dDayScreen({super.key});

  @override
  State<dDayScreen> createState() => _dDayScreenState();
}

class _dDayScreenState extends State<dDayScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorFamily.cream,
      appBar: dDayTopAppBar(),
      body: dDayListView(),
    );
  }
}



