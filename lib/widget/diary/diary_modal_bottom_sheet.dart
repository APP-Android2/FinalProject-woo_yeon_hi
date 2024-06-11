import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../provider/diary_provider.dart';
import '../../style/color.dart';
import '../../style/font.dart';
import '../../style/text_style.dart';
import '../../utils.dart';
import 'diary_calendar_bottom_sheet.dart';

void showFilterBottomSheet(DiaryProvider provider, int user_idx, int lover_idx, {required BuildContext context}) {
  if (provider.filterList.first.isEmpty) {
    provider.setSelected_editor([true, false, false]);
  }
  if (provider.filterList.length > 2) {
    if (provider.filterList[2].isEmpty) {
      provider.setSelected_sort([true, false]);
    }
    if (provider.filterList[1].isEmpty) {
      provider.setStartPeriod("");
      provider.setStartControllerText("");
      provider.setEndPeriod("");
      provider.setEndControllerText("");
      provider.removeFilterListByIndex(1);
    }
  } else {
    if (provider.filterList[1].isEmpty) {
      provider.setSelected_sort([true, false]);
    }
  }
  showModalBottomSheet(
      context: context,
      showDragHandle: true,
      backgroundColor: ColorFamily.white,
      builder: (context) {
        return StatefulBuilder(builder: (context, bottomState) {
          return Wrap(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "작성자 유형",
                            style: TextStyleFamily.appBarTitleBoldTextStyle,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // 작성자 유형
                      ToggleButtons(
                          renderBorder: false,
                          fillColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          selectedColor: ColorFamily.pink,
                          selectedBorderColor: ColorFamily.pink,
                          disabledBorderColor: ColorFamily.gray,
                          disabledColor: ColorFamily.gray,
                          isSelected: provider.isSelected_editor,
                          onPressed: (val) {
                            bottomState(() {
                              provider.setSelected_editor(
                                  List.generate(3, (index) => false));
                              provider.updateSelected_editor(
                                  val, !provider.isSelected_editor[val]);
                              if(val == 1){
                                // 작성자 유형 : 나
                                provider.setUserIdx(user_idx);
                              }else if(val == 2){
                                // 작성자 유형 : 상대방
                                provider.setUserIdx(lover_idx);
                              }else{
                                provider.setUserIdx(null);
                              }
                            });
                          },
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(
                                      color: provider.isSelected_editor[0]
                                          ? ColorFamily.pink
                                          : ColorFamily.gray,
                                    ),
                                    borderRadius: BorderRadius.circular(20)),
                                width: (MediaQuery.of(context).size.width -
                                    40 -
                                    30) /
                                    3,
                                height: 40,
                                alignment: Alignment.center,
                                child: Text(
                                  provider.editorType[0],
                                  style: TextStyle(
                                      fontFamily: FontFamily.mapleStoryLight,
                                      fontSize: 14,
                                      color: provider.isSelected_editor[0]
                                          ? ColorFamily.pink
                                          : ColorFamily.gray),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(
                                      color: provider.isSelected_editor[1]
                                          ? ColorFamily.pink
                                          : ColorFamily.gray,
                                    ),
                                    borderRadius: BorderRadius.circular(20)),
                                width: (MediaQuery.of(context).size.width -
                                    40 -
                                    30) /
                                    3,
                                height: 40,
                                alignment: Alignment.center,
                                child: Text(
                                  provider.editorType[1],
                                  style: TextStyle(
                                      fontFamily: FontFamily.mapleStoryLight,
                                      fontSize: 14,
                                      color: provider.isSelected_editor[1]
                                          ? ColorFamily.pink
                                          : ColorFamily.gray),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(
                                      color: provider.isSelected_editor[2]
                                          ? ColorFamily.pink
                                          : ColorFamily.gray,
                                    ),
                                    borderRadius: BorderRadius.circular(20)),
                                width: (MediaQuery.of(context).size.width -
                                    40 -
                                    30) /
                                    3,
                                height: 40,
                                alignment: Alignment.center,
                                child: Text(
                                  provider.editorType[2],
                                  style: TextStyle(
                                      fontFamily: FontFamily.mapleStoryLight,
                                      fontSize: 14,
                                      color: provider.isSelected_editor[2]
                                          ? ColorFamily.pink
                                          : ColorFamily.gray),
                                ),
                              ),
                            ),
                          ]),
                      const SizedBox(
                        height: 30,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "조회 기간",
                            style: TextStyleFamily.appBarTitleBoldTextStyle,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // 조회 기간
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                              child: SizedBox(
                                width: (MediaQuery.of(context).size.width -
                                    40 -
                                    20 -
                                    20) /
                                    2,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        const SizedBox(),
                                        Expanded(
                                          child: TextField(
                                            controller: provider
                                                .startPeriodController,
                                            textAlign: TextAlign.center,
                                            style: TextStyleFamily
                                                .normalTextStyle,
                                            enabled: false,
                                            decoration: const InputDecoration(
                                              disabledBorder:
                                              UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: ColorFamily
                                                        .black), // 기본 밑줄 색상
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          child: SvgPicture.asset(
                                              'lib/assets/icons/calendar.svg'),
                                          onTap: () {
                                            showCalendarBottomSheet(
                                                context, "start", provider);
                                          },
                                        )
                                      ]),
                                ),
                              ),
                            ),
                            const Text(
                              "-",
                              style: TextStyleFamily.normalTextStyle,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                              child: SizedBox(
                                width: (MediaQuery.of(context).size.width -
                                    40 -
                                    20 -
                                    20) /
                                    2,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        const SizedBox(),
                                        Expanded(
                                          child: TextField(
                                            controller:
                                            provider.endPeriodController,
                                            textAlign: TextAlign.center,
                                            style: TextStyleFamily
                                                .normalTextStyle,
                                            enabled: false,
                                            decoration: const InputDecoration(
                                              disabledBorder:
                                              UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: ColorFamily
                                                        .black), // 기본 밑줄 색상
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          child: SvgPicture.asset(
                                              'lib/assets/icons/calendar.svg'),
                                          onTap: () {
                                            showCalendarBottomSheet(
                                                context, "end", provider);
                                          },
                                        )
                                      ]),
                                ),
                              ),
                            ),
                          ]),
                      const SizedBox(
                        height: 30,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "정렬 기준",
                            style: TextStyleFamily.appBarTitleBoldTextStyle,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // 정렬 기준
                      ToggleButtons(
                          renderBorder: false,
                          fillColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          selectedColor: ColorFamily.pink,
                          selectedBorderColor: ColorFamily.pink,
                          disabledBorderColor: ColorFamily.gray,
                          disabledColor: ColorFamily.gray,
                          isSelected: provider.isSelected_sort,
                          onPressed: (val) {
                            bottomState(() {
                              provider.setSelected_sort(
                                  List.generate(2, (index) => false));
                              provider.updateSelected_sort(
                                  val, !provider.isSelected_sort[val]);
                            });
                          },
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(
                                      color: provider.isSelected_sort[0]
                                          ? ColorFamily.pink
                                          : ColorFamily.gray,
                                    ),
                                    borderRadius: BorderRadius.circular(20)),
                                width: (MediaQuery.of(context).size.width -
                                    40 -
                                    20) /
                                    2,
                                height: 40,
                                alignment: Alignment.center,
                                child: Text(
                                  provider.sortType[0],
                                  style: TextStyle(
                                      fontFamily: FontFamily.mapleStoryLight,
                                      fontSize: 14,
                                      color: provider.isSelected_sort[0]
                                          ? ColorFamily.pink
                                          : ColorFamily.gray),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(
                                      color: provider.isSelected_sort[1]
                                          ? ColorFamily.pink
                                          : ColorFamily.gray,
                                    ),
                                    borderRadius: BorderRadius.circular(20)),
                                width: (MediaQuery.of(context).size.width -
                                    40 -
                                    20) /
                                    2,
                                height: 40,
                                alignment: Alignment.center,
                                child: Text(
                                  provider.sortType[1],
                                  style: TextStyle(
                                      fontFamily: FontFamily.mapleStoryLight,
                                      fontSize: 14,
                                      color: provider.isSelected_sort[1]
                                          ? ColorFamily.pink
                                          : ColorFamily.gray),
                                ),
                              ),
                            ),
                          ]),
                      const SizedBox(
                        height: 30,
                      ),
                      // 확인 버튼
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorFamily.beige,
                              surfaceTintColor: ColorFamily.beige,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              provider.setFilterList([]);
                              // 작성자 유형
                              provider.addFilterListItem(provider.editorType[
                              provider.isSelected_editor
                                  .indexWhere((element) => element)]);
                              // 조회 기간
                              if (provider.startPeriod.isNotEmpty ||
                                  provider.endPeriod.isNotEmpty) {
                                if (provider.startPeriod.isEmpty) {
                                  provider.addFilterListItem(
                                      "${provider.startPeriod}~${provider.endPeriod}");
                                } else if (provider.endPeriod.isEmpty) {
                                  provider.addFilterListItem(
                                      "${provider.startPeriod}~${provider.endPeriod}");
                                } else {
                                  DateTime pd1 =
                                  stringToDate(provider.startPeriod);
                                  DateTime pd2 =
                                  stringToDate(provider.endPeriod);
                                  if (pd1.compareTo(pd2) < 0) {
                                    provider.addFilterListItem(
                                        "${provider.startPeriod}~${provider.endPeriod}");
                                  } else {
                                    provider.addFilterListItem(
                                        "${provider.endPeriod}~${provider.startPeriod}");
                                  }
                                }
                              }
                              // 정렬 기준
                              provider.addFilterListItem(provider.sortType[
                              provider.isSelected_sort
                                  .indexWhere((element) => element)]);
                              provider.providerNotify();
                            },
                            child: const Text(
                              "확인",
                              style: TextStyleFamily.normalTextStyle,
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        });
      });
}