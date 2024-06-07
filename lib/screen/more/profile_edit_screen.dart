import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/text_style.dart';
import 'package:woo_yeon_hi/widget/more/profile_edit_top_app_bar.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
as picker;

import '../../style/font.dart';
class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  DateTime _selectedDate = DateTime.now();
  DateTime _birthday = DateTime.now();

  late String userName;
  late String userNickName;
  late String profileMsg;

  @override
  void initState() {
    super.initState();

    userName = "김멋사"; // 유저 이름 가져오기
    userNickName = "멋쟁이사자"; // 유저 닉네임 가져오기
    profileMsg = "너와 함께할 때 가장 행복해!"; // 유저 상태 메시지 가져오기
  }


  @override
  Widget build(BuildContext context) {

    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const ProfileEditTopAppBar(),
      body: Container(
        width: deviceWidth,
        height: deviceHeight,
        color: ColorFamily.cream,
        padding: const EdgeInsets.all(20),
        child: ListView(children: [
          Column(children: [
              Column(
                children: [
                  Stack(
                    children: [
                      Material(
                        elevation: 1,
                        borderRadius: BorderRadius.circular(65),
                        child: InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(65),
                            splashColor: Colors.transparent,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(65),
                              child: Image.asset(
                                'lib/assets/images/default_profile.png',
                                width: deviceWidth * 0.35,
                                height: deviceWidth * 0.35,
                              ), // Text(key['title']),
                            ),
                        ),
                      ),
                      Positioned(
                        top: deviceWidth * 0.25,
                        left: deviceWidth * 0.26,
                        child: InkWell(
                          splashColor: ColorFamily.cream,
                          borderRadius: BorderRadius.circular(100),
                          onTap: () {},
                          child: Container(
                            height: 36,
                            width: 36,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: ColorFamily.white,
                                border: Border.all(
                                    width: 0.1, color: ColorFamily.gray)),
                            child: SvgPicture.asset(
                              'lib/assets/icons/gallery.svg',
                              width: 20,
                              height: 20,
                              fit: BoxFit.none,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(userName, style: TextStyleFamily.smallTitleTextStyle)
                ],
              ),
              const SizedBox(height: 40),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("닉네임",
                      style: TextStyleFamily.normalTextStyle),
                ),
              ),
              const SizedBox(height: 10),
            SizedBox(
              height: 50,
              width: deviceWidth-60,
              child: Material(
                    elevation: 0.5,
                    color: ColorFamily.white,
                    borderRadius: BorderRadius.circular(15),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: TextFormField(
                          onTapOutside: (event) {
                            FocusScope.of(context).unfocus();
                          },
                          style: TextStyleFamily.smallTitleTextStyle,
                          initialValue: userNickName,
                          decoration: const InputDecoration(border: InputBorder.none)),
                      )
                    ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("생년월일",
                    style: TextStyleFamily.normalTextStyle),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 50,
              width: deviceWidth-60,
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
                              backgroundColor:
                              ColorFamily.white,
                              itemStyle: TextStyleFamily
                                  .smallTitleTextStyle,
                              cancelStyle: TextStyle(
                                  color: ColorFamily.black,
                                  fontSize: 18,
                                  fontFamily: FontFamily
                                      .mapleStoryLight),
                              doneStyle: TextStyle(
                                  color: ColorFamily.black,
                                  fontSize: 18,
                                  fontFamily: FontFamily
                                      .mapleStoryLight)),
                          // onChanged: (date) {
                          //   print('change $date in time zone ' +
                          //    date.timeZoneOffset.inHours.toString());
                          // },
                          onConfirm: (date) {
                            setState(() {
                              _selectedDate = date;
                              _birthday = _selectedDate;
                            });
                          },
                          // onCancel: (){},
                          currentTime: DateTime.now(),
                          locale: picker.LocaleType.ko);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          DateFormat('yyyy. M. d.')
                              .format(_birthday),
                          style: TextStyleFamily
                              .smallTitleTextStyle,
                        ),
                      ),
                    ),
                  )
              ),
            ),

              const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("상태 메시지",
                    style: TextStyleFamily.normalTextStyle),
              ),
            ),
              const SizedBox(height: 10),
            SizedBox(
              height: 100,
              width: deviceWidth-60,
              child: Material(
                  elevation: 0.5,
                  color: ColorFamily.white,
                  borderRadius: BorderRadius.circular(15),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: TextFormField(
                        maxLines: 3,
                        maxLength: 60,
                        onTapOutside: (event) {
                          FocusScope.of(context).unfocus();
                        },
                        style: TextStyleFamily.smallTitleTextStyle,
                        initialValue: profileMsg,
                        decoration: const InputDecoration(border: InputBorder.none, counter: SizedBox())),
                  )
              ),
            ),
            ],
          ),
        ]),
      ),
    );
  }
}
