import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/text_style.dart';

class AccountDeleteTopAppBar extends StatefulWidget implements PreferredSizeWidget {
  const AccountDeleteTopAppBar({super.key});

  @override
  State<AccountDeleteTopAppBar> createState() => _AccountDeleteTopAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AccountDeleteTopAppBarState extends State<AccountDeleteTopAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        surfaceTintColor: ColorFamily.cream,
        backgroundColor: ColorFamily.cream,
        centerTitle: true,
        title: const Text(
          "계정 삭제",
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