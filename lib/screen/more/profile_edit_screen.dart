import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/screen/more/more_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/text_style.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:woo_yeon_hi/utils.dart';

import '../../dao/user_dao.dart';
import '../../model/user_model.dart';
import '../../style/font.dart';
import '../../widget/more/profile_edit_album.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  DateTime _selectedDate = DateTime.now();
  static const storage = FlutterSecureStorage();

  TextEditingController? userNicknameTextEditController;
  TextEditingController? profileMessageTextEditController;
  dynamic userProvider;
  late String userAccount = "";
  late String tempUserNickname = "";
  late String tempProfileMsg = "";
  late String tempProfileImage = "lib/assets/images/default_profile.png";
  late String tempUserBirth = dateToString(DateTime.now());
  bool _isLoading = true; // Loading 상태를 나타내는 변수

  @override
  void initState() {
    super.initState();

    userProvider = Provider.of<UserModel>(context, listen: false);
    _asyncMethod();
  }

  _asyncMethod() async {
    userAccount = (await storage.read(key: "loginAccount"))!;
    tempUserNickname = await getSpecificUserData(userAccount, 'user_nickname');
    tempProfileMsg = await getSpecificUserData(userAccount, 'profile_message');
    tempProfileImage =
    await getSpecificUserData(userAccount, 'user_profileImage');
    tempUserBirth = await getSpecificUserData(userAccount, 'user_birth');
    userNicknameTextEditController =
        TextEditingController(text: tempUserNickname);
    profileMessageTextEditController =
        TextEditingController(text: tempProfileMsg);

    setState(() {
      _isLoading = false; // 데이터 로드가 완료되면 로딩 상태를 false로 설정
    });
  }

  @override
  void dispose() {
    userNicknameTextEditController?.dispose();
    profileMessageTextEditController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;

    if (_isLoading) {
      // 로딩 중인 상태를 표시
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          surfaceTintColor: ColorFamily.cream,
          backgroundColor: ColorFamily.cream,
          centerTitle: true,
          title: const Text(
            "프로필 관리",
            style: TextStyleFamily.appBarTitleLightTextStyle,
          ),
          leading: IconButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
              Future.delayed(const Duration(milliseconds: 100), () {
                Navigator.pop(context);
              });
            },
            icon: SvgPicture.asset('lib/assets/icons/arrow_back.svg'),
          ),
          actions: [
            IconButton(
              onPressed: () {
                FocusScope.of(context).unfocus();

                if (userProvider.checkProvider(userNicknameTextEditController)) {
                  FocusScope.of(context).unfocus();
                  Future.delayed(const Duration(milliseconds: 100), () async {
                    await updateSpecificUserData(
                        userAccount, 'user_nickname', tempUserNickname);
                    await updateSpecificUserData(userAccount, 'user_birth', tempUserBirth);
                    await updateSpecificUserData(
                        userAccount, 'profile_message', tempProfileMsg);
                    await updateSpecificUserData(
                        userAccount, 'user_profileImage', tempProfileImage);
                  });

                  Future.delayed(const Duration(milliseconds: 100), () {
                    Navigator.pop(context);
                    Fluttertoast.showToast(
                      msg: "프로필이 저장되었습니다.",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.TOP_LEFT,
                      timeInSecForIosWeb: 1,
                      backgroundColor: ColorFamily.black,
                      textColor: ColorFamily.white,
                      fontSize: 14.0,
                    );
                  });
                } else {
                  FocusScope.of(context).unfocus();
                  Fluttertoast.showToast(
                    msg: "닉네임을 입력해주세요!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: ColorFamily.pink,
                    textColor: ColorFamily.white,
                    fontSize: 14.0,
                  );
                }
              },
              icon: SvgPicture.asset('lib/assets/icons/done.svg'),
            )
          ],
        ),
        body: Container(
          width: deviceWidth,
          height: deviceHeight,
          color: ColorFamily.cream,
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              Column(
                children: [
                  Column(
                    children: [
                      Stack(
                        children: [
                          Material(
                            elevation: 1,
                            borderRadius: BorderRadius.circular(65),
                            child: InkWell(
                              onTap: () {
                                userProvider.image != null
                                    ? showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        child: Container(
                                          width: deviceWidth * 0.8,
                                          height: deviceHeight * 0.6,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: FileImage(
                                                  File(userProvider
                                                      .image!.path)),
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                      );
                                    })
                                    : null;
                              },
                              borderRadius: BorderRadius.circular(65),
                              splashColor: Colors.transparent,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(65),
                                child: userProvider.image != null
                                    ? Image.file(
                                  File(userProvider.image!.path),
                                  width: deviceWidth * 0.35,
                                  height: deviceWidth * 0.35,
                                  fit: BoxFit.cover,
                                )
                                    : Image.asset(
                                  tempProfileImage,
                                  width: deviceWidth * 0.35,
                                  height: deviceWidth * 0.35,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: deviceWidth * 0.25,
                            left: deviceWidth * 0.26,
                            child: const ProfileEditAlbum()
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                  const SizedBox(height: 40),
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "닉네임",
                        style: TextStyleFamily.normalTextStyle,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    width: deviceWidth - 60,
                    child: Material(
                      elevation: 0.5,
                      color: ColorFamily.white,
                      borderRadius: BorderRadius.circular(15),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: TextFormField(
                          onChanged: (value) {
                            tempUserNickname = value;
                          },
                          onFieldSubmitted: (value) {
                            tempUserNickname = value;
                          },
                          controller: userNicknameTextEditController,
                          onTapOutside: (event) {
                            FocusScope.of(context).unfocus();
                          },
                          style: TextStyleFamily.smallTitleTextStyle,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "생년월일",
                        style: TextStyleFamily.normalTextStyle,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    width: deviceWidth - 60,
                    child: Material(
                      elevation: 0.5,
                      color: ColorFamily.white,
                      borderRadius: BorderRadius.circular(15),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        onTap: () {
                          picker.DatePicker.showDatePicker(
                            context,
                            showTitleActions: true,
                            minTime: DateTime(1900, 1, 1),
                            maxTime: DateTime.now(),
                            theme: const picker.DatePickerTheme(
                              titleHeight: 60,
                              containerHeight: 300,
                              itemHeight: 50,
                              headerColor: ColorFamily.white,
                              backgroundColor: ColorFamily.white,
                              itemStyle: TextStyleFamily.smallTitleTextStyle,
                              cancelStyle: TextStyle(
                                color: ColorFamily.black,
                                fontSize: 18,
                                fontFamily: FontFamily.mapleStoryLight,
                              ),
                              doneStyle: TextStyle(
                                color: ColorFamily.black,
                                fontSize: 18,
                                fontFamily: FontFamily.mapleStoryLight,
                              ),
                            ),
                            onConfirm: (date) {
                              setState(() {
                                _selectedDate = date;
                                tempUserBirth = dateToString(_selectedDate);
                              });
                            },
                            currentTime: DateTime.now(),
                            locale: picker.LocaleType.ko,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              tempUserBirth,
                              style: TextStyleFamily.smallTitleTextStyle,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "상태 메시지",
                        style: TextStyleFamily.normalTextStyle,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 100,
                    width: deviceWidth - 60,
                    child: Material(
                      elevation: 0.5,
                      color: ColorFamily.white,
                      borderRadius: BorderRadius.circular(15),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: TextFormField(
                          onChanged: (value) {
                            setState(() {
                              tempProfileMsg = value;
                            });
                          },
                          onFieldSubmitted: (value) {
                            tempProfileMsg = value;
                          },
                          controller: profileMessageTextEditController,
                          maxLines: 4,
                          maxLength: 60,
                          onTapOutside: (event) {
                            FocusScope.of(context).unfocus();
                          },
                          style: TextStyleFamily.smallTitleTextStyle,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            counter: SizedBox(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }
}
