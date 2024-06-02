import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:woo_yeon_hi/screen/footPrint/footprint_history_screen.dart';

import '../../style/color.dart';
import '../../style/text_style.dart';

class FootprintPhotoMapDetailTopappBar extends StatefulWidget implements PreferredSizeWidget{
  const FootprintPhotoMapDetailTopappBar({super.key});

  @override
  State<FootprintPhotoMapDetailTopappBar> createState() => _FootprintPhotoMapDetailTopappBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _FootprintPhotoMapDetailTopappBarState extends State<FootprintPhotoMapDetailTopappBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: ColorFamily.cream,
      backgroundColor: ColorFamily.cream,
      centerTitle: true,
      title: const Text(
        "우리의 기록들(포토맵 제목)",
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
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const FootprintHistoryScreen()));
          },
          icon: SvgPicture.asset('lib/assets/icons/list.svg'),
        ),
      ],
    );
  }
}
