import 'package:flutter/material.dart';
import 'package:woo_yeon_hi/dao/photo_map_dao.dart';
import 'package:woo_yeon_hi/model/enums.dart';
import 'package:woo_yeon_hi/model/photo_map_model.dart';
import 'package:woo_yeon_hi/screen/footPrint/footprint_photo_map_detail_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/style/text_style.dart';

class FootprintPhotoMapAddMapList extends StatefulWidget {
  const FootprintPhotoMapAddMapList({super.key});

  @override
  State<FootprintPhotoMapAddMapList> createState() =>
      _FootprintPhotoMapAddMapListState();
}

class _FootprintPhotoMapAddMapListState
    extends State<FootprintPhotoMapAddMapList> {
  final TextEditingController _controller = TextEditingController();
  String? _errorText;

  int user_idx = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: MapType.values.length,
        itemBuilder: (context, index) =>
            makeMap(context, MapType.fromType(index)!));
  }

  Widget makeMap(BuildContext context, MapType mapType) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () {
          _showMapSelectDialog(context, mapType);
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 40,
          child: Card(
            color: ColorFamily.white,
            surfaceTintColor: ColorFamily.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width - 40 - 30,
                      child: Image.asset(
                        mapType.path,
                        fit: BoxFit.cover,
                      )),
                  Text(
                    mapType.name,
                    style: TextStyleFamily.normalTextStyle,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showMapSelectDialog(BuildContext context, MapType mapType) {
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
                            Text(
                              mapType.name,
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
                                  _errorText = null;
                                  _controller.clear();
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
                                  dialogState(() async {
                                    if(_controller.text.isEmpty) {
                                      _errorText = "제목을 입력해주세요";
                                    } else {
                                      // 포토맵 추가
                                      var mapIdx = await getPhotoMapSequence() + 1;
                                      setPhotoMapSequence(mapIdx);
                                      var photoMap = PhotoMap(
                                          mapIdx: mapIdx,
                                          mapUserIdx: user_idx,
                                          mapType: mapType.type,
                                          mapName: _controller.text,
                                          mapSnapshot: "snapshot_${user_idx}_$mapIdx",
                                          mapState: PhotoMapState.STATE_NORMAL.state
                                      );
                                      addPhotoMap(photoMap);
                                      _errorText = null;
                                      _controller.clear();
                                      Navigator.pop(context); // 다이얼로그 팝
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => FootprintPhotoMapDetailScreen(photoMap.mapIdx, photoMap.mapName)));
                                    }

                                  });
                                },
                                child: const Text(
                                  "지도 생성",
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
}
