import 'package:flutter/material.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/text_style.dart';

class MoreTopAppBar extends StatefulWidget implements PreferredSizeWidget{
  const MoreTopAppBar({super.key});

  @override
  State<MoreTopAppBar> createState() => _MoreTopAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MoreTopAppBarState extends State<MoreTopAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: ColorFamily.cream,
      backgroundColor: ColorFamily.cream,
      centerTitle: true,
      title: const Text("더 보기", style: TextStyleFamily.appBarTitleBoldTextStyle,),
    );
  }
}