import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:woo_yeon_hi/dao/history_dao.dart';
import 'package:woo_yeon_hi/dialogs.dart';
import 'package:woo_yeon_hi/provider/footprint_provider.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/style/text_style.dart';

class FootprintHistoryEditAlbum extends StatefulWidget {
  FootprintHistoryEditAlbum(this.provider, {super.key});
  FootprintHistoryEditProvider provider;

  @override
  State<FootprintHistoryEditAlbum> createState() => _FootprintHistoryEditAlbumState();
}

class _FootprintHistoryEditAlbumState extends State<FootprintHistoryEditAlbum> {
  final ImagePicker picker = ImagePicker(); //ImagePicker 초기화

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            width: MediaQuery.of(context).size.width - 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("${widget.provider.albumImages.length} / 10", style: TextStyleFamily.normalTextStyle),

            ],
          ),
        ),
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
                  widget.provider.albumImages.length < 10
                      ? Row(
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ColorFamily.gray, // 외곽선 색상
                            width: 1, // 외곽선 두께
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: (){
                            getImages();
                          },
                          child: SvgPicture.asset(
                            'lib/assets/icons/add.svg',
                            width: 40, height: 40,
                            colorFilter: const ColorFilter.mode(ColorFamily.gray, BlendMode.srcIn),),
                        ),
                      ),
                      const SizedBox(width: 5,),
                    ],
                  )
                      : const SizedBox()
                  ,
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.provider.albumImages.length,
                        itemBuilder: (context, index) => makeImageCard(context, index)
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
  Widget makeImageCard(BuildContext context, int index){
    return Padding(
      padding: index != widget.provider.albumImages.length-1
          ?const EdgeInsets.only(right: 5)
      :const EdgeInsets.only(right: 0),
      child: SizedBox(
        width: 90, height: 90,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.file(File(widget.provider.albumImages[index].path), fit: BoxFit.cover,),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: (){
                  widget.provider.removeAlbumImage(index);
                },
                child:SvgPicture.asset(
                    'lib/assets/icons/close_circle_white.svg'),
              ),
            )
          ],
        ),
      ),
    );
  }


  Future getImages() async {
    final List<XFile?>images = await picker.pickMultiImage();
    if(images.isNotEmpty){
      if(widget.provider.albumImages.isNotEmpty){
        // 기존 리스트에 이미지가 있는 상황
        var _possibleCount = 10-widget.provider.albumImages.length;
        if(_possibleCount < images.length){
          showToast("사진 등록은 최대 10장까지 가능합니다.");
          for(var i = 0; i < _possibleCount; i++){
            widget.provider.addAlbumImage(images[i]!);
          }

        }else{
          for(var i = 0; i < images.length; i++){
            widget.provider.addAlbumImage(images[i]!);
          }
        }
      }else{
        if(images.length > 10){
          showToast("사진 등록은 최대 10장까지 가능합니다.");
          widget.provider.clearAlbumImages();
          for(var i = 0; i < 10; i++){
            widget.provider.addAlbumImage(images[i]!);
          }
        }
        else{
          widget.provider.clearAlbumImages();
          for(var image in images){
            widget.provider.addAlbumImage(image!);
          }
        }
      }

    }
  }
}