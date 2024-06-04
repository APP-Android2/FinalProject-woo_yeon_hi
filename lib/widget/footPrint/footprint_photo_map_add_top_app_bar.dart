import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/text_style.dart';

class FootprintPhotoMapAddTopAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  const FootprintPhotoMapAddTopAppBar({super.key});

  @override
  State<FootprintPhotoMapAddTopAppBar> createState() =>
      _FootprintPhotoMapAddTopAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _FootprintPhotoMapAddTopAppBarState
    extends State<FootprintPhotoMapAddTopAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: ColorFamily.cream,
      backgroundColor: ColorFamily.cream,
      centerTitle: true,
      title: const Text(
        "지도 추가",
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
