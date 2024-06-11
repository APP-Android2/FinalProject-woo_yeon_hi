import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woo_yeon_hi/model/enums.dart';
import 'package:woo_yeon_hi/provider/diary_provider.dart';

import '../../style/color.dart';
import '../../style/text_style.dart';


class DiaryFilterListView extends StatefulWidget {
  DiaryFilterListView(this.provider, {super.key});
  DiaryProvider provider;

  @override
  State<DiaryFilterListView> createState() => _DiaryFilterListViewState();
}

class _DiaryFilterListViewState extends State<DiaryFilterListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.provider.filterList.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(right: 10),
        child: makeChip(index, widget.provider.filterList[index]),
      ),
    );
  }
  Widget makeChip(int index, String filterName) {
    if(filterName == ""){
      return const SizedBox();
    }else{
      return Chip(
        label: Text(filterName, style: TextStyleFamily.normalTextStyle_pink,),
        backgroundColor: ColorFamily.white,
        deleteIcon: SvgPicture.asset('lib/assets/icons/close.svg', colorFilter: const ColorFilter.mode(ColorFamily.pink, BlendMode.srcIn),),
        onDeleted: (){
          setState(() {
            // 삭제한 항목이 작성자 항목이면
            if(DiaryEditorState.getDetails().contains(widget.provider.filterList[index])){
              widget.provider.setSelected_editor([true, false, false]);
              // 정렬 항목
            }else if(DiarySortState.getDetails().contains(widget.provider.filterList[index])){
              widget.provider.setSelected_sort([true, false]);
              // 날짜 조회
            }else if(widget.provider.filterList[index].isNotEmpty){
              widget.provider.setStartPeriod("");
              widget.provider.setEndPeriod("");
            }
            widget.provider.filterList[index] = "";
            widget.provider.providerNotify();
          });
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: ColorFamily.pink)
        ),
      );
    }
  }
}



