import 'package:flutter/material.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/text_style.dart';

class FootprintDatePlanTopAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;
  final Widget? leading;

  const FootprintDatePlanTopAppBar({required this.title, this.actions = const [], this.leading, super.key});

  @override
  State<FootprintDatePlanTopAppBar> createState() => _FootprintDatePlanTopAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _FootprintDatePlanTopAppBarState extends State<FootprintDatePlanTopAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: ColorFamily.cream,
      backgroundColor: ColorFamily.cream,
      centerTitle: true,
      title: Text(widget.title, style: widget.title == '발자국' ? TextStyleFamily.appBarTitleBoldTextStyle : TextStyleFamily.appBarTitleLightTextStyle),
      actions: widget.actions,
      leading: widget.leading,
    );
  }
}