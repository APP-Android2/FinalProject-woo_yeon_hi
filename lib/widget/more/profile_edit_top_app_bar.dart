import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/text_style.dart';

class ProfileEditTopAppBar extends StatefulWidget implements PreferredSizeWidget {
  const ProfileEditTopAppBar({super.key});

  @override
  State<ProfileEditTopAppBar> createState() => _ProfileEditTopAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _ProfileEditTopAppBarState extends State<ProfileEditTopAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: ColorFamily.cream,
      backgroundColor: ColorFamily.cream,
      centerTitle: true,
      title: const Text(
        "프로필 관리",
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
              Navigator.pop(context);
            },
            icon: SvgPicture.asset('lib/assets/icons/done.svg'))
      ],
    );
  }
}