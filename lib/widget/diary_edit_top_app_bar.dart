import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/text_style.dart';

class DiaryEditTopAppBar extends StatefulWidget implements PreferredSizeWidget{
  const DiaryEditTopAppBar({super.key});

  @override
  State<DiaryEditTopAppBar> createState() => _DiaryEditTopAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _DiaryEditTopAppBarState extends State<DiaryEditTopAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: ColorFamily.cream,
      backgroundColor: ColorFamily.cream,
      centerTitle: true,
      title: const Text("일기", style: TextStyleFamily.appBarTitleLightTextStyle,),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: SvgPicture.asset('lib/assets/icons/arrow_back.svg'),
      ),
      actions: [
        IconButton(
            onPressed: (){

            },
            icon: SvgPicture.asset('lib/assets/icons/done.svg')
        )
      ],
    );
  }
}
