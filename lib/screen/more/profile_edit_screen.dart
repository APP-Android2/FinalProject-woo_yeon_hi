import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/style/text_style.dart';
import 'package:woo_yeon_hi/widget/more/profile_edit_top_app_bar.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

import '../../main.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  DateTime _selectedDate = DateTime.now();
  DateTime birthday = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileEditTopAppBar(),
      body: Container(
        color: ColorFamily.cream,
        child: ListView(children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Container(
              child: Column(
                children: [
                  Container(
                    height: 230,
                    width: 200,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Material(
                          elevation: 1,
                          borderRadius: BorderRadius.circular(60),
                          child: InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(60),
                              splashColor: Colors.transparent,
                              child: Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(60),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'lib/assets/images/default_profile.png'))),
                              )),
                        ),
                        InkWell(
                          splashColor: ColorFamily.cream,
                          borderRadius: BorderRadius.circular(100),
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.fromLTRB(135, 115, 0, 0),
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
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 30),
                          child: Text("닉네임",
                              style: TextStyleFamily.normalTextStyle),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Material(
                            elevation: 0.5,
                            color: ColorFamily.white,
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                              height: 50,
                              width: 370,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                              child:
                              TextFormField(
                                style: TextStyleFamily.smallTitleTextStyle,
                                initialValue: '멋쟁이사자',
                                decoration: InputDecoration(border: InputBorder.none))
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Container(
                          padding: EdgeInsets.only(left: 30),
                          child: Text("생년월일",
                              style: TextStyleFamily.normalTextStyle),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            SizedBox(width: 20),
                            Material(
                              elevation: 0.5,
                              color: ColorFamily.white,
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                height: 50,
                                width: 370,
                                decoration: BoxDecoration(
                                    color: ColorFamily.white,
                                    borderRadius: BorderRadius.circular(15)),
                                child: InkWell(
                                  splashColor: ColorFamily.cream,
                                  onTap: () {
                                    showMaterialModalBottomSheet(
                                        backgroundColor: ColorFamily.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(20),
                                                topLeft: Radius.circular(20))),
                                        context: context,
                                        builder: (context) => Container(
                                            color: ColorFamily.white,
                                            height: 410,
                                            child: Column(children: [
                                              Container(
                                                color: ColorFamily.white,
                                                height: 350,
                                                child: ScrollDatePicker(
                                                  options: DatePickerOptions(
                                                      isLoop: false),
                                                  selectedDate: _selectedDate,
                                                  locale: Locale('ko'),
                                                  scrollViewOptions:
                                                      DatePickerScrollViewOptions(
                                                          year:
                                                              ScrollViewDetailOptions(
                                                            textStyle:
                                                                TextStyleFamily
                                                                    .passwordTextStyle,
                                                            selectedTextStyle:
                                                                TextStyleFamily
                                                                    .passwordTextStyle,
                                                            label: '년',
                                                            margin:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right: 50),
                                                          ),
                                                          month:
                                                              ScrollViewDetailOptions(
                                                            textStyle:
                                                                TextStyleFamily
                                                                    .passwordTextStyle,
                                                            selectedTextStyle:
                                                                TextStyleFamily
                                                                    .passwordTextStyle,
                                                            label: '월',
                                                            margin:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right: 50),
                                                          ),
                                                          day:
                                                              ScrollViewDetailOptions(
                                                            textStyle:
                                                                TextStyleFamily
                                                                    .passwordTextStyle,
                                                            selectedTextStyle:
                                                                TextStyleFamily
                                                                    .passwordTextStyle,
                                                            label: '일',
                                                          )),
                                                  onDateTimeChanged:
                                                      (DateTime value) {
                                                    setState(() {
                                                      birthday = value;
                                                    });
                                                  },
                                                ),
                                              ),
                                              Material(
                                                color: ColorFamily.beige,
                                                elevation: 0.5,
                                                shadowColor: Colors.black,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                                child: InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        _selectedDate =
                                                            birthday;
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                    child: Container(
                                                        width: 380,
                                                        height: 40,
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            "확인",
                                                            style: TextStyleFamily
                                                                .normalTextStyle,
                                                          ),
                                                        ))),
                                              ),
                                              Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 20))
                                            ])));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
                                        height: 30,
                                        width: 200,
                                        child: Container(
                                          child: Text(
                                            DateFormat('yyyy. M. d.')
                                                .format(_selectedDate),
                                            style: TextStyleFamily
                                                .smallTitleTextStyle,
                                          ),
                                        )),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: 30),
                        Container(
                          padding: EdgeInsets.only(left: 30),
                          child: Text("상태 메시지",
                              style: TextStyleFamily.normalTextStyle),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Material(
                            elevation: 0.5,
                            color: ColorFamily.white,
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                height: 110,
                                width: 370,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                                child:
                                  TextFormField(
                                    style: TextStyleFamily.smallTitleTextStyle,
                                    initialValue: '뒤돌아보지 않을게 바다가 보이는 집에서 평생을 살게 뒤돌아 보지 않을게 바다가 보이는 집에서 평생을 살게 바',
                                    maxLines: 3,
                                    maxLength: 60,
                                    decoration: InputDecoration(border: InputBorder.none, counter: SizedBox()),
                                )
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
