import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:woo_yeon_hi/dao/history_dao.dart';
import 'package:woo_yeon_hi/model/enums.dart';
import 'package:woo_yeon_hi/model/history_model.dart';
import 'package:woo_yeon_hi/provider/footprint_provider.dart';

import '../../dialogs.dart';
import '../../screen/footPrint/footprint_history_edit_place_screen.dart';
import '../../style/color.dart';
import '../../style/text_style.dart';

class FootprintHistoryEditTopAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  FootprintHistoryEditTopAppBar(this.provider, this.mapIdx, {super.key});
  FootprintHistoryEditProvider provider;
  int mapIdx;

  @override
  State<FootprintHistoryEditTopAppBar> createState() =>
      _FootprintHistoryEditTopAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _FootprintHistoryEditTopAppBarState
    extends State<FootprintHistoryEditTopAppBar> {
  var userIdx = 0;

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
          if (widget.provider.albumImages.isNotEmpty ||
              widget.provider.titleController.text.isNotEmpty ||
              widget.provider.contentController.text.isNotEmpty ||
              widget.provider.selectedPlace != null ||
              widget.provider.date != null) {
            // 작성한 내용이 하나라도 있을 경우
            dialogTitleWithContent(
                context,
                "히스토리 작성을 취소하시겠습니까?",
                "지금까지 작성 된 내용은 삭제됩니다.",
                () => _onCancle_back(context),
                () => _onConfirm_back(context));
          } else {
            Navigator.pop(context);
          }
        },
        icon: SvgPicture.asset('lib/assets/icons/arrow_back.svg'),
      ),
      actions: [
        IconButton(
            onPressed: () {
              if (widget.provider.albumImages.isNotEmpty &&
                  widget.provider.titleController.text.isNotEmpty &&
                  widget.provider.contentController.text.isNotEmpty &&
                  widget.provider.selectedPlace != null &&
                  widget.provider.date != null) {
                dialogOnlyTitle(
                    context,
                    "히스토리를 작성하시겠습니까?",
                    () => _onCancle_done(context),
                    () => _onConfirm_done(context));
              } else {
                showToast("사진 및 모든 내용을 입력해주세요.");
              }
            },
            icon: SvgPicture.asset('lib/assets/icons/done.svg'))
      ],
    );
  }

  void _onCancle_back(BuildContext context) {
    Navigator.pop(context);
  }

  void _onConfirm_back(BuildContext context) {
    Navigator.pop(context); // 다이얼로그 팝
    Navigator.pop(context); // 히스토리 작성 페이지 팝
  }

  void _onCancle_done(BuildContext context) {
    Navigator.pop(context);
  }

  Future<void> _onConfirm_done(BuildContext context) async {
    var historySequence = await getHistorySequence() + 1;
    setHistorySequence(historySequence);
    
    var imageNameList = List.generate(
        widget.provider.albumImages.length,
            (index) => "${userIdx}_${widget.mapIdx}_${DateTime.now()}");
    var coordinate = convertCoordinate(widget.provider.selectedPlace!.mapx, widget.provider.selectedPlace!.mapy);

    var history = History(
        historyIdx: historySequence,
        historyMapIdx: widget.mapIdx,
        historyPlaceName: widget.provider.selectedPlace!.title,
        historyLocation: GeoPoint(coordinate.latitude, coordinate.longitude),
        historyUserIdx: userIdx,
        historyTitle: widget.provider.titleController.text,
        historyDate: widget.provider.date!,
        historyContent: widget.provider.contentController.text,
        historyImage: imageNameList,
        historyState: HistoryState.STATE_NORMAL.state
    );

    addHistory(history);

    for(var i = 0 ; i < imageNameList.length ; i++){
      uploadHistoryImage(widget.provider.albumImages[i], imageNameList[i]);
    }
    Navigator.pop(context); // 다이얼로그 팝
    Navigator.pop(context); // 히스토리 작성 페이지 팝
  }
}


