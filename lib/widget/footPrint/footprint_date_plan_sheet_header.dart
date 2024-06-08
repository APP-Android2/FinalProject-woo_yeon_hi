import 'package:flutter/material.dart';

class FootprintDatePlanSheetHeader extends SliverPersistentHeaderDelegate {
  const FootprintDatePlanSheetHeader();

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
          children: [
            Container(
              width: 32,
              height: 4,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(15)
              ),
            )
          ]
      ),
    );
  }

  // 헤더의 크기 조절?
  @override
  double get maxExtent => 30;

  @override
  double get minExtent => 30;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}