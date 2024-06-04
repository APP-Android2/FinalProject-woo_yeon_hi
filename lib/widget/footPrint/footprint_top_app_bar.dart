import 'package:flutter/material.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/text_style.dart';

class FootprintTopAppBar extends StatefulWidget implements PreferredSizeWidget{
  const FootprintTopAppBar({super.key});

  @override
  State<FootprintTopAppBar> createState() => _FootprintTopAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _FootprintTopAppBarState extends State<FootprintTopAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: ColorFamily.cream,
      backgroundColor: ColorFamily.cream,
      centerTitle: true,
      title: const Text("발자국", style: TextStyleFamily.appBarTitleBoldTextStyle,),
    );
  }
}
