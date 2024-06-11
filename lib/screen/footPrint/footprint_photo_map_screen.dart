import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woo_yeon_hi/dao/photo_map_dao.dart';
import 'package:woo_yeon_hi/model/photo_map_model.dart';
import 'package:woo_yeon_hi/screen/footPrint/footprint_photo_map_detail_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/text_style.dart';

import '../../style/font.dart';

class FootprintPhotoMapScreen extends StatefulWidget {
  const FootprintPhotoMapScreen({super.key});

  @override
  State<FootprintPhotoMapScreen> createState() =>
      _FootprintPhotoMapScreenState();
}

class _FootprintPhotoMapScreenState extends State<FootprintPhotoMapScreen> {
  List<PhotoMap> photoMapData = [];
  int userIdx = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getPhotoMap(userIdx),
      builder: (context, snapshot){
        if(snapshot.hasData == false){
          return const Center(child: CircularProgressIndicator(color: ColorFamily.pink,));
        }else if(snapshot.hasError){
          return const Center(child: Text("error"),);
        }else{
          photoMapData = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.builder(
                itemCount: photoMapData.length,
                itemBuilder: (context, index) => makePhotoMap(context, photoMapData[index])),
          );
        }
      },
    );
  }

  Widget makePhotoMap(BuildContext context, PhotoMap photoMap) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FootprintPhotoMapDetailScreen(photoMap)));
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 40,
          child: Card(
            color: ColorFamily.white,
            surfaceTintColor: ColorFamily.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Stack(
                children: [
                  Column(
                    children: [
                      FutureBuilder(
                        future: getPhotoMapImage(photoMap.mapSnapshot),
                        builder: (context, photoMapSnapshot){
                          if(photoMapSnapshot.hasData == false){
                            return const SizedBox();
                          }else if(photoMapSnapshot.hasError){
                            return const Center(child: Text("network error"),);
                          }else{
                            return SizedBox(
                                width: MediaQuery.of(context).size.width - 40 - 20,
                                height: MediaQuery.of(context).size.width - 40 - 20,
                                child: photoMapSnapshot.data
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 10,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 40 - 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              photoMap.mapName,
                              style: TextStyleFamily.normalTextStyle,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            InkWell(
                                splashColor: Colors.transparent,
                                onTap: () {
                                  _showMapSelectDialog(context, photoMap);
                                },
                                child: SvgPicture.asset(
                                    'lib/assets/icons/edit.svg'))
                          ],
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        setState(() {
                          _showDeleteDialog(context, photoMap);
                        });
                      },
                      child: SvgPicture.asset('lib/assets/icons/delete.svg'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showMapSelectDialog(BuildContext context, PhotoMap photoMap) {
    TextEditingController _controller = TextEditingController();
    String? _errorText;

    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, dialogState) {
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
                        Column(
                          children: [
                            const Text(
                              "포토 맵 이름 변경",
                              style: TextStyleFamily.dialogTitleTextStyle,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 40),
                              child: TextField(
                                controller: _controller,
                                style: TextStyleFamily.normalTextStyle,
                                keyboardType: TextInputType.text,
                                cursorColor: ColorFamily.black,
                                onChanged: (text) {
                                  dialogState(() {
                                    if (text.isEmpty) {
                                      _errorText = "제목을 입력해주세요";
                                    } else {
                                      _errorText = null;
                                    }
                                  });
                                },
                                decoration: InputDecoration(
                                    errorText: _errorText,
                                    errorStyle: const TextStyle(
                                        fontFamily: FontFamily.mapleStoryLight,
                                        fontSize: 14,
                                        color: Colors.red),
                                    hintText: "지도 제목을 입력해주세요",
                                    hintStyle: TextStyleFamily.hintTextStyle,
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: ColorFamily.black, width: 1.0),
                                    )),
                              ),
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
                                  dialogState(() {
                                    if(_controller.text.isNotEmpty){
                                      // 포토맵 이름 변경
                                      changePhotoMapName(photoMap.mapIdx, _controller.text);
                                      Navigator.pop(context); // 다이얼로그 팝
                                      setState(() {});
                                    }else{
                                      _errorText = "제목을 입력해주세요.";
                                    }
                                  });
                                },
                                child: const Text(
                                  "변경",
                                  style: TextStyleFamily
                                      .dialogButtonTextStyle_pink,
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
        });
  }

  void _showDeleteDialog(BuildContext context, PhotoMap photoMap) {
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
                        "포토맵을 삭제하시겠습니까?",
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
                                // 포토맵 삭제
                                deletePhotoMap(photoMap.mapIdx);
                                Navigator.pop(context); // 다이얼로그 팝
                                setState(() {});
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
}
