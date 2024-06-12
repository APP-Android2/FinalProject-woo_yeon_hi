import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../dao/history_dao.dart';
import '../../model/history_model.dart';
import '../../provider/footprint_provider.dart';
import '../../style/color.dart';

class FootprintHistoryModifyAlbum extends StatefulWidget {
  FootprintHistoryModifyAlbum(this.provider, this.history, {super.key});
  FootprintHistoryEditProvider provider;
  History history;

  @override
  State<FootprintHistoryModifyAlbum> createState() =>
      _FootprintHistoryModifyAlbumState();
}

class _FootprintHistoryModifyAlbumState
    extends State<FootprintHistoryModifyAlbum> {
  final ImagePicker picker = ImagePicker(); //ImagePicker 초기화

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width - 40,
          height: 120,
          child: Card(
            color: ColorFamily.white,
            surfaceTintColor: ColorFamily.white,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  FutureBuilder(
                    future: getHistoryImageList(widget.history.historyImage),
                    builder: (context, snapshot){
                      if(snapshot.hasData == false){
                        return const SizedBox();
                      }else if(snapshot.hasError){
                        return const Center(child: Text("image download error"),);
                      }else{
                        return Expanded(
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) =>
                                  makeImageCard(context, index, snapshot.data![index])),
                        );
                      }
                    },
                  ),


                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget makeImageCard(BuildContext context, int index, Image image) {
    return Padding(
      padding: index != widget.provider.albumModifyImages.length - 1
          ? const EdgeInsets.only(right: 5)
          : const EdgeInsets.only(right: 0),
      child: SizedBox(
        width: 90,
        height: 90,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: image,
            )
          ],
        ),
      ),
    );
  }
}
