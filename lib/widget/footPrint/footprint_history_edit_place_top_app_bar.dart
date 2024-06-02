import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../style/color.dart';
import '../../style/text_style.dart';

class FootprintHistoryEditPlaceTopAppBar extends StatefulWidget implements PreferredSizeWidget {
  const FootprintHistoryEditPlaceTopAppBar({super.key});

  @override
  State<FootprintHistoryEditPlaceTopAppBar> createState() => _FootprintHistoryEditPlaceTopAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _FootprintHistoryEditPlaceTopAppBarState extends State<FootprintHistoryEditPlaceTopAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: ColorFamily.cream,
      backgroundColor: ColorFamily.cream,
      centerTitle: true,
      title: const Text(
        "지역 선택",
        style: TextStyleFamily.appBarTitleLightTextStyle,
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: SvgPicture.asset('lib/assets/icons/arrow_back.svg'),
      ),
    );
  }
}
