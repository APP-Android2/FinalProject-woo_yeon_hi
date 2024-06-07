import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/provider/footprint_provider.dart';
import 'package:woo_yeon_hi/screen/footPrint/footprint_date_plan_write_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/widget/footPrint/footprint_date_plan_slidable_action.dart';

class FootprintDatePlanScreen extends StatefulWidget {
  const FootprintDatePlanScreen({super.key});

  @override
  State<FootprintDatePlanScreen> createState() => _FootprintDatePlanScreenState();
}

class _FootprintDatePlanScreenState extends State<FootprintDatePlanScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FootPrintSlidableProvider>(
      builder: (context, provider, child) {
        return ListView.builder(
          itemCount: provider.items.length,
          itemBuilder: (context, index) {
            final item = provider.items[index];
            return Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              decoration: BoxDecoration(
                color: ColorFamily.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    spreadRadius: 0,
                    blurRadius: 2,
                    // 그림자 위치 설정
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Slidable(
                    key: ValueKey(index),
                    startActionPane: ActionPane(
                      motion: ScrollMotion(),
                      // 슬라이드 액션의 크기 축소
                      extentRatio: 0.3,
                      children: [
                        // 커스텀 SlidableAction
                        FootprintDatePlanSlidableAction(
                          onPressed: (context) {
                            provider.toggleCompleteItem(index);
                            Slidable.of(context)?.close();
                          },
                          backgroundColor: ColorFamily.green,
                          foregroundColor: ColorFamily.black,
                          label: item.isCompleted ? '완료 해제' : '완료',
                          textStyle: const TextStyle(fontSize: 14, fontFamily: FontFamily.mapleStoryLight),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15)
                          ),
                            offset1: 3,
                            offset2: 3,
                        ),
                      ],
                    ),
                    endActionPane: ActionPane(
                      motion: ScrollMotion(),
                      extentRatio: 0.28,
                      children: [
                        // 커스텀 SlidableAction
                        FootprintDatePlanSlidableAction(
                          onPressed: (context) {
                            provider.removeItem(index);
                            Slidable.of(context)?.close();

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('삭제 되었습니다.'),
                              ),
                            );
                          },
                          backgroundColor: ColorFamily.pink,
                          foregroundColor: ColorFamily.black,
                          label: '삭제',
                          textStyle: const TextStyle(fontSize: 14, fontFamily: FontFamily.mapleStoryLight),
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15)
                          ),
                        ),
                      ],
                    ),
                    // 각 아이템을 위한 설정
                    child: makeListView(item),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // 항목 아이템
  Widget makeListView(Item item){
    return Consumer<FootPrintSlidableProvider>(
      builder: (context, provider, child) {
        return Container(
          decoration: BoxDecoration(
            color: ColorFamily.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const FootprintDatePlanWriteScreen(),
                              )
                          );
                        },
                        child: Row(
                          children: [
                            // 좌측에 초록색 박스
                            SizedBox(
                              width: 4,
                              height: 75,
                              child: Container(color: ColorFamily.green),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // 제목과 부제목
                                    Text(item.title, style: const TextStyle(fontSize: 14, fontFamily: FontFamily.mapleStoryLight)),
                                    const SizedBox(height: 6),
                                    const Text('2024. 6. 13(수) - 2024. 6. 17(월)', style: TextStyle(fontSize: 12, fontFamily: FontFamily.mapleStoryLight)),
                                    const SizedBox(height: 4),
                                    Container(
                                      child: const Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          // 작성자 표시
                                          Text('2024. 5. 17', style: TextStyle(fontSize: 12, fontFamily: FontFamily.mapleStoryLight)),
                                          SizedBox(width: 8),
                                          Text('작성 by 우연남', style: TextStyle(fontSize: 12, fontFamily: FontFamily.mapleStoryLight)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // 완료된 항목 스타일
                if (item.isCompleted) ...[
                  // 반투명 색상을 표시 할 컨테이너
                  Container(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: double.maxFinite,
                          height: 80,
                          // 반투명도 설정
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ],
                    ),
                  ),
                  // 이미지를 표시 할 컨테이너
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 15, 25, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          // 화면 폭의 30% 크기로 설정
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: 60,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('lib/assets/images/footprint_stamp.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),

                  ),
                ],

              ],
            ),
        );
      },
    );
  }



}
