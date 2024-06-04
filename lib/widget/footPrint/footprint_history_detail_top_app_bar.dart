import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../style/color.dart';
import '../../style/text_style.dart';

class FootprintHistoryDetailTopAppBar extends StatefulWidget implements PreferredSizeWidget{
  const FootprintHistoryDetailTopAppBar(this.title, {super.key});
  final String title;

  @override
  State<FootprintHistoryDetailTopAppBar> createState() => _FootprintHistoryDetailTopAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _FootprintHistoryDetailTopAppBarState extends State<FootprintHistoryDetailTopAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: ColorFamily.cream,
      backgroundColor: ColorFamily.cream,
      centerTitle: true,
      title: Text(
        widget.title,
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
