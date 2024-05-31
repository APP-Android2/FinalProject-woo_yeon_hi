import 'package:flutter/material.dart';
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
  List<String> mapImageList = [
    'lib/assets/images/korea_seoul.png',
    'lib/assets/images/korea_full.png'
  ];
  List<String> mapNameList = ["서울", "대한민국"];

  TextEditingController _controller = TextEditingController();
  String? _errorText;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: mapNameList.length,
        itemBuilder: (context, index) =>
            makeMap(context, mapImageList[index], mapNameList[index]));
  }

  Widget makeMap(BuildContext context, String mapImage, String mapName) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () {
          _showMapSelectDialog(context, mapName);
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
                        mapImage,
                        fit: BoxFit.fitWidth,
                      )),
                  Text(
                    mapName,
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

  void _showMapSelectDialog(BuildContext context, String mapName) {
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
                              mapName,
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
                                    setState(() {
                                      if (text.isEmpty) {
                                        _errorText = "제목을 입력해주세요";
                                      } else {
                                        _errorText = null;
                                      }
                                    });
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
                                  Navigator.pop(context); // 다이얼로그 팝
                                  Navigator.pop(context); // 지도 추가 페이지 팝
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
