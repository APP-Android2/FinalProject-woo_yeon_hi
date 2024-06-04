import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/provider/footprint_provider.dart';
import 'package:woo_yeon_hi/screen/footPrint/footprint_date_plan_detail_screen.dart';

class FootprintDatePlanDraggableSheet extends StatefulWidget {
  const FootprintDatePlanDraggableSheet({super.key});

  @override
  State<FootprintDatePlanDraggableSheet> createState() => _FootprintDatePlanDraggableSheetState();
}

class _FootprintDatePlanDraggableSheetState extends State<FootprintDatePlanDraggableSheet> {

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Consumer<FootprintDraggableSheetProvider>(
          builder: (context, provider, child) {
            return DraggableScrollableSheet(
              key: provider.sheetKey,
              // 기본
              initialChildSize: 0.4,
              // 최대
              maxChildSize: 1,
              // 최소
              minChildSize: 0,
              expand: true,
              snap: true,
              snapSizes: [30 / constraints.maxHeight, 0.4],
              controller: provider.controller,
              builder: (BuildContext context, ScrollController scrollController) {
                return DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child: CustomScrollView(
                    controller: scrollController,
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.all(10),
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
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                final item = provider.items[index];
                                return Container(
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('$index'),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(item),
                                                SizedBox(height: 10),
                                                Text('맛집 메모: https://naver.googlecom.comcmo'),
                                              ],
                                            ),
                                            IconButton(
                                              icon: SvgPicture.asset('lib/assets/icons/menu.svg'),
                                              onPressed: () {
                                                // 임시 상세페이지 이동
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) => const FootprintDatePlanDetailScreen(),
                                                    )
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(height: 0),
                                    ],
                                  ),
                                );
                              },
                          // 시트에 있는 데이터 항목 수
                          childCount: provider.items.length,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}