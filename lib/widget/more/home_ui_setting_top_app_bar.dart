import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/text_style.dart';

class HomeUiSettingTopAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeUiSettingTopAppBar({super.key});

  @override
  State<HomeUiSettingTopAppBar> createState() => _HomeUiSettingTopAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HomeUiSettingTopAppBarState extends State<HomeUiSettingTopAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: ColorFamily.cream,
      backgroundColor: ColorFamily.cream,
      centerTitle: true,
      title: const Text(
        "홈 화면 스타일",
        style: TextStyleFamily.appBarTitleLightTextStyle,
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: SvgPicture.asset('lib/assets/icons/arrow_back.svg'),
      ),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset('lib/assets/icons/done.svg'))
      ],
    );
  }
}