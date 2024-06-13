import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:woo_yeon_hi/dao/history_dao.dart';
import 'package:woo_yeon_hi/model/history_model.dart';
import 'package:woo_yeon_hi/provider/footprint_provider.dart';

import '../../dialogs.dart';
import '../../screen/footPrint/footprint_history_edit_place_screen.dart';
import '../../screen/footPrint/footprint_history_screen.dart';
import '../../screen/footPrint/footprint_photo_map_detail_screen.dart';
import '../../style/color.dart';
import '../../style/text_style.dart';

class FootprintHistoryModifyTopAppBar extends StatefulWidget implements PreferredSizeWidget{
  FootprintHistoryModifyTopAppBar(this.provider, this.history, {super.key});
  FootprintHistoryEditProvider provider;
  History history;

  @override
  State<FootprintHistoryModifyTopAppBar> createState() => _FootprintHistoryModifyTopAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _FootprintHistoryModifyTopAppBarState extends State<FootprintHistoryModifyTopAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: ColorFamily.cream,
      backgroundColor: ColorFamily.cream,
      centerTitle: true,
      title: const Text(
        "히스토리 수정",
        style: TextStyleFamily.appBarTitleLightTextStyle,
      ),
      leading: IconButton(
        onPressed: (){
          // 바뀐 내용이 있는지 확인
          if(widget.provider.selectedPlace != null ||
          widget.provider.date != widget.history.historyDate ||
          widget.provider.titleController.text != widget.history.historyTitle ||
          widget.provider.contentController.text != widget.history.historyContent){
            dialogTitleWithContent(
                context,
                "히스토리 수정을 취소하시겠습니까?",
                "지금까지 작성 된 내용은 삭제됩니다.",
                    () => _onCancle_back(context),
                    () => _onConfirm_back(context));
          }else{
            Navigator.pop(context);
          }
        },
        icon: SvgPicture.asset('lib/assets/icons/arrow_back.svg'),
      ),
      actions: [
        (widget.provider.selectedPlace != null ||
            widget.provider.date != widget.history.historyDate ||
            widget.provider.titleController.text != widget.history.historyTitle ||
            widget.provider.contentController.text != widget.history.historyContent)
            ?IconButton(
            onPressed: () {
              dialogOnlyTitle(
                  context,
                  "히스토리를 수정하시겠습니까?",
                      () => _onCancle_done(context),
                      () => _onConfirm_done(context));
            },
            icon: SvgPicture.asset('lib/assets/icons/done.svg'))
            : const SizedBox()

      ],
    );
  }

  void _onCancle_back(BuildContext context) {
    Navigator.pop(context);
  }

  void _onConfirm_back(BuildContext context) {
    Navigator.pop(context); // 다이얼로그 팝
    Navigator.pop(context); // 히스토리 수정 페이지 팝
  }

  void _onCancle_done(BuildContext context) {
    Navigator.pop(context);
  }

  Future<void> _onConfirm_done(BuildContext context) async {

    Map<String, dynamic> historyMap = {};

    if(widget.provider.selectedPlace != null){
      var coordinate = convertCoordinate(widget.provider.selectedPlace!.mapx, widget.provider.selectedPlace!.mapy);
      historyMap = {
        "history_content" : widget.provider.contentController.text,
        "history_date" : widget.provider.date,
        "history_location" : GeoPoint(coordinate.latitude, coordinate.longitude),
        "history_place_name" : widget.provider.selectedPlace!.title,
        "history_title" : widget.provider.titleController.text
      };
      editHistory(widget.history.historyIdx, historyMap);
    }else{
      historyMap = {
        "history_content" : widget.provider.contentController.text,
        "history_date" : widget.provider.date,
        "history_title" : widget.provider.titleController.text
      };
      editHistory(widget.history.historyIdx, historyMap);
    }
    Navigator.pop(context); // 다이얼로그 팝
    Navigator.pop(context, "refresh"); // 히스토리 수정 페이지 팝
  }
}
