import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/text_style.dart';

class HelpTopAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HelpTopAppBar({super.key});

  @override
  State<HelpTopAppBar> createState() => _HelpTopAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HelpTopAppBarState extends State<HelpTopAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        surfaceTintColor: ColorFamily.cream,
        backgroundColor: ColorFamily.cream,
        centerTitle: true,
        title: const Text(
          "도움말",
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