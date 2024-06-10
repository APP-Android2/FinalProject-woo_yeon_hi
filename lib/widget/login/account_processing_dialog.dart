import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/style/color.dart';

import '../../model/user_model.dart';
import '../../style/text_style.dart';

class AccountProcessingDialog extends StatefulWidget {
  const AccountProcessingDialog({super.key});

  @override
  State<AccountProcessingDialog> createState() =>
      _AccountProcessingDialogState();
}

class _AccountProcessingDialogState extends State<AccountProcessingDialog> {

  dynamic userProvider;
  @override
  void initState() {
    super.initState();
    userProvider = Provider.of<UserModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorFamily.white,
      child: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  children: [
                    Text(
                      "계정 삭제를 취소하시겠습니까?",
                      style: TextStyleFamily.dialogTitleTextStyle,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "보관된 데이터와 앱 설정으로 복구됩니다.",
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
                            overlayColor:
                                MaterialStateProperty.all(ColorFamily.gray)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "취소",
                          style: TextStyleFamily.dialogButtonTextStyle,
                        )),
                    TextButton(
                        style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.all(ColorFamily.gray)),
                        onPressed: () {
                          setState(() {
                            userProvider.userState = 0;
                          });
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Fluttertoast.showToast(
                              msg: "계정 복구가 완료되었습니다.\n다시 로그인 해주세요.",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 3,
                              backgroundColor: ColorFamily.black,
                              textColor: ColorFamily.white,
                              fontSize: 14.0
                          );
                        },
                        child: const Text(
                          "확인",
                          style: TextStyleFamily.dialogButtonTextStyle_pink,
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
}