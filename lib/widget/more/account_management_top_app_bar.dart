import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/text_style.dart';

class AccountManagementTopAppBar extends StatefulWidget implements PreferredSizeWidget {
  const AccountManagementTopAppBar({super.key});

  @override
  State<AccountManagementTopAppBar> createState() => _AccountManagementTopAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AccountManagementTopAppBarState extends State<AccountManagementTopAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        surfaceTintColor: ColorFamily.cream,
        backgroundColor: ColorFamily.cream,
        centerTitle: true,
        title: const Text(
          "계정 관리",
          style: TextStyleFamily.appBarTitleLightTextStyle,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset('lib/assets/icons/arrow_back.svg'),
        )
    );
  }
}