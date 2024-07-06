import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/dao/more_dao.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/text_style.dart';

import '../../provider/login_register_provider.dart';
import '../../provider/more_provider.dart';

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
    return Consumer2<UserProvider, AuthCodeProvider>(
        builder: (context, userProvider, authCodeProvider, child) {
      return AppBar(
        surfaceTintColor: ColorFamily.cream,
        backgroundColor: ColorFamily.cream,
        centerTitle: true,
        title: const Text(
          "앱 잠금 초기화", style: TextStyleFamily.appBarTitleLightTextStyle,),
        leading: IconButton(
          onPressed: () async {
            await deleteAuthCodeData(userProvider.userIdx);
            FocusScope.of(context).unfocus();
            await Future.delayed(const Duration(milliseconds: 200), () {
              Navigator.pop(context);
            });
            authCodeProvider.setIsAuthCodeGenerated(false);
          },
          icon: SvgPicture.asset('lib/assets/icons/arrow_back.svg'),
        ),
      );
    });}
}