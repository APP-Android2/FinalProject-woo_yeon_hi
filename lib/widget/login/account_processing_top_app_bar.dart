import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/text_style.dart';

class AccountProcessingTopAppBar extends StatefulWidget implements PreferredSizeWidget {
  const AccountProcessingTopAppBar({super.key});

  @override
  State<AccountProcessingTopAppBar> createState() => _AccountProcessingTopAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AccountProcessingTopAppBarState extends State<AccountProcessingTopAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        surfaceTintColor: ColorFamily.cream,
        backgroundColor: ColorFamily.cream,
        centerTitle: true,
        title: const Text(
          "계정 처리",
          style: TextStyleFamily.appBarTitleLightTextStyle,
        ),
    );
  }
}