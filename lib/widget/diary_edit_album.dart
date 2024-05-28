import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/provider/diary_provider.dart';

import '../style/color.dart';
import '../style/font.dart';

class DiaryEditAlbum extends StatefulWidget {
  const DiaryEditAlbum({super.key});

  @override
  State<DiaryEditAlbum> createState() => _DiaryEditAlbumState();
}

class _DiaryEditAlbumState extends State<DiaryEditAlbum> {
  final ImagePicker picker = ImagePicker(); //ImagePicker 초기화

  @override
  Widget build(BuildContext context) {
    var diaryProvider = Provider.of<DiaryProvider>(context, listen:false);

    return SizedBox(
      width: (MediaQuery.of(context).size.width / 3) - 20,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "썸네일 등록",
                style: TextStyle(
                    fontFamily: FontFamily.mapleStoryLight,
                    fontSize: 10,
                    color: ColorFamily.black),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    color: ColorFamily.white,
                    borderRadius:
                        BorderRadius.circular(10), // corner radius를 5로 설정
                    border: Border.all(
                        color: ColorFamily.gray), // stroke 색상을 red로 설정
                  ),
                  child: Card(
                    color: ColorFamily.white,
                    surfaceTintColor: ColorFamily.white,
                    elevation: 4,
                    margin: const EdgeInsets.all(10),
                    child: Container(
                      child: (diaryProvider.image != null)
                          ? Stack(
                              fit: StackFit.expand,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: (diaryProvider.image?.path != null)
                                      ?Image.file(
                                    File(diaryProvider.image!.path),
                                    fit: BoxFit.cover,
                                  ):Image.asset('lib/assets/images/test_couple.png', fit: BoxFit.cover,),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    onTap: (){
                                      setState(() {
                                        diaryProvider.setImage(null);
                                      });
                                    },
                                    child:SvgPicture.asset(
                                        'lib/assets/icons/close_circle_white.svg'),
                                  ),
                                )
                              ],
                            )
                          : IconButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              onPressed: () {
                                getImage(diaryProvider, ImageSource.gallery);
                              },
                              icon: SvgPicture.asset(
                                'lib/assets/icons/add.svg',
                                width: 40,
                                height: 40,
                                colorFilter: const ColorFilter.mode(
                                    ColorFamily.gray, BlendMode.srcIn),
                              )),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future getImage(DiaryProvider diaryProvider, ImageSource imagesource) async {
    //pickedFile에 ImagePicker로 가져온 이미지가 담긴다.
    final XFile? pickedFile = await picker.pickImage(source: imagesource);
    print(pickedFile?.path);
    if (pickedFile != null) {
      setState(() {
        diaryProvider.setImage(XFile(pickedFile.path));
      });
    }
  }
}
