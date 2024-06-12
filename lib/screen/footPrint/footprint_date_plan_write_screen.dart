import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/dao/plan_dao.dart';
import 'package:woo_yeon_hi/dialogs.dart';
import 'package:woo_yeon_hi/model/enums.dart';
import 'package:woo_yeon_hi/model/plan_model.dart';
import 'package:woo_yeon_hi/screen/footPrint/footprint_date_plan_detail_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/utils.dart';
import 'package:woo_yeon_hi/widget/footPrint/footprint_date_plan_draggable_sheet.dart';
import 'package:woo_yeon_hi/widget/footPrint/footprint_date_plan_search_bar.dart';
import 'package:woo_yeon_hi/widget/footPrint/footprint_date_plan_top_app_bar.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
as picker;

import '../../provider/footprint_provider.dart';
import '../../style/font.dart';
import '../../style/text_style.dart';
import '../../widget/footPrint/footprint_date_plan_write_place_info.dart';

class FootprintDatePlanWriteScreen extends StatefulWidget {
  const FootprintDatePlanWriteScreen({super.key});

  @override
  State<FootprintDatePlanWriteScreen> createState() => _FootprintDatePlanWriteScreenState();
}

class _FootprintDatePlanWriteScreenState extends State<FootprintDatePlanWriteScreen> {
  late NaverMapController _mapController;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FootPrintDatePlanSlidableProvider(),
      child: Consumer<FootPrintDatePlanSlidableProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            // 앱바
            appBar: FootprintDatePlanTopAppBar(
              title: '데이트 플랜 작성',
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: SvgPicture.asset('lib/assets/icons/arrow_back.svg'),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FootprintDatePlanDetailScreen(provider)
                        )
                    );
                  },
                  icon: SvgPicture.asset('lib/assets/icons/list.svg'),
                ),
                IconButton(
                  onPressed: () async {
                    await _showDatePicker(context, provider, "start");
                    await _showDatePicker(context, provider, "end");
                    _showMapSelectDialog(context, provider);
                  },
                  icon: SvgPicture.asset('lib/assets/icons/done.svg'),
                ),
              ],
            ),
            resizeToAvoidBottomInset: false,
            // 전체 배경색
            backgroundColor: ColorFamily.cream,
            body: Stack(
              children: [
                // NaverMap 위젯 초기화.
                NaverMap(
                  options: const NaverMapViewOptions(),
                  // 지도 준비 완료 시 호출되는 콜백 함수
                  onMapReady: (controller) {
                    _mapController = controller;
                    print("네이버 맵 로딩 완료");
                  },
                ),

                // 검색 바
                const FootprintDatePlanSearchBar(),

                // 바텀 시트
                FootprintDatePlanDraggableSheet(provider),

                // 하단 카드뷰
                Consumer<FootPrintDatePlanSlidableProvider>(
                    builder: (context, provider, child) {
                      if(provider.selectedPlace != null){
                        double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
                        return Positioned(
                            bottom:  keyboardHeight > 0 ? keyboardHeight : 40.0,
                            left: 20,
                            right: 20,
                            child: FootprintDatePlanWritePlaceInfo(provider, _mapController));
                      }else{
                        return const SizedBox();
                      }
                    }
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

void _showMapSelectDialog(BuildContext context, FootPrintDatePlanSlidableProvider provider) {
  String? _errorText;
  String? _errorTextStart;
  String? _errorTextEnd;

  int userIdx = 0;
  showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, dialogState) {
          return Dialog(
            surfaceTintColor: ColorFamily.white,
            backgroundColor: ColorFamily.white,
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const Text(
                            "플랜 상세",
                            style: TextStyleFamily.dialogTitleTextStyle,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              const Text("플랜명", style: TextStyleFamily.normalTextStyle,),
                              SizedBox(width: MediaQuery.of(context).size.width * 0.2,),
                              Expanded(
                                child: TextField(
                                  textAlign: TextAlign.end,
                                  controller: provider.planTitleController,
                                  style: TextStyleFamily.normalTextStyle,
                                  keyboardType: TextInputType.text,
                                  cursorColor: ColorFamily.black,
                                  onChanged: (text) {
                                    dialogState(() {
                                      if (text.isEmpty) {
                                        _errorText = "제목을 입력해주세요";
                                      } else {
                                        _errorText = null;
                                      }
                                    });
                                  },
                                  decoration: InputDecoration(
                                      errorText: _errorText,
                                      errorStyle: const TextStyle(
                                          fontFamily: FontFamily.mapleStoryLight,
                                          fontSize: 14,
                                          color: Colors.red),
                                      hintText: "데이트 플랜 이름",
                                      hintStyle: TextStyleFamily.hintTextStyle,
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: ColorFamily.black, width: 1.0),
                                      )),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15,),
                          Row(
                            children: [
                              const Text("시작일", style: TextStyleFamily.normalTextStyle,),
                              SizedBox(width: MediaQuery.of(context).size.width * 0.2,),
                              Expanded(
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: (){
                                    dialogState((){
                                      _showDatePicker(context, provider, "start");
                                    });
                                  },
                                  child: TextField(
                                    textAlign: TextAlign.end,
                                    controller: provider.planDateStartController,
                                    style: TextStyleFamily.normalTextStyle,
                                    keyboardType: TextInputType.text,
                                    cursorColor: ColorFamily.black,
                                    onChanged: (text) {
                                      dialogState(() {
                                        if (text.isEmpty) {
                                          _errorTextStart = "날짜를 지정해주세요";
                                        } else {
                                          _errorTextStart = null;
                                        }
                                      });
                                    },
                                    decoration: InputDecoration(
                                        errorText: _errorTextStart,
                                        errorStyle: const TextStyle(
                                            fontFamily: FontFamily.mapleStoryLight,
                                            fontSize: 14,
                                            color: Colors.red),
                                        hintText: "시작 날짜",
                                        hintStyle: TextStyleFamily.hintTextStyle,
                                        focusedBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: ColorFamily.black, width: 1.0),
                                        )),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 15,),
                          Row(
                            children: [
                              const Text("종료일", style: TextStyleFamily.normalTextStyle,),
                              SizedBox(width: MediaQuery.of(context).size.width * 0.2,),
                              Expanded(
                                child: InkWell(
                                  onTap: (){
                                    dialogState((){
                                      _showDatePicker(context, provider, "end");
                                    });
                                  },
                                  child: TextField(
                                    textAlign: TextAlign.end,
                                    controller: provider.planDateEndController,
                                    style: TextStyleFamily.normalTextStyle,
                                    keyboardType: TextInputType.text,
                                    cursorColor: ColorFamily.black,
                                    onChanged: (text) {
                                      dialogState(() {
                                        if (text.isEmpty) {
                                          _errorTextEnd = "날짜를 지정해주세요";
                                        } else {
                                          _errorTextEnd = null;
                                        }
                                      });
                                    },
                                    decoration: InputDecoration(
                                        errorText: _errorTextEnd,
                                        errorStyle: const TextStyle(
                                            fontFamily: FontFamily.mapleStoryLight,
                                            fontSize: 14,
                                            color: Colors.red),
                                        hintText: "종료 날짜",
                                        hintStyle: TextStyleFamily.hintTextStyle,
                                        focusedBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: ColorFamily.black, width: 1.0),
                                        )),
                                  ),
                                ),
                              )
                            ],
                          ),

                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                              style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(
                                      ColorFamily.gray)),
                              onPressed: () {
                                _errorText = null;
                                provider.clearTitleController();
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "취소",
                                style: TextStyleFamily.dialogButtonTextStyle,
                              )),
                          TextButton(
                              style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(
                                      ColorFamily.gray)),
                              onPressed: () async {
                                if(provider.planTitleController.text.isEmpty) {
                                  dialogState((){
                                    _errorText = "제목을 입력해주세요";
                                  });
                                } else if (provider.planDateStartController.text.isEmpty){
                                  dialogState((){
                                    _errorTextStart = "날짜를 지정해주세요";
                                  });
                                } else if (provider.planDateEndController.text.isEmpty){
                                  dialogState((){
                                    _errorTextEnd = "날짜를 지정해주세요";
                                  });
                                } else {
                                  var planIdx = await getPlanSequence() + 1;
                                  setPlanSequence(planIdx);
                                  var plan = Plan(
                                      planIdx: planIdx,
                                      planTitle: provider.planTitleController.text,
                                      planDate: "${provider.planDateStartController.text} ~ ${provider.planDateEndController.text}",
                                      planWriteDate: dateToString(DateTime.now()),
                                      planUserIdx: userIdx,
                                      planedArray: provider.planList,
                                      planState: PlanState.STATE_NORMAL.state
                                  );
                                  addPlan(plan);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                }
                              },
                              child: const Text(
                                "확인",
                                style: TextStyleFamily
                                    .dialogButtonTextStyle_pink,
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
      });
}

Future<DateTime?> _showDatePicker(BuildContext context, FootPrintDatePlanSlidableProvider provider, String flag){
  if(flag == "start"){
    showToast("시작일");
  }else{
    showToast("종료일");
  }
  return picker.DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(1900, 1, 1),
      maxTime: DateTime(2099, 12, 31),
      theme: const picker.DatePickerTheme(
          titleHeight: 60,
          containerHeight: 300,
          itemHeight: 50,
          headerColor: ColorFamily.white,
          backgroundColor:
          ColorFamily.white,
          itemStyle: TextStyleFamily
              .smallTitleTextStyle,
          cancelStyle: TextStyle(
              color: ColorFamily.black,
              fontSize: 18,
              fontFamily: FontFamily
                  .mapleStoryLight),
          doneStyle: TextStyle(
              color: ColorFamily.black,
              fontSize: 18,
              fontFamily: FontFamily
                  .mapleStoryLight),),
      // onChanged: (date) {
      //   print('change $date in time zone ' +
      //    date.timeZoneOffset.inHours.toString());
      // },
      onConfirm: (date) {
        var stringDate = dateToString(date);
        if(flag == "start"){
          provider.setPlanDateStart(stringDate);
        }else{
          provider.setPlanDateEnd(stringDate);
        }
      },
      // onCancel: (){},
      currentTime: DateTime.now(),
      locale: picker.LocaleType.ko);
}