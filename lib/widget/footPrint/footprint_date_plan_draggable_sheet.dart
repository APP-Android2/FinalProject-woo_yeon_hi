import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/provider/footprint_provider.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/widget/footPrint/footprint_date_plan_sheet_header.dart';

class FootprintDatePlanDraggableSheet extends StatefulWidget {
  const FootprintDatePlanDraggableSheet({super.key});

  @override
  State<FootprintDatePlanDraggableSheet> createState() => _FootprintDatePlanDraggableSheetState();
}

class _FootprintDatePlanDraggableSheetState extends State<FootprintDatePlanDraggableSheet> {
  // sheet 키
  final _sheet = GlobalKey();
  final _controller = DraggableScrollableController();

  @override
  void initState() {
    super.initState();
    // 시트가 사라지는 것을 방지.
    _controller.addListener(_onChanged);
  }

  void _onChanged() {
    final currentSize = _controller.size;
    if (currentSize <= 0.03) _collapse();
  }

  void _collapse() => _animateSheet(sheet.snapSizes!.first);
  void _anchor() => _animateSheet(sheet.snapSizes!.last);
  void _expand() => _animateSheet(sheet.maxChildSize);
  void _hide() => _animateSheet(sheet.minChildSize);

  void _animateSheet(double size) {
    _controller.animateTo(
      size,
      duration: const Duration(milliseconds: 50),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  DraggableScrollableSheet get sheet => (_sheet.currentWidget as DraggableScrollableSheet);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Consumer<FootprintDraggableSheetProvider>(
          builder: (context, provider, child) {
            return DraggableScrollableSheet(
              key: _sheet,
              // 기본
              initialChildSize: 0.05,
              // 최대
              maxChildSize: 0.9,
              // 최소
              minChildSize: 0,
              expand: true,
              snap: true,
              snapSizes: [30 / constraints.maxHeight, 0.4],
              controller: _controller,
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
                      // 슬라이더 상단 헤더
                      const SliverPersistentHeader(
                        delegate: FootprintDatePlanSheetHeader(),
                        pinned: true,
                        // floating : false
                      ),

                      // 슬라이더 내용
                      SliverReorderableList(
                        onReorder: (int oldIndex, int newIndex) {
                          provider.reorderItems(oldIndex, newIndex);
                        },
                        itemCount: provider.items.length,
                        itemBuilder: (BuildContext context, int index) {
                          final item = provider.items[index];
                          return Container(
                            key: ValueKey(item),
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
                                      // 버튼 클릭 시 항목 이동.
                                      ReorderableDelayedDragStartListener(
                                        index: index,
                                        child: IconButton(
                                          icon: SvgPicture.asset('lib/assets/icons/menu.svg'),
                                          onPressed: () {},
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(height: 30,color: ColorFamily.gray,),
                              ],
                            ),
                          );
                        },
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