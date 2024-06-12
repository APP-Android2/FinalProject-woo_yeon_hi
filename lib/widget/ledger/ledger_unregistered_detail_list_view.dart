import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/provider/ledger_provider.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';

class LedgerUnregisteredDetailListView extends StatefulWidget {
  const LedgerUnregisteredDetailListView({super.key});

  @override
  State<LedgerUnregisteredDetailListView> createState() => _LedgerUnregisteredDetailListViewState();
}

class _LedgerUnregisteredDetailListViewState extends State<LedgerUnregisteredDetailListView> {

  @override
  Widget build(BuildContext context) {

    return Consumer<LedgerCheckBoxProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              // 전체 선택/해제 체크박스와 텍스트
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('5. 17.', style: TextStyle(color: ColorFamily.black, fontSize: 20, fontFamily: FontFamily.mapleStoryBold)),
                  Row(
                    children: [
                      Checkbox(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        side: const BorderSide(color: ColorFamily.gray),
                        activeColor: ColorFamily.pink,
                        checkColor: ColorFamily.white,
                        // 전체 체크박스 상태
                        value: provider.allChecked,
                        // 전체 체크박스 상태 변경 시
                        onChanged: (bool? value) {
                          provider.toggleSelectAll(!provider.allChecked);
                        },
                      ),
                      InkWell(
                        onTap: () {
                          bool allChecked = provider.checkedItems.every((item) => item);
                          // 전체 체크박스 상태 변경 시
                          provider.toggleSelectAll(!allChecked);
                        },
                        child: Text(provider.checkedItems.every((item) => item) ? '전체 해제' : '전체 선택', style: const TextStyle(color: ColorFamily.black, fontSize: 14, fontFamily: FontFamily.mapleStoryLight)),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // 리스트 항목을 생성하는 ListView.builder
              Expanded(
                child: ListView.builder(
                  // 항목 수 설정
                  itemCount: provider.checkedItems.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              side: const BorderSide(color: ColorFamily.gray),
                              activeColor: ColorFamily.pink,
                              checkColor: ColorFamily.white,
                              // 개별 항목의 체크박스 상태
                              value: provider.checkedItems[index],
                              // 개별 체크박스 상태 변경 시
                              onChanged: (bool? value) {
                                provider.toggleCheck(index);
                              },
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset('lib/assets/icons/coffee_cup.svg'),
                                          const SizedBox(width: 10),
                                          const Text('스타벅스코리아', style: TextStyle(fontSize: 14, color: ColorFamily.black, fontFamily: FontFamily.mapleStoryLight)),
                                        ],
                                      ),
                                      const SizedBox(height: 15),

                                      const Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('일시', style: TextStyle(fontSize: 14, color: ColorFamily.black, fontFamily: FontFamily.mapleStoryLight)),
                                          Text('2024. 5. 17.(월) 12:30', style: TextStyle(fontSize: 14, color: ColorFamily.black, fontFamily: FontFamily.mapleStoryLight)),
                                        ],
                                      ),
                                      const SizedBox(height: 15),

                                      const Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('금액', style: TextStyle(fontSize: 14, color: ColorFamily.black, fontFamily: FontFamily.mapleStoryLight)),
                                          Text('-11,500원', style: TextStyle(fontSize: 14, color: ColorFamily.black, fontFamily: FontFamily.mapleStoryLight)),
                                        ],
                                      ),
                                      const SizedBox(height: 15),

                                      const Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('메모', style: TextStyle(fontSize: 14, color: ColorFamily.black, fontFamily: FontFamily.mapleStoryLight)),
                                          Text('아아 먹었음', style: TextStyle(fontSize: 14, color: ColorFamily.black, fontFamily: FontFamily.mapleStoryLight)),
                                        ],
                                      ),
                                      const SizedBox(height: 15),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // 구분 선
                        const Divider(color: ColorFamily.gray, thickness: 0.5),
                        const SizedBox(height: 20),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
      );
  }
}