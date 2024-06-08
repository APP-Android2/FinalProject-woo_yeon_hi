import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:woo_yeon_hi/provider/diary_provider.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/text_style.dart';
import 'package:woo_yeon_hi/utils.dart';

import '../../style/font.dart';
import '../../widget/diary/diary_calendar_bottom_sheet.dart';
import '../../widget/diary/diary_filter_list_view.dart';
import '../../widget/diary/diary_grid_view.dart';
import '../../widget/diary/diary_modal_bottom_sheet.dart';
import '../../widget/diary/diary_top_app_bar.dart';
import 'diary_edit_screen.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  int user_idx = 0; // 유저 테이블 연동 할 것.
  int lover_idx = 1;

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (context) => DiaryProvider(),
      child: Consumer<DiaryProvider>(
        builder: (context, provider, _) {
          return Scaffold(
              backgroundColor: ColorFamily.cream,
              appBar: const DiaryTopAppBar(),
              floatingActionButton: FloatingActionButton(
                backgroundColor: ColorFamily.beige,
                shape: const CircleBorder(),
                child: SvgPicture.asset('lib/assets/icons/edit.svg'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const DiaryEditScreen())).then((value) => setState(() {}));
                },
              ),
              body: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 48,
                      child: Row(
                        children: [
                          InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              showFilterBottomSheet(provider, user_idx, lover_idx, context: context);
                            },
                            child: SvgPicture.asset(
                              'lib/assets/icons/Filter_alt_fill.svg',
                              width: 24,
                              height: 24,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: DiaryFilterListView(
                                  provider))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FutureBuilder(
                      future: provider.getDiary(user_idx),
                        builder: (context, snapshot){
                          if(snapshot.hasData == false){
                            return const Expanded(
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: ColorFamily.pink,
                                ),
                              ),
                            );
                          }else if(snapshot.hasError){
                            return const Text("오류 발생", style: TextStyleFamily.normalTextStyle,);
                          }else{
                            return Expanded(child: DiaryGridView(provider));
                          }
                        },
                    ),
                  ],
                ),
              )
          );
        },
      ),
    );
  }

  bool isSaturday(DateTime day) {
    return day.weekday == DateTime.saturday;
  }

  bool isWeekend(DateTime day) {
    return day.weekday == DateTime.sunday;
  }
}
