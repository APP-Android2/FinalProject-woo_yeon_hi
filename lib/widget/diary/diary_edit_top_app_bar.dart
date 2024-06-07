import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/dao/diary_dao.dart';
import 'package:woo_yeon_hi/model/diary_model.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/text_style.dart';

import '../../provider/diary_provider.dart';


class DiaryEditTopAppBar extends StatefulWidget implements PreferredSizeWidget {
  const DiaryEditTopAppBar({super.key});

  @override
  State<DiaryEditTopAppBar> createState() => _DiaryEditTopAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _DiaryEditTopAppBarState extends State<DiaryEditTopAppBar> {
  @override
  Widget build(BuildContext context) {
    var diaryProvider = Provider.of<DiaryProvider>(context, listen: false);
    return AppBar(
      surfaceTintColor: ColorFamily.cream,
      backgroundColor: ColorFamily.cream,
      centerTitle: true,
      title: const Text(
        "일기작성",
        style: TextStyleFamily.appBarTitleLightTextStyle,
      ),
      leading: IconButton(
        onPressed: () {
          // 작성한 내용이 하나라도 있을 때, 삭제된다는 알림을 띄운다.
          if (diaryProvider.checkProvider()) {
            _showBackDialog(context, diaryProvider);
          } else {
            Navigator.pop(context);
          }
        },
        icon: SvgPicture.asset('lib/assets/icons/arrow_back.svg'),
      ),
      actions: [
        IconButton(
            onPressed: () async {
              if (diaryProvider.checkProvider()) {
                print(
                    "diary title : ${diaryProvider.titleTextEditController.text}");
                print(
                    "diary content : ${diaryProvider.contentTextEditController.text}");
                _showDoneDialog(context, diaryProvider);
              } else {
                // 토스트 메시지로 내용 작성 알림
                _showToast();
              }
            },
            icon: SvgPicture.asset('lib/assets/icons/done.svg'))
      ],
    );
  }

  void _showDoneDialog(BuildContext context, DiaryProvider diaryProvider) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            surfaceTintColor: ColorFamily.white,
            backgroundColor: ColorFamily.white,
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        children: [
                          Text(
                            "일기를 작성하시겠습니까?",
                            style: TextStyleFamily.dialogTitleTextStyle,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "작성 후 수정 및 삭제를 할 수 없습니다.",
                            style: TextStyleFamily.normalTextStyle,
                          )
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
                              onPressed: () {
                                //프로바이더 초기화
                                diaryProvider.resetProvider();
                                Navigator.pop(context); // 다이얼로그 팝
                                Navigator.pop(context); // 일기 작성 페이지 팝
                              },
                              child: const Text(
                                "확인",
                                style:
                                    TextStyleFamily.dialogButtonTextStyle_pink,
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
  }

  void _showBackDialog(BuildContext context, DiaryProvider diaryProvider) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            surfaceTintColor: ColorFamily.white,
            backgroundColor: ColorFamily.white,
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        children: [
                          Text(
                            "일기 작성을 취소하시겠습니까?",
                            style: TextStyleFamily.dialogTitleTextStyle,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "지금까지 작성 된 내용은 삭제됩니다.",
                            style: TextStyleFamily.normalTextStyle,
                          )
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
                              onPressed: () {
                                // 프로바이더 초기화
                                diaryProvider.resetProvider();
                                Navigator.pop(context); // 다이얼로그 팝
                                Navigator.pop(context); // 일기 작성 페이지 팝
                              },
                              child: const Text(
                                "확인",
                                style:
                                    TextStyleFamily.dialogButtonTextStyle_pink,
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
  }

  void _showToast() {
    Fluttertoast.showToast(
        msg: "내용을 입력해주세요", //메세지입력
        toastLength: Toast.LENGTH_SHORT, //메세지를 보여주는 시간(길이)
        gravity: ToastGravity.BOTTOM, //위치지정
        timeInSecForIosWeb: 1, //ios및웹용 시간
        backgroundColor: ColorFamily.gray,
        textColor: ColorFamily.white, //글자색
        fontSize: 14.0 //폰트사이즈
        );
  }
}
