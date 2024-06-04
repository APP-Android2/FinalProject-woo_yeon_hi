import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/text_style.dart';

import '../../provider/footprint_provider.dart';

class FootprintTabBar extends StatefulWidget {
  const FootprintTabBar({super.key});

  @override
  State<FootprintTabBar> createState() => _FootprintTabBarState();
}

class _FootprintTabBarState extends State<FootprintTabBar> {
  @override
  Widget build(BuildContext context) {
    var footprintProvider =
        Provider.of<FootprintProvider>(context, listen: false);
    return TabBar(
      dividerHeight: 0,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorColor: ColorFamily.pink,
      overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
      labelColor: ColorFamily.black,
      labelStyle: TextStyleFamily.normalTextStyle,
      unselectedLabelColor: ColorFamily.black,
      unselectedLabelStyle: TextStyleFamily.normalTextStyle,

      tabs: const [
        Tab(
          text: "포토맵",
        ),
        Tab(
          text: "데이트플랜",
        )
      ],
      onTap: (value) {
        if(mounted){
          setState(() {
            footprintProvider.setCurrentPageIndex(value);
          });
        }
      },
    );
  }
}
