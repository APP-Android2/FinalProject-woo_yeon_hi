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
import '../../dialogs.dart';
import '../../provider/login_register_provider.dart';
import '../../style/font.dart';
import '../../widget/more/profile_edit_album.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final FocusNode _nickNamefocusNode = FocusNode();
  final FocusNode _profileMsgfocusNode = FocusNode();

  late String tempProfileImage;
  late String tempUserNickname;
  late String tempProfileMsg;
  late String tempUserBirth;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _tempDataInitiate();
  }

  Future<void> _tempDataInitiate() async {
    var provider = Provider.of<UserProvider>(context, listen: false);
    tempProfileImage = provider.userProfileImage;
    tempUserNickname = provider.userNickname;
    tempProfileMsg = provider.profileMsg;
    tempUserBirth = provider.userBirth;
    _selectedDate = stringToDate(tempUserBirth);
  }

  @override
  void dispose() {
    _nickNamefocusNode.dispose();
    _profileMsgfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;

    return Consumer<UserProvider>(builder: (context, provider, child) {
      return PopScope(
          canPop: false,
          onPopInvoked: (didPop) async {
            if (didPop) {
              return;
            }
            if (tempProfileImage != provider.userProfileImage ||
                tempUserNickname != provider.userNickname ||
                tempUserBirth != provider.userBirth ||
                tempProfileMsg != provider.profileMsg) {
              dialogTitleWithContent(
                context, "프로필 편집 취소", "변경사항은 저장되지 않습니다.",
                    () {
                  Navigator.pop(context, false);
                  _nickNamefocusNode.unfocus();
                  _profileMsgfocusNode.unfocus();
                  },
                    () {
                  Navigator.pop(context, true);
                  _nickNamefocusNode.unfocus();
                  _profileMsgfocusNode.unfocus();
                  Future.delayed(const Duration(milliseconds: 100), () {
                  Navigator.of(context).pop();
                  });
              });
            } else {
              FocusScope.of(context).unfocus();
              Navigator.of(context).pop();
            }
          },
          child: Scaffold(
            appBar: AppBar(
              surfaceTintColor: ColorFamily.cream,
              backgroundColor: ColorFamily.cream,
              centerTitle: true,
              title: const Text(
                "프로필 편집",
                style: TextStyleFamily.appBarTitleLightTextStyle,
              ),
              leading: IconButton(
                onPressed: () {
                  if (tempProfileImage != provider.userProfileImage ||
                      tempUserNickname != provider.userNickname ||
                      tempUserBirth != provider.userBirth ||
                      tempProfileMsg != provider.profileMsg) {
                    dialogTitleWithContent(
                        context, "프로필 편집 취소", "변경사항은 저장되지 않습니다.",
                            () {
                          Navigator.pop(context, false);
                          _nickNamefocusNode.unfocus();
                          _profileMsgfocusNode.unfocus();
                        },
                            () {
                          Navigator.pop(context, true);
                          _nickNamefocusNode.unfocus();
                          _profileMsgfocusNode.unfocus();
                          Future.delayed(const Duration(milliseconds: 100), () {
                            Navigator.of(context).pop();
                          });
                        });
                  } else {
                    FocusScope.of(context).unfocus();
                    Navigator.of(context).pop();
                  }
                },
                icon: SvgPicture.asset('lib/assets/icons/arrow_back.svg'),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (tempUserNickname.isNotEmpty) {
                      provider.setUserProfile(tempProfileImage,
                          tempUserNickname, tempUserBirth, tempProfileMsg);
                      FocusScope.of(context).unfocus();
                      Future.delayed(const Duration(milliseconds: 100),
                          () async {
                        await updateSpecificUserData(provider.userIdx,
                            'user_profile_image', tempProfileImage);
                        await updateSpecificUserData(provider.userIdx,
                            'user_nickname', tempUserNickname);
                        await updateSpecificUserData(
                            provider.userIdx, 'user_birth', tempUserBirth);
                        await updateSpecificUserData(provider.userIdx,
                            'profile_message', tempProfileMsg);
                      });

                      Future.delayed(const Duration(milliseconds: 100), () {
                        Navigator.pop(context);
                        showPinkSnackBar(context, '프로필이 저장되었습니다!');
                      });
                    } else {
                      FocusScope.of(context).unfocus();
                      showBlackToast("닉네임을 입력해주세요!");
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
                                    provider.image != null
                                        ? showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Dialog(
                                                child: Container(
                                                  width: deviceWidth * 0.8,
                                                  height: deviceHeight * 0.6,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: FileImage(File(
                                                          provider
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
                                    child: provider.image != null
                                        ? Image.file(
                                            File(provider.image!.path),
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
                                  child: const ProfileEditAlbum()),
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
                              autofocus: false,
                              focusNode: _nickNamefocusNode,
                              maxLength: 10,
                              initialValue: tempUserNickname,
                              onChanged: (value) {
                                tempUserNickname = value;
                              },
                              onFieldSubmitted: (value) {
                                tempUserNickname = value;
                              },
                              onTapOutside: (event) {
                                FocusScope.of(context).unfocus();
                              },
                              style: TextStyleFamily.smallTitleTextStyle,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  counter: SizedBox()),
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
                                  itemStyle:
                                      TextStyleFamily.smallTitleTextStyle,
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
                                locale: picker.LocaleType.ko,
                                currentTime: _selectedDate,
                                onConfirm: (date) {
                                  setState(() {
                                    _selectedDate = date;
                                    tempUserBirth = dateToString(_selectedDate);
                                  });
                                  _nickNamefocusNode.unfocus();
                                  _profileMsgfocusNode.unfocus();
                                },
                                onCancel: () {
                                  _nickNamefocusNode.unfocus();
                                  _profileMsgfocusNode.unfocus();
                                },
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
                              focusNode: _profileMsgfocusNode,
                              initialValue: tempProfileMsg,
                              onChanged: (value) {
                                setState(() {
                                  tempProfileMsg = value;
                                });
                              },
                              onFieldSubmitted: (value) {
                                tempProfileMsg = value;
                              },
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
          ));
    });
  }
}
