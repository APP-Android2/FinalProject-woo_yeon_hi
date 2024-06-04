import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/style/text_style.dart';
import 'package:woo_yeon_hi/widget/ledger/ledger_top_app_bar.dart';

class LedgerWriteScreen extends StatefulWidget {
  const LedgerWriteScreen({super.key});

  @override
  State<LedgerWriteScreen> createState() => _LedgerWriteScreenState();
}

class _LedgerWriteScreenState extends State<LedgerWriteScreen> {
  // 날짜 설정
  late String _dateSetting;

  // 요일 변환
  String _getWeekday(int weekday) {
    const weekdays = ['월', '화', '수', '목', '금', '토', '일'];
    return weekdays[weekday - 1];
  }

  // 지출, 수입 버튼 상태
  List<bool> selectTypeState = [true, false];

  // 현재 선택된 탭의 인덱스를 저장
  int selectedIndex = 0;

  // 각 탭의 위젯들
  List<Widget> widgetsSample = [
    Container(
      child: Material(
        color: Colors.transparent,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    print('식비 터치');
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        SvgPicture.asset('lib/assets/icons/spoon_fork.svg'),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Text('식비',
                            style: TextStyle(
                                color: ColorFamily.black,
                                fontSize: 10,
                                fontFamily: FontFamily.mapleStoryLight)),
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 40)),
                InkWell(
                  onTap: () {
                    print('식비 터치');
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        SvgPicture.asset('lib/assets/icons/coffee_cup.svg'),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Text('카페',
                            style: TextStyle(
                                color: ColorFamily.black,
                                fontSize: 10,
                                fontFamily: FontFamily.mapleStoryLight))
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 40)),
                InkWell(
                  onTap: () {
                    print('식비 터치');
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        SvgPicture.asset('lib/assets/icons/bus.svg'),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Text('교통',
                            style: TextStyle(
                                color: ColorFamily.black,
                                fontSize: 10,
                                fontFamily: FontFamily.mapleStoryLight))
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 40)),
                InkWell(
                  onTap: () {
                    print('식비 터치');
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        SvgPicture.asset('lib/assets/icons/shopping_cart.svg'),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Text('쇼핑',
                            style: TextStyle(
                                color: ColorFamily.black,
                                fontSize: 10,
                                fontFamily: FontFamily.mapleStoryLight))
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    print('식비 터치');
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                            'lib/assets/icons/culture_popcorn.svg'),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Text('문화',
                            style: TextStyle(
                                color: ColorFamily.black,
                                fontSize: 10,
                                fontFamily: FontFamily.mapleStoryLight))
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 40)),
                InkWell(
                  onTap: () {
                    print('식비 터치');
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        SvgPicture.asset('lib/assets/icons/hobby_puzzle.svg'),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Text('취미',
                            style: TextStyle(
                                color: ColorFamily.black,
                                fontSize: 10,
                                fontFamily: FontFamily.mapleStoryLight))
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 40)),
                InkWell(
                  onTap: () {
                    print('식비 터치');
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        SvgPicture.asset('lib/assets/icons/lover.svg'),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Text('데이트',
                            style: TextStyle(
                                color: ColorFamily.black,
                                fontSize: 10,
                                fontFamily: FontFamily.mapleStoryLight))
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 40)),
                InkWell(
                  onTap: () {
                    print('식비 터치');
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        SvgPicture.asset('lib/assets/icons/game.svg'),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Text('오락',
                            style: TextStyle(
                                color: ColorFamily.black,
                                fontSize: 10,
                                fontFamily: FontFamily.mapleStoryLight))
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    print('식비 터치');
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        SvgPicture.asset('lib/assets/icons/travel.svg'),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Text('여행',
                            style: TextStyle(
                                color: ColorFamily.black,
                                fontSize: 10,
                                fontFamily: FontFamily.mapleStoryLight))
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 40)),
                InkWell(
                  onTap: () {
                    print('식비 터치');
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        SvgPicture.asset('lib/assets/icons/maintain_home.svg'),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Text('주거',
                            style: TextStyle(
                                color: ColorFamily.black,
                                fontSize: 10,
                                fontFamily: FontFamily.mapleStoryLight))
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 40)),
                InkWell(
                  onTap: () {
                    print('식비 터치');
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        SvgPicture.asset('lib/assets/icons/life_leaf.svg'),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Text('생활',
                            style: TextStyle(
                                color: ColorFamily.black,
                                fontSize: 10,
                                fontFamily: FontFamily.mapleStoryLight))
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 40)),
                InkWell(
                  onTap: () {
                    print('식비 터치');
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        SvgPicture.asset('lib/assets/icons/etc_more.svg'),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Text('기타',
                            style: TextStyle(
                                color: ColorFamily.black,
                                fontSize: 10,
                                fontFamily: FontFamily.mapleStoryLight))
                      ],
                    ),
                  ),
                ),
              ],
            ),
            //SizedBox(height: 15),
          ],
        ),
      ),
    ),
    Container(
      child: Material(
        color: Colors.transparent,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    print('식비 터치');
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          'lib/assets/icons/money_deposit.svg',
                          width: 40,
                          height: 40,
                        ),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Text('입금',
                            style: TextStyle(
                                color: ColorFamily.black,
                                fontSize: 10,
                                fontFamily: FontFamily.mapleStoryLight))
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 40)),
                InkWell(
                  onTap: () {
                    print('식비 터치');
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          'lib/assets/icons/income_add.svg',
                          width: 40,
                          height: 40,
                        ),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Text('부수입',
                            style: TextStyle(
                                color: ColorFamily.black,
                                fontSize: 10,
                                fontFamily: FontFamily.mapleStoryLight))
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 40)),
                InkWell(
                  onTap: () {
                    print('식비 터치');
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          'lib/assets/icons/income_bonus.svg',
                          width: 40,
                          height: 40,
                        ),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Text('보너스',
                            style: TextStyle(
                                color: ColorFamily.black,
                                fontSize: 10,
                                fontFamily: FontFamily.mapleStoryLight))
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 40)),
                InkWell(
                  onTap: () {
                    print('식비 터치');
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        SvgPicture.asset('lib/assets/icons/etc_more.svg'),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Text('기타',
                            style: TextStyle(
                                color: ColorFamily.black,
                                fontSize: 10,
                                fontFamily: FontFamily.mapleStoryLight))
                      ],
                    ),
                  ),
                ),
              ],
            ),
            //SizedBox(height: 15),
          ],
        ),
      ),
    ),
  ];

  // GlobalKey
  final _formKey = GlobalKey<FormState>();

  // 각 입력 필드별 Key
  final _priceKey = GlobalKey<FormFieldState>();
  final _titleKey = GlobalKey<FormFieldState>();
  final _memoKey = GlobalKey<FormFieldState>();

  // 입력 요소들과 연결될 컨트롤러
  TextEditingController priceController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController memoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 텍스트 변경 시 숫자 형식을 지정하기 위해 컨트롤러에 리스너를 추가
    priceController.addListener(_formatNumber);

    // 오늘 날짜로 지정
    final now = DateTime.now();
    _dateSetting =
        '${now.year}. ${now.month}. ${now.day}.\(${_getWeekday(now.weekday)}\) ${now.hour}:${now.minute}';
  }

  // DatePicker 기능
  void _showDateTimePicker() {
    DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(2020, 1, 1),
      maxTime: DateTime(2030, 12, 31),
      onConfirm: (date) {
        setState(() {
          _dateSetting =
              '${date.year}. ${date.month}. ${date.day}.\(${_getWeekday(date.weekday)}\) ${date.hour}:${date.minute}';
        });
      },
      currentTime: DateTime.now(),
      locale: LocaleType.ko,
    );
  }

  void _formatNumber() {
    // 숫자가 아닌 문자를 모두 제거 (쉼표 제외).
    String text = priceController.text.replaceAll(RegExp(r'[^0-9]'), '');

    // 텍스트가 비어 있으면 컨트롤러 값을 빈 텍스트로 설정하고 커서 위치를 재설정한다.
    if (text.isEmpty) {
      priceController.value = TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
      return;
    }

    // 숫자를 쉼표로 형식 지정
    // 텍스트를 정수 값으로 구문 분석한다.
    int value = int.tryParse(text) ?? 0;

    // NumberFormat을 사용하여 쉼표로 숫자 형식 지정
    final formatter = NumberFormat('#,###');
    String formatted = formatter.format(value);

    // 문자 요소 뒤에 "원" 붙이기
    priceController.value = TextEditingValue(
      text: '$formatted원',
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  @override
  void dispose() {
    // 컨트롤러를 제거할 때 리스너를 제거
    priceController.removeListener(_formatNumber);
    // 컨트롤러를 제거 하여 리소스 확보
    priceController.dispose();
    titleController.dispose();
    memoController.dispose();
    super.dispose();
  }

  // GlobalKey를 사용하여 2개의 필드 유효성 검사
  bool validateFieldsCheck() {
    return _titleKey.currentState!.validate() &
        _priceKey.currentState!.validate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 앱바
      appBar: LedgerTopAppBar(
        title: '가계부 작성',
        leading: IconButton(
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
          icon: SvgPicture.asset('lib/assets/icons/arrow_back.svg'),
        ),
      ),
      // 전체 배경색
      backgroundColor: ColorFamily.cream,
      body: Container(
          width: double.infinity,
          child: SingleChildScrollView(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
              padding: EdgeInsets.only(top: 30),
              child: InkWell(
                // 클릭 제스처 투명
                splashColor: Colors.transparent,
                onTap: () {
                  _showDateTimePicker();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(_dateSetting,
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: FontFamily.mapleStoryLight,
                            color: ColorFamily.gray)),
                    SizedBox(width: 7),
                    SvgPicture.asset('lib/assets/icons/calendar.svg',
                        color: ColorFamily.gray),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(30, 20, 0, 0),
              width: 220,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    key: _priceKey,
                    controller: priceController,
                    style: TextStyle(
                        color: ColorFamily.black,
                        fontSize: 30,
                        fontFamily: FontFamily.mapleStoryLight),
                    // 커서 숨김
                    showCursor: false,
                    // 키보드 타입
                    keyboardType: TextInputType.number,
                    maxLength: 7,
                    decoration: InputDecoration(
                        hintText: '금액을 입력하세요',
                        hintStyle: TextStyle(
                            color: ColorFamily.gray,
                            fontSize: 20,
                            fontFamily: FontFamily.mapleStoryLight),
                        border: InputBorder.none,
                        counterText: ''),
                    inputFormatters: [
                      // 숫자만 입력 할 수 있도록.
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '금액 입력은 필수입니다.';
                      }
                      // if (!RegExp(r'^\d+$').hasMatch(value)) {
                      //   return '유효한 데이터를 입력하세요';
                      // }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 50),
                    child: ToggleButtons(
                      isSelected: selectTypeState,
                      constraints:
                          BoxConstraints(minWidth: 90.0, minHeight: 40.0),
                      borderRadius: BorderRadius.circular(5.0),
                      // 기본 배경색
                      color: ColorFamily.white,
                      // 클릭 된 배경색
                      fillColor: ColorFamily.pink,
                      onPressed: (int index) {
                        setState(() {
                          for (int i = 0; i < selectTypeState.length; i++) {
                            selectTypeState[i] = i == index;
                          }
                          // 선택한 인덱스를 업데이트
                          selectedIndex = index;
                        });
                      },
                      children: [
                        Text('지출',
                            style: TextStyle(
                                color: selectTypeState[0]
                                    ? ColorFamily.white
                                    : ColorFamily.gray,
                                fontSize: 14,
                                fontFamily: FontFamily.mapleStoryLight)),
                        Text('수입',
                            style: TextStyle(
                                color: selectTypeState[0]
                                    ? ColorFamily.gray
                                    : ColorFamily.white,
                                fontSize: 14,
                                fontFamily: FontFamily.mapleStoryLight)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Container(
              color: ColorFamily.white,
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('타이틀',
                            style: TextStyle(
                                color: ColorFamily.black,
                                fontSize: 20,
                                fontFamily: FontFamily.mapleStoryLight)),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: TextFormField(
                            key: _titleKey,
                            controller: titleController,
                            maxLength: 20,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                hintText: '타이틀을 입력하세요. (20자 이내)',
                                hintStyle: TextStyle(
                                    color: ColorFamily.gray,
                                    fontSize: 14,
                                    fontFamily: FontFamily.mapleStoryLight),
                                border: InputBorder.none,
                                counterText: ''),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '타이틀 입력은 필수입니다.';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 30),
                        Text('카테고리',
                            style: TextStyle(
                                color: ColorFamily.black,
                                fontSize: 20,
                                fontFamily: FontFamily.mapleStoryLight)),
                        Container(
                          //decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.red)),
                          padding: EdgeInsets.only(top: 10),
                          child: widgetsSample[selectedIndex],
                        ),
                        SizedBox(height: 30),
                        Text('메모',
                            style: TextStyle(
                                color: ColorFamily.black,
                                fontSize: 20,
                                fontFamily: FontFamily.mapleStoryLight)),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: TextFormField(
                            key: _memoKey,
                            controller: memoController,
                            maxLines: 5,
                            maxLength: 500,
                            decoration: InputDecoration(
                              hintText: '메모를 입력하세요. (선택사항)',
                              hintStyle: TextStyle(
                                  color: ColorFamily.gray,
                                  fontSize: 14,
                                  fontFamily: FontFamily.mapleStoryLight,
                                  decorationThickness: 0),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    color: ColorFamily.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 취소 버튼
                        Expanded(
                          child: Container(
                            height: 40,
                            child: Material(
                              color: ColorFamily.white,
                              elevation: 1,
                              shadowColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                borderRadius: BorderRadius.circular(20.0),
                                child: Container(
                                  height: 40,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "취소",
                                    style: TextStyleFamily.normalTextStyle,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Container(
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(15),
                        //     boxShadow: [
                        //       BoxShadow(
                        //         // 그림자 색상
                        //         color: Colors.black.withOpacity(0.3),
                        //         // 그림자 오프셋 (x, y)
                        //         offset: Offset(0, 4),
                        //         // 그림자 흐림 반경
                        //         blurRadius: 6,
                        //         // 그림자 확산 반경
                        //         spreadRadius: 1,
                        //       ),
                        //     ],
                        //   ),
                        //   child: ElevatedButton(
                        //     onPressed: (){
                        //       Navigator.pop(context);
                        //     },
                        //     child: Text('취소'),
                        //     style: ElevatedButton.styleFrom(
                        //         shape: RoundedRectangleBorder(
                        //             borderRadius: BorderRadius.circular(15)
                        //         ),
                        //
                        //         minimumSize: Size(160, 50),
                        //         alignment: Alignment.center,
                        //         textStyle: TextStyle(fontSize: 14, fontFamily: FontFamily.mapleStoryLight),
                        //         backgroundColor: ColorFamily.white,
                        //         foregroundColor: ColorFamily.black
                        //     ),
                        //   ),
                        // ),

                        // 취소, 작성 버튼의 간격
                        SizedBox(width: 20),
                        Expanded(
                          child: Container(
                            height: 40,
                            child: Material(
                              color: ColorFamily.beige,
                              elevation: 1,
                              shadowColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: InkWell(
                                onTap: () {
                                  if (validateFieldsCheck()) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('저장 확인 테스트 메시지')),
                                    );
                                  }
                                },
                                borderRadius: BorderRadius.circular(20.0),
                                child: Container(
                                  height: 40,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "작성",
                                    style: TextStyleFamily.normalTextStyle,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                        // 작성 버튼
                        // Container(
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(15),
                        //     boxShadow: [
                        //       BoxShadow(
                        //         // 그림자 색상
                        //         color: Colors.black.withOpacity(0.3),
                        //         // 그림자 오프셋 (x, y)
                        //         offset: Offset(0, 4),
                        //         // 그림자 흐림 반경
                        //         blurRadius: 6,
                        //         // 그림자 확산 반경
                        //         spreadRadius: 1,
                        //       ),
                        //     ],
                        //   ),
                        //   child: ElevatedButton(
                        //     onPressed: (){
                        //       if (validateFieldsCheck()) {
                        //         ScaffoldMessenger.of(context).showSnackBar(
                        //           SnackBar(content: Text('저장 확인 테스트 메시지')),
                        //         );
                        //       }
                        //     },
                        //     child: Text('작성'),
                        //     style: ElevatedButton.styleFrom(
                        //         shape: RoundedRectangleBorder(
                        //             borderRadius: BorderRadius.circular(15)
                        //         ),
                        //         minimumSize: Size(160, 50),
                        //         alignment: Alignment.center,
                        //         textStyle: TextStyle(fontSize: 14, fontFamily: FontFamily.mapleStoryLight),
                        //         backgroundColor: ColorFamily.beige,
                        //         foregroundColor: ColorFamily.black
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ]))),
    );
  }
}
