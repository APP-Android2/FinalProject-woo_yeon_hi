import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:woo_yeon_hi/screen/footPrint/footprint_photo_map_detail_screen.dart';

import '../../style/color.dart';
import '../../style/text_style.dart';

class FootprintHistoryTopAppBar extends StatefulWidget implements PreferredSizeWidget{
  FootprintHistoryTopAppBar(this.mapIdx, this.mapName, {super.key});
  int mapIdx;
  String mapName;
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
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FootprintPhotoMapDetailScreen(widget.mapIdx, widget.mapName)));
          },
          icon: SvgPicture.asset('lib/assets/icons/map.svg'),
        ),
      ],
    );
  }
}
