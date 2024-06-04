import 'package:flutter/material.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/text_style.dart';

class DiaryTopAppBar extends StatefulWidget implements PreferredSizeWidget{
  const DiaryTopAppBar({super.key});

  @override
  State<DiaryTopAppBar> createState() => _DiaryTopAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _DiaryTopAppBarState extends State<DiaryTopAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: ColorFamily.cream,
      backgroundColor: ColorFamily.cream,
      centerTitle: true,
      title: const Text("교환일기", style: TextStyleFamily.appBarTitleBoldTextStyle,),
    );
  }
}
