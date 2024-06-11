import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/text_style.dart';

class PasswordResetTopAppBar extends StatefulWidget implements PreferredSizeWidget{
  const PasswordResetTopAppBar({super.key});

  @override
  State<PasswordResetTopAppBar> createState() => _PasswordResetTopAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _PasswordResetTopAppBarState extends State<PasswordResetTopAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: ColorFamily.cream,
      backgroundColor: ColorFamily.cream,
      centerTitle: true,
      title: const Text("앱 잠금 초기화", style: TextStyleFamily.appBarTitleLightTextStyle,),
      leading: IconButton(
        onPressed: () {
          FocusScope.of(context).unfocus();
          Future.delayed(const Duration(milliseconds: 200), () {
            Navigator.pop(context);
          });
        },
        icon: SvgPicture.asset('lib/assets/icons/arrow_back.svg'),
      ),
    );
  }
}