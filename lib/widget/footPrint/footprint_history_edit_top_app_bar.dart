import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:woo_yeon_hi/provider/footprint_provider.dart';

import '../../style/color.dart';
import '../../style/text_style.dart';

class FootprintHistoryEditTopAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  FootprintHistoryEditTopAppBar(this.provider, {super.key});
  FootprintHistoryEditProvider provider;

  @override
  State<FootprintHistoryEditTopAppBar> createState() =>
      _FootprintHistoryEditTopAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _FootprintHistoryEditTopAppBarState
    extends State<FootprintHistoryEditTopAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: ColorFamily.cream,
      backgroundColor: ColorFamily.cream,
      centerTitle: true,
      title: const Text(
        "히스토리 작성",
        style: TextStyleFamily.appBarTitleLightTextStyle,
      ),
      leading: IconButton(
        onPressed: () {
          if (widget.provider.titleController.text.isNotEmpty ||
              widget.provider.contentController.text.isNotEmpty ||
              widget.provider.selectedPlace != null ||
              widget.provider.date != null) {
            // 작성한 내용이 하나라도 있을 경우
            _showBackDialog(context);
          } else {
            Navigator.pop(context);
          }
        },
        icon: SvgPicture.asset('lib/assets/icons/arrow_back.svg'),
      ),
      actions: [
        IconButton(
            onPressed: () {
              if (widget.provider.titleController.text.isNotEmpty ||
                  widget.provider.contentController.text.isNotEmpty ||
                  widget.provider.selectedPlace != null ||
                  widget.provider.date != null) {
                _showDoneDialog(context);
              } else {
                _showToast();
              }
            },
            icon: SvgPicture.asset('lib/assets/icons/done.svg'))
      ],
    );
  }

  void _showDoneDialog(BuildContext context) {
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
                      const Text(
                        "히스토리를 작성하시겠습니까?",
                        style: TextStyleFamily.dialogButtonTextStyle,
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

  void _showBackDialog(BuildContext context) {
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
                            "히스토리 작성을 취소하시겠습니까?",
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
                                Navigator.pop(context); // 다이얼로그 팝
                                Navigator.pop(context); // 작성 페이지 팝
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
