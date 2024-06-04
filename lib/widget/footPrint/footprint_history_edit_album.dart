import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/style/text_style.dart';

class FootprintHistoryEditAlbum extends StatefulWidget {
  const FootprintHistoryEditAlbum({super.key});

  @override
  State<FootprintHistoryEditAlbum> createState() => _FootprintHistoryEditAlbumState();
}

class _FootprintHistoryEditAlbumState extends State<FootprintHistoryEditAlbum> {
  final ImagePicker picker = ImagePicker(); //ImagePicker 초기화
  List<XFile> _albumImages = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            width: MediaQuery.of(context).size.width - 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("${_albumImages.length} / 10", style: _albumImages.length > 10?TextStyle(fontFamily: FontFamily.mapleStoryLight, fontSize: 14, color: Colors.redAccent):TextStyleFamily.normalTextStyle,),

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
                  _albumImages.length < 10
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
                      itemCount: _albumImages.length,
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
      padding: index != _albumImages.length-1
          ?const EdgeInsets.only(right: 5)
      :const EdgeInsets.only(right: 0),
      child: SizedBox(
        width: 90, height: 90,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.file(File(_albumImages[index].path), fit: BoxFit.cover,),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: (){
                  setState(() {
                    _albumImages.removeAt(index);
                  });
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
      if(_albumImages.isNotEmpty){
        // 기존 리스트에 이미지가 있는 상황
        var _possibleCount = 10-_albumImages.length;
        if(_possibleCount < images.length){
          _showToast();
          setState(() {
            for(var i = 0; i < _possibleCount; i++){
              _albumImages.add(images[i]!);
            }
          });

        }else{
          setState(() {
            for(var i = 0; i < images.length; i++){
              _albumImages.add(images[i]!);
            }
          });
        }
      }else{
        if(images.length > 10){
          _showToast();
          setState(() {
            _albumImages.clear();
            for(var i = 0; i < 10; i++){
              _albumImages.add(images[i]!);
            }
          });
        }
        else{
          setState(() {
            _albumImages.clear();
            for(var image in images){
              _albumImages.add(image!);
            }
          });
        }
      }

    }
  }
}


void _showToast() {
  Fluttertoast.showToast(
      msg: "사진 등록은 최대 10장까지 가능합니다.", //메세지입력
      toastLength: Toast.LENGTH_SHORT, //메세지를 보여주는 시간(길이)
      gravity: ToastGravity.BOTTOM, //위치지정
      timeInSecForIosWeb: 1, //ios및웹용 시간
      backgroundColor: ColorFamily.gray,
      textColor: ColorFamily.white, //글자색
      fontSize: 14.0 //폰트사이즈
  );
}