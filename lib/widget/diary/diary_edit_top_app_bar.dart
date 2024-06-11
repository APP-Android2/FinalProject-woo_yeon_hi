import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/dao/diary_dao.dart';
import 'package:woo_yeon_hi/model/diary_model.dart';
import 'package:woo_yeon_hi/model/enums.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/text_style.dart';

import '../../dialogs.dart';
import '../../provider/diary_provider.dart';
import '../../utils.dart';

class DiaryEditTopAppBar extends StatefulWidget implements PreferredSizeWidget {
  DiaryEditTopAppBar(this.provider, {super.key});
  DiaryEditProvider provider;

  @override
  State<DiaryEditTopAppBar> createState() => _DiaryEditTopAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _DiaryEditTopAppBarState extends State<DiaryEditTopAppBar> {
  @override
  Widget build(BuildContext context) {
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
          if (widget.provider.checkProvider()) {
            dialogTitleWithContent(
              context,
                "일기 작성을 취소하시겠습니까?",
                "지금까지 작성 된 내용은 삭제됩니다.",
                () => _onCancle_back(context),
                () => _onConfirm_back(context)
            );
          } else {
            Navigator.pop(context);
          }
        },
        icon: SvgPicture.asset('lib/assets/icons/arrow_back.svg'),
      ),
      actions: [
        IconButton(
            onPressed: () async {
              if (widget.provider.checkValid()) {
                dialogTitleWithContent(
                    context,
                    "일기를 작성하시겠습니까?",
                    "작성 후 수정 및 삭제를 할 수 없습니다.",
                    () => _onCancle_done(context),
                    () => _onConfirm_done(context, widget.provider));
              } else {
                // 토스트 메시지로 내용 작성 알림
                showToast("모든 내용을 입력해주세요.");
              }
            },
            icon: SvgPicture.asset('lib/assets/icons/done.svg'))
      ],
    );
  }
}

void _onCancle_done(BuildContext context) {
  Navigator.pop(context);
}

Future<void> _onConfirm_done(BuildContext context, DiaryEditProvider provider) async {
  Navigator.pop(context); // 다이얼로그 팝
  Navigator.pop(context); // 일기 작성 페이지 팝

  var diary_idx = await getDiarySequence() + 1;
  var diary_user_idx = 0; // 유저 idx
  await setDiarySequence(diary_idx);
  var now = DateTime.now();
  var today_formatted = dateToString(now);
  var imageName = "${diary_user_idx}_$now";

  var diary = Diary(
      diaryIdx: diary_idx,
      diaryUserIdx: diary_user_idx, // 임시
      diaryDate: today_formatted,
      diaryWeather: provider.weatherType,
      diaryImage: imageName,
      diaryTitle: provider.titleTextEditController.text,
      diaryContent: provider.contentTextEditController.text,
      diaryLoverCheck: false,
      diaryState: DiaryState.STATE_NORMAL.state);
  await addDiary(diary);
  await uploadDiaryImage(provider.image!, imageName);
  provider.providerNotify();
}

void _onCancle_back(BuildContext context){
  Navigator.pop(context);
}

void _onConfirm_back(BuildContext context){
  Navigator.pop(context); // 다이얼로그 팝
  Navigator.pop(context); // 일기 작성 페이지 팝
}
