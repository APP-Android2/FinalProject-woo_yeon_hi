import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../style/color.dart';
import '../style/text_style.dart';

class DiaryFilterListView extends StatefulWidget {
  List<String> filterList = [];
  DiaryFilterListView(this.filterList, {super.key});

  @override
  State<DiaryFilterListView> createState() => _DiaryFilterListViewState();
}

class _DiaryFilterListViewState extends State<DiaryFilterListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.filterList.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(right: 10),
        child: makeChip(index, widget.filterList[index]),
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
            widget.filterList[index] = "";
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



