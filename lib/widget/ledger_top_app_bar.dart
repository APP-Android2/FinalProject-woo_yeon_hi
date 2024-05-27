import 'package:flutter/material.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';

class LedgerTopAppBar extends StatefulWidget implements PreferredSizeWidget {
  const LedgerTopAppBar({super.key});

  @override
  State<LedgerTopAppBar> createState() => _LedgerTopAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _LedgerTopAppBarState extends State<LedgerTopAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorFamily.cream,
      title: Text('가계부', style: TextStyle(fontSize: 20,fontFamily: FontFamily.mapleStoryBold)),
      centerTitle: true,
    );
  }
}
