import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../style/color.dart';
import '../../style/text_style.dart';

class FootprintHistoryEditTopAppBar extends StatefulWidget implements PreferredSizeWidget{
  const FootprintHistoryEditTopAppBar({super.key});

  @override
  State<FootprintHistoryEditTopAppBar> createState() => _FootprintHistoryEditTopAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _FootprintHistoryEditTopAppBarState extends State<FootprintHistoryEditTopAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: ColorFamily.cream,
      backgroundColor: ColorFamily.cream,
      centerTitle: true,
      title: const Text(
        "히스토리 작성",
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
            onPressed: (){
              Navigator.pop(context);
            }, 
            icon: SvgPicture.asset('lib/assets/icons/done.svg')
        )
      ],
    );
  }
}
