import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/style/text_style.dart';
import 'package:woo_yeon_hi/widget/more/help_top_app_bar.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  String _searchKeyword = "";
  bool _isUnExpanded = true;

  List<String> helpListTitle = [
    "탈퇴 시 상대방 계정 처리가 궁금해요.",
    "로그아웃은 어떻게 하나요?",
    "데이터 백업은 어떻게 하나요?",
    "잠금 비밀번호를 잊어버렸을 때 해결방법이 궁금해요.",
    "프로필 상태 메시지는 몇자까지 가능한가요?",
    "닉네임을 변경하지 않았는데 다른 닉네임으로 되어있어요.",
    "교환일기는 하루에 몇 번까지 쓸 수 있나요?",
    "추억 모아보기는 어떤 기능인가요?",
    "알림을 활성화하면 언제 알림을 받게 되나요?",
    "홈 화면에서 디데이, 캘린더 외에 다른 것도 보고 싶어요.",
    "생체 인증 기능을 사용할 수 없다고 떠요. 어떻게 해야 하나요?",
    "앱을 사용하고 있지 않을 때도 상단바에 디데이를 보고 싶은데 어떻게 해야 하나요?",
  ];

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: const HelpTopAppBar(),
        body: Container(
            width: deviceWidth,
            height: deviceHeight,
            padding: const EdgeInsets.all(20),
            color: ColorFamily.cream,
            child: Column(
              children: [
                Material(
                  elevation: 1,
                  color: ColorFamily.beige,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    alignment: Alignment.center,
                    width: deviceWidth - 60,
                    height: deviceHeight * 0.07,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      cursorColor: ColorFamily.black,
                      textInputAction: TextInputAction.search,
                      style: TextStyleFamily.normalTextStyle,
                      decoration: InputDecoration(
                          suffixIcon:
                          SvgPicture.asset("lib/assets/icons/search.svg"),
                          suffixIconConstraints:
                          const BoxConstraints(minHeight: 24, minWidth: 24),
                          hintText: "어떤 도움이 필요하신가요?",
                          hintStyle: TextStyle(
                              fontSize: 14,
                              color: ColorFamily.black.withOpacity(0.5),
                              fontFamily: FontFamily.mapleStoryLight),
                          counterText: "",
                          border: InputBorder.none),
                      onTapOutside: (event) {
                        FocusScope.of(context).unfocus();
                      },
                      onChanged: (value){
                        setState(() {
                          _searchKeyword = value;
                        });
                      },
                      onFieldSubmitted: (value) {
                        setState(() {
                          _searchKeyword = value;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 30),
                    color: ColorFamily.cream,
                    child: ListView.builder(
                      itemCount: 12,
                      itemBuilder: (context, index) {
                        return
                        _searchKeyword.isNotEmpty && !helpListTitle[index].contains(_searchKeyword)
                            ? const SizedBox.shrink()

                            : Column(
                          children: [
                        Material(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorFamily.white,
                            elevation: 1,
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                splashColor: Colors.transparent,
                              ),
                              child: ExpansionTile(
                                  onExpansionChanged: (isExpanded) {
                                    setState(() {
                                      _isUnExpanded = !_isUnExpanded;
                                    });
                                  },
                                  iconColor: ColorFamily.black,
                                  leading: _isUnExpanded
                                      ? SvgPicture.asset(
                                      "lib/assets/icons/arrow_right_fill.svg")
                                      : SvgPicture.asset("lib/assets/icons/arrow_down_fill.svg"),
                                  trailing: SvgPicture.asset(""),
                                  title: Text(helpListTitle[index], style: TextStyleFamily.normalTextStyle),
                                  backgroundColor: ColorFamily.beige,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  children: [
                                    makeHelpListItem(context, index)
                                  ]),
                            ),
                          ),
                          const SizedBox(height: 10)
                          ],
                        );
                      },
                    ),
                  ),
                )
              ],
            )));
  }
}

Widget makeHelpListItem(BuildContext context, int index) {
  List<String> helpListContent = [
    "탈퇴 시 상대방 계정은 상대방 최초 접속 시 안내를 통해 커플 연결 해제 사실을 고지 후, 일정 기간 내에 계정 처리가 진행됩니다.",
    "'더 보기-앱 설정-로그아웃'에서 가능합니다.",
    "현재 데이터 백업은 지원되지 않습니다.",
    "앱에 접속 시 비밀번호 입력창에서 '비밀번호를 모르겠어요'로 이동한 후, 계정 인증을 완료하면 앱 잠금이 초기화 됩니다.",
    "상태메시지는 60자, 최대 4줄까지 입력이 가능합니다.",
    "우연히에서는 연인이 별명(닉네임)을 직접 바꿀수 있습니다.",
    "교환일기는 원하는대로 작성할 수 있습니다! 단, 한 사람이 연속으로 작성할 수 없고, 연인과 번갈아가며 작성할 수 있습니다. ",
    "추억 모아보기는 연인과 내가 특정 날짜에 해당하는 추억들만 모아서 한꺼번에 볼 수 있는 기능입니다. 날짜 부분을 터치하여 추억이 있는 날을 확인할 수 있습니다.",
    "알림 활성화 시, 연인이 무언가를 작성했을 때 알림을 받을 수 있습니다.",
    "홈 화면에 더 많은 기능을 보여주고 싶다면, '더보기-화면 스타일 설정-홈 화면 스타일'에서 원하는 스타일로 변경이 가능합니다.",
    "생체 인증 기능을 이용하려면 사용하는 기기가 생체 인증을 지원하고, 기기에 미리 등록된 생체 정보가 있어야 합니다. 휴대폰의 기본 설정에서 확인해주세요!",
    "상단바 기능은 '더보기-화면 스타일 설정-상단바 스타일'에서 원하는 스타일을 선택하고 상단바를 활성화하면 이용이 가능합니다.",
  ];

  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(30,0,20,0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
              helpListContent[index],
              style: const TextStyle(
                  fontSize: 12,
                  color: ColorFamily.black,
                  fontFamily: FontFamily.mapleStoryLight)),
        ),
      ),
      const SizedBox(height: 20),
    ],
  );
}
