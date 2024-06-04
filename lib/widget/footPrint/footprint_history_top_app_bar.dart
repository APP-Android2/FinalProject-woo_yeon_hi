import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:woo_yeon_hi/screen/footPrint/footprint_photo_map_detail_screen.dart';

import '../../style/color.dart';
import '../../style/text_style.dart';

class FootprintHistoryTopAppBar extends StatefulWidget implements PreferredSizeWidget{
  const FootprintHistoryTopAppBar({super.key});

  @override
  State<FootprintHistoryTopAppBar> createState() => _FootprintHistoryTopAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _FootprintHistoryTopAppBarState extends State<FootprintHistoryTopAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: ColorFamily.cream,
      backgroundColor: ColorFamily.cream,
      centerTitle: true,
      title: const Text(
        "히스토리",
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
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const FootprintPhotoMapDetailScreen()));
          },
          icon: SvgPicture.asset('lib/assets/icons/map.svg'),
        ),
      ],
    );
  }
}
