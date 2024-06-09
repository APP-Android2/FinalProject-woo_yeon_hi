import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/text_style.dart';

void showToast(String message){
  Fluttertoast.showToast(
      msg: message, //메세지입력
      toastLength: Toast.LENGTH_SHORT, //메세지를 보여주는 시간(길이)
      gravity: ToastGravity.BOTTOM, //위치지정
      timeInSecForIosWeb: 1, //ios및웹용 시간
      backgroundColor: ColorFamily.gray,
      textColor: ColorFamily.white, //글자색
      fontSize: 14.0 //폰트사이즈
  );
}

void dialogTitleWithContent(BuildContext context, String title, String content, VoidCallback onCancle, VoidCallback onConfirm){
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
                    Column(
                      children: [
                        Text(
                          title,
                          style: TextStyleFamily.dialogTitleTextStyle,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          content,
                          style: TextStyleFamily.normalTextStyle,
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
                            onPressed: onCancle,
                            child: const Text(
                              "취소",
                              style: TextStyleFamily.dialogButtonTextStyle,
                            )),
                        TextButton(
                            style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(
                                    ColorFamily.gray)),
                            onPressed: onConfirm,
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
      }
  );
}

void dialogOnlyTitle(){

}