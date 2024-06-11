import 'package:flutter/material.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';

class HomeTopAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeTopAppBar({super.key});

  @override
  State<HomeTopAppBar> createState() => _HomeTopAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _HomeTopAppBarState extends State<HomeTopAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: ColorFamily.cream,
      backgroundColor: ColorFamily.cream,
      centerTitle: true,
      title: Text('우연히'),
      titleTextStyle: TextStyle(
        fontFamily: FontFamily.cafe24Moyamoya,
        fontSize: 40,
        color: ColorFamily.pink
      ),
    );
  }
}
