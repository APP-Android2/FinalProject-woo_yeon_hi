import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/style/text_style.dart';

class LedgerTopAppBar extends StatefulWidget implements PreferredSizeWidget {

  final String title;
  final List<Widget> actions;
  final Widget? leading;

  const LedgerTopAppBar({required this.title, this.actions = const [], this.leading, super.key});

  @override
  State<LedgerTopAppBar> createState() => _LedgerTopAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _LedgerTopAppBarState extends State<LedgerTopAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: ColorFamily.cream,
      backgroundColor: ColorFamily.cream,
      centerTitle: true,
      title: Text(widget.title, style: widget.title == '가계부' ? TextStyleFamily.appBarTitleBoldTextStyle : TextStyleFamily.appBarTitleLightTextStyle),
      actions: widget.actions,
      leading: widget.leading,
    );
  }
}
