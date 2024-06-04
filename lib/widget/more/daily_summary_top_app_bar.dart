import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/text_style.dart';

class DailySummaryTopAppBar extends StatefulWidget implements PreferredSizeWidget{
  const DailySummaryTopAppBar({super.key});

  @override
  State<DailySummaryTopAppBar> createState() => _DailySummaryTopAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _DailySummaryTopAppBarState extends State<DailySummaryTopAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: ColorFamily.cream,
      backgroundColor: ColorFamily.cream,
      centerTitle: true,
      title: const Text("활동 모아보기", style: TextStyleFamily.appBarTitleLightTextStyle,),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: SvgPicture.asset('lib/assets/icons/arrow_back.svg'),
      ),
    );
  }
}