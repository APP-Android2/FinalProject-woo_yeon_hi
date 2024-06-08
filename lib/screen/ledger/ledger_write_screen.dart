import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:woo_yeon_hi/dao/ledger_dao.dart';
import 'package:woo_yeon_hi/model/enums.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/style/text_style.dart';
import 'package:woo_yeon_hi/widget/ledger/ledger_dialog.dart';
import 'package:woo_yeon_hi/widget/ledger/ledger_top_app_bar.dart';

import '../../model/ledger_model.dart';

class LedgerWriteScreen extends StatefulWidget {
  const LedgerWriteScreen({super.key});

  @override
  State<LedgerWriteScreen> createState() => _LedgerWriteScreenState();
}

class _LedgerWriteScreenState extends State<LedgerWriteScreen> {

  LedgerDao ledgerDao = LedgerDao();

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

  // 카테고리 선택된 값
  int categorySelectedIndex = -1;

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
      maxTime: DateTime.now().add(Duration(seconds: 1)),
      // 완료 버튼 클릭 시.
      onConfirm: (date) {
        print('선택된 시간 확인: $date');
        setState(() {
          _dateSetting = '${date.year}. ${date.month}. ${date.day}.\(${_getWeekday(date.weekday)}\) ${date.hour}:${date.minute}';
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
      priceController.value = const TextEditingValue(
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

  // 최초 오류 메시지 false
  bool _showErrorMessages = false;

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
              children: [
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
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: FontFamily.mapleStoryLight,
                            color: ColorFamily.gray,
                          ),
                        ),
                        const SizedBox(width: 7),
                        SvgPicture.asset('lib/assets/icons/calendar.svg',
                            colorFilter: ColorFilter.mode(ColorFamily.gray, BlendMode.srcIn)
                        ),
                      ],
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.fromLTRB(30, 20, 0, 0),
                  width: 220,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        key: _priceKey,
                        controller: priceController,
                        //textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: ColorFamily.black,
                            fontSize: 30,
                            fontFamily: FontFamily.mapleStoryLight
                        ),
                        // 커서 숨김
                        showCursor: false,
                        // 키보드 타입
                        keyboardType: TextInputType.number,
                        //textInputAction: TextInputAction.next,
                        maxLines: 1,
                        maxLength: 7,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          // 텍스트 제한 수 표시 숨김
                          counterText: '',
                          hintText: '금액을 입력하세요',
                          hintStyle: TextStyle(
                            color: ColorFamily.gray,
                            fontSize: 20,
                            fontFamily: FontFamily.mapleStoryLight,
                          ),
                          errorStyle: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontFamily: FontFamily.mapleStoryLight,
                          ),
                        ),
                        inputFormatters: [
                          // 숫자만 입력 할 수 있도록.
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        // 유효성 검사를 수행
                        autovalidateMode: _showErrorMessages ? AutovalidateMode.always : AutovalidateMode.disabled,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '금액 입력은 필수입니다.';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),

                // 탭 조정
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 50),
                        child: ToggleButtons(
                          isSelected: selectTypeState,
                          constraints:
                          const BoxConstraints(minWidth: 90.0, minHeight: 40.0),
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
                            const Text('타이틀',
                                style: TextStyle(
                                    color: ColorFamily.black,
                                    fontSize: 20,
                                    fontFamily: FontFamily.mapleStoryLight
                                )
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: TextFormField(
                                key: _titleKey,
                                controller: titleController,
                                maxLength: 20,
                                maxLines: 1,
                                textInputAction: TextInputAction.next,
                                style: const TextStyle(
                                    color: ColorFamily.black,
                                    fontSize: 14,
                                    fontFamily: FontFamily.mapleStoryLight
                                ),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  counterText: '',
                                  hintText:'타이틀을 입력하세요. (20자 이내)',
                                  hintMaxLines: 1,
                                  hintStyle: TextStyle(
                                    color: ColorFamily.gray,
                                    fontSize: 14,
                                    fontFamily: FontFamily.mapleStoryLight,
                                    decorationThickness: 0,
                                  ),
                                  errorMaxLines: 1,
                                  errorStyle: TextStyle(
                                    color: Colors.red,
                                    fontSize: 14,
                                    fontFamily: FontFamily.mapleStoryLight,
                                  ),
                                ),
                                // 유효성 검사를 수행
                                autovalidateMode: _showErrorMessages ? AutovalidateMode.always : AutovalidateMode.disabled,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '타이틀 입력은 필수입니다.';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 30),

                            const Text('카테고리',
                                style: TextStyle(
                                    color: ColorFamily.black,
                                    fontSize: 20,
                                    fontFamily: FontFamily.mapleStoryLight
                                )
                            ),
                            Container(
                              //decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.red)),
                              padding: const EdgeInsets.only(top: 10),
                              child: makeCategoryItem(selectedIndex),
                            ),
                            const SizedBox(height: 30),

                            const Text('메모',
                                style: TextStyle(
                                    color: ColorFamily.black,
                                    fontSize: 20,
                                    fontFamily: FontFamily.mapleStoryLight
                                )
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: TextFormField(
                                key: _memoKey,
                                controller: memoController,
                                maxLength: 50,
                                maxLines: 5,
                                textInputAction: TextInputAction.next,
                                style: const TextStyle(
                                    color: ColorFamily.black,
                                    fontSize: 14,
                                    fontFamily: FontFamily.mapleStoryLight
                                ),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  counterText: '',
                                  hintText: '메모를 입력하세요. (선택사항)',
                                  hintMaxLines: 1,
                                  hintStyle: TextStyle(
                                    color: ColorFamily.gray,
                                    fontSize: 14,
                                    fontFamily: FontFamily.mapleStoryLight,
                                    decorationThickness: 0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
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
                                      if (priceController.text.isNotEmpty || titleController.text.isNotEmpty || memoController.text.isNotEmpty) {
                                        // 다이얼로그 띄우기.
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return LedgerDialog('LedgerWriteScreen', '작성을 끝내겠습니까?', '작성한 내용은 저장되지 않습니다.');
                                          },
                                        );
                                      }
                                      else
                                        Navigator.pop(context);
                                    },
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Container(
                                      height: 40,
                                      alignment: Alignment.center,
                                      child: const Text(
                                        "취소",
                                        style: TextStyleFamily.normalTextStyle,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // 취소, 작성 버튼의 간격
                            const SizedBox(width: 20),

                            // 작성 버튼
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
                                    onTap: () async {
                                      if (validateFieldsCheck()) {
                                        Navigator.pop(context);

                                        var ledgerIdx = await ledgerDao.getLedgerSequence();
                                        await ledgerDao.updateLedgerSequence(ledgerIdx + 1);
                                        var ledgerUserIdx = 100;

                                        var newLedger = Ledger(
                                            ledgerIdx: ledgerIdx + 1,
                                            ledgerUserIdx: ledgerUserIdx,
                                            ledgerDate: '2024.6.8',
                                            ledgerAmount: priceController.text,
                                            ledgerType: LedgerType.EXPENDITURE,
                                            ledgerTitle: titleController.text,
                                            ledgerCategory: LedgerCategory.FOOD_EXPENSES,
                                            ledgerMemo: memoController.text,
                                            ledgerState: LedgerState.STATE_NORMAL,
                                            ledgerModifyDate: ''
                                        );
                                        await ledgerDao.saveLedger(newLedger);

                                      }else{
                                        setState(() {
                                          _showErrorMessages = true;
                                        });
                                      }
                                    },
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Container(
                                      height: 40,
                                      alignment: Alignment.center,
                                      child: const Text(
                                        "작성",
                                        style: TextStyleFamily.normalTextStyle,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
          ),
        ),
      ),
    );
  }

  // 카테고리 정의
  Widget makeCategoryItem(int selectedIndex){
    if(selectedIndex == 0){
      return Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  onTap: () {
                    setState(() {
                      categorySelectedIndex = 0;
                    });
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5), // corner radius를 5로 설정
                            border: Border.all(color: (categorySelectedIndex == 0)?ColorFamily.pink:Colors.transparent), // stroke 색상을 red로 설정
                          ),
                          child: SvgPicture.asset('lib/assets/icons/spoon_fork.svg'),
                        ),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        const Text('식비',
                          style: TextStyle(
                              color: ColorFamily.black,
                              fontSize: 10,
                              fontFamily: FontFamily.mapleStoryLight
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 40)),
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  onTap: () {
                    setState(() {
                      categorySelectedIndex = 1;
                    });
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5), // corner radius를 5로 설정
                            border: Border.all(color: (categorySelectedIndex == 1)?ColorFamily.pink:Colors.transparent), // stroke 색상을 red로 설정
                          ),
                          child: SvgPicture.asset('lib/assets/icons/coffee_cup.svg'),
                        ),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        const Text('카페',
                          style: TextStyle(
                              color: ColorFamily.black,
                              fontSize: 10,
                              fontFamily: FontFamily.mapleStoryLight
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 40)),
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  onTap: () {
                    setState(() {
                      categorySelectedIndex = 2;
                    });
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5), // corner radius를 5로 설정
                            border: Border.all(color: (categorySelectedIndex == 2)?ColorFamily.pink:Colors.transparent), // stroke 색상을 red로 설정
                          ),
                          child: SvgPicture.asset('lib/assets/icons/bus.svg'),
                        ),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        const Text('교통',
                          style: TextStyle(
                              color: ColorFamily.black,
                              fontSize: 10,
                              fontFamily: FontFamily.mapleStoryLight
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 40)),
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  onTap: () {
                    setState(() {
                      categorySelectedIndex = 3;
                    });
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5), // corner radius를 5로 설정
                            border: Border.all(color: (categorySelectedIndex == 3)?ColorFamily.pink:Colors.transparent), // stroke 색상을 red로 설정
                          ),
                          child: SvgPicture.asset('lib/assets/icons/shopping_cart.svg'),
                        ),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        const Text('쇼핑',
                          style: TextStyle(
                              color: ColorFamily.black,
                              fontSize: 10,
                              fontFamily: FontFamily.mapleStoryLight
                          ),
                        ),
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
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  onTap: () {
                    setState(() {
                      categorySelectedIndex = 4;
                    });
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5), // corner radius를 5로 설정
                            border: Border.all(color: (categorySelectedIndex == 4)?ColorFamily.pink:Colors.transparent), // stroke 색상을 red로 설정
                          ),
                          child: SvgPicture.asset('lib/assets/icons/culture_popcorn.svg'),
                        ),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        const Text('문화',
                          style: TextStyle(
                              color: ColorFamily.black,
                              fontSize: 10,
                              fontFamily: FontFamily.mapleStoryLight
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 40)),
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  onTap: () {
                    setState(() {
                      categorySelectedIndex = 5;
                    });
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5), // corner radius를 5로 설정
                            border: Border.all(color: (categorySelectedIndex == 5)?ColorFamily.pink:Colors.transparent), // stroke 색상을 red로 설정
                          ),
                          child: SvgPicture.asset('lib/assets/icons/hobby_puzzle.svg'),
                        ),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        const Text('취미',
                          style: TextStyle(
                              color: ColorFamily.black,
                              fontSize: 10,
                              fontFamily: FontFamily.mapleStoryLight
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 40)),
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  onTap: () {
                    setState(() {
                      categorySelectedIndex = 6;
                    });
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5), // corner radius를 5로 설정
                            border: Border.all(color: (categorySelectedIndex == 6)?ColorFamily.pink:Colors.transparent), // stroke 색상을 red로 설정
                          ),
                          child: SvgPicture.asset('lib/assets/icons/lover.svg'),
                        ),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        const Text('데이트',
                          style: TextStyle(
                              color: ColorFamily.black,
                              fontSize: 10,
                              fontFamily: FontFamily.mapleStoryLight
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 40)),
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  onTap: () {
                    setState(() {
                      categorySelectedIndex = 7;
                    });
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5), // corner radius를 5로 설정
                            border: Border.all(color: (categorySelectedIndex == 7)?ColorFamily.pink:Colors.transparent), // stroke 색상을 red로 설정
                          ),
                          child: SvgPicture.asset('lib/assets/icons/game.svg'),
                        ),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        const Text('오락',
                          style: TextStyle(
                              color: ColorFamily.black,
                              fontSize: 10,
                              fontFamily: FontFamily.mapleStoryLight
                          ),
                        ),
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
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  onTap: () {
                    setState(() {
                      categorySelectedIndex = 8;
                    });
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5), // corner radius를 5로 설정
                            border: Border.all(color: (categorySelectedIndex == 8)?ColorFamily.pink:Colors.transparent), // stroke 색상을 red로 설정
                          ),
                          child: SvgPicture.asset('lib/assets/icons/travel.svg'),
                        ),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        const Text('여행',
                          style: TextStyle(
                              color: ColorFamily.black,
                              fontSize: 10,
                              fontFamily: FontFamily.mapleStoryLight
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 40)),
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  onTap: () {
                    setState(() {
                      categorySelectedIndex = 9;
                    });
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5), // corner radius를 5로 설정
                            border: Border.all(color: (categorySelectedIndex == 9)?ColorFamily.pink:Colors.transparent), // stroke 색상을 red로 설정
                          ),
                          child: SvgPicture.asset('lib/assets/icons/maintain_home.svg'),
                        ),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        const Text('주거',
                          style: TextStyle(
                              color: ColorFamily.black,
                              fontSize: 10,
                              fontFamily: FontFamily.mapleStoryLight
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 40)),
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  onTap: () {
                    setState(() {
                      categorySelectedIndex = 10;
                    });
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5), // corner radius를 5로 설정
                            border: Border.all(color: (categorySelectedIndex == 10)?ColorFamily.pink:Colors.transparent), // stroke 색상을 red로 설정
                          ),
                          child: SvgPicture.asset('lib/assets/icons/life_leaf.svg'),
                        ),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        const Text('생활',
                          style: TextStyle(
                              color: ColorFamily.black,
                              fontSize: 10,
                              fontFamily: FontFamily.mapleStoryLight
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 40)),
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  onTap: () {
                    setState(() {
                      categorySelectedIndex = 11;
                    });
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5), // corner radius를 5로 설정
                            border: Border.all(color: (categorySelectedIndex == 11)?ColorFamily.pink:Colors.transparent), // stroke 색상을 red로 설정
                          ),
                          child: SvgPicture.asset('lib/assets/icons/etc_more.svg'),
                        ),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        const Text('기타',
                          style: TextStyle(
                              color: ColorFamily.black,
                              fontSize: 10,
                              fontFamily: FontFamily.mapleStoryLight
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            //SizedBox(height: 15),
          ],
        ),
      );
    }else{
      return Container(
        child: Material(
          color: Colors.transparent,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    onTap: () {
                      setState(() {
                        categorySelectedIndex = 12;
                      });
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5), // corner radius를 5로 설정
                              border: Border.all(color: (categorySelectedIndex == 12)?ColorFamily.pink:Colors.transparent), // stroke 색상을 red로 설정
                            ),
                            child: SvgPicture.asset('lib/assets/icons/money_deposit.svg',
                              width: 40,
                              height: 40,
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(top: 10)),
                          const Text('입금',
                              style: TextStyle(
                                  color: ColorFamily.black,
                                  fontSize: 10,
                                  fontFamily: FontFamily.mapleStoryLight
                              ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(right: 40)),
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    onTap: () {
                      setState(() {
                        categorySelectedIndex = 13;
                      });
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5), // corner radius를 5로 설정
                              border: Border.all(color: (categorySelectedIndex == 13)?ColorFamily.pink:Colors.transparent), // stroke 색상을 red로 설정
                            ),
                            child: SvgPicture.asset('lib/assets/icons/income_add.svg',
                              width: 40,
                              height: 40,
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(top: 10)),
                          const Text('부수입',
                            style: TextStyle(
                                color: ColorFamily.black,
                                fontSize: 10,
                                fontFamily: FontFamily.mapleStoryLight
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(right: 40)),
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    onTap: () {
                      setState(() {
                        categorySelectedIndex = 14;
                      });
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5), // corner radius를 5로 설정
                              border: Border.all(color: (categorySelectedIndex == 14)?ColorFamily.pink:Colors.transparent), // stroke 색상을 red로 설정
                            ),
                            child: SvgPicture.asset('lib/assets/icons/income_bonus.svg',
                              width: 40,
                              height: 40,
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(top: 10)),
                          const Text('보너스',
                            style: TextStyle(
                                color: ColorFamily.black,
                                fontSize: 10,
                                fontFamily: FontFamily.mapleStoryLight
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(right: 40)),
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    onTap: () {
                      setState(() {
                        categorySelectedIndex = 15;
                      });
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5), // corner radius를 5로 설정
                              border: Border.all(color: (categorySelectedIndex == 15)?ColorFamily.pink:Colors.transparent), // stroke 색상을 red로 설정
                            ),
                            child: SvgPicture.asset('lib/assets/icons/etc_more.svg'),
                          ),
                          Padding(padding: EdgeInsets.only(top: 10)),
                          const Text('기타',
                            style: TextStyle(
                                color: ColorFamily.black,
                                fontSize: 10,
                                fontFamily: FontFamily.mapleStoryLight
                            ),
                          ),
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
      );
    }
  }

}
