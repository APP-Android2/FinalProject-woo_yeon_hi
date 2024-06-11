import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:woo_yeon_hi/screen/footPrint/footprint_history_screen.dart';

import '../../screen/footPrint/footprint_photo_map_detail_screen.dart';
import '../../style/color.dart';
import '../../style/text_style.dart';

class FootprintPhotoMapDetailTopappBar extends StatefulWidget implements PreferredSizeWidget{
  FootprintPhotoMapDetailTopappBar(this.globalkey, this.mapIdx, this.mapName, {super.key});
  GlobalKey globalkey;
  int mapIdx;
  String mapName;
  int userIdx = 0;

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
      title: Text(
        widget.mapName,
        style: TextStyleFamily.appBarTitleLightTextStyle,
      ),
      leading: IconButton(
        onPressed: () {
          // 스냅샷 저장
          FootprintPhotoMapDetailScreen.capture(widget.globalkey, widget.userIdx, widget.mapIdx);
          Navigator.pop(context);
        },
        icon: SvgPicture.asset('lib/assets/icons/arrow_back.svg'),
      ),
      actions: [
        IconButton(
          onPressed: () {
            // 스냅샷 저장
            FootprintPhotoMapDetailScreen.capture(widget.globalkey, widget.userIdx, widget.mapIdx);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FootprintHistoryScreen(widget.userIdx, widget.mapIdx, widget.mapName)));
          },
          icon: SvgPicture.asset('lib/assets/icons/list.svg'),
        ),
      ],
    );
  }
}
