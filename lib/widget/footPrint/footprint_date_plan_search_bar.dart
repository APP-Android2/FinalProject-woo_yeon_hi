import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/provider/footprint_provider.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/font.dart';
import 'package:woo_yeon_hi/style/text_style.dart';

class FootprintDatePlanSearchBar extends StatefulWidget {
  const FootprintDatePlanSearchBar({super.key});

  @override
  State<FootprintDatePlanSearchBar> createState() => _FootprintDatePlanSearchBarState();
}

class _FootprintDatePlanSearchBarState extends State<FootprintDatePlanSearchBar> {

  @override
  Widget build(BuildContext context) {
    return FloatingSearchBar(
      backgroundColor: ColorFamily.white,
      hint: '장소 검색',
      hintStyle: TextStyleFamily.hintTextStyle,
      elevation: 1,
      width: double.maxFinite,
      height: 50,
      borderRadius: BorderRadius.circular(30),
      automaticallyImplyBackButton: false,  // 뒤로가기 버튼 활성화 설정
      axisAlignment: 0.0,  // 검색 바가 화면에서 수평으로 중앙에 정렬되도록 설정
      openAxisAlignment: 0.0,  // 검색 바가 열렸을 때 수평으로 중앙에 정렬되도록 설정
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),  // 검색 바가 열릴 때의 스크롤 사이 간격
      transitionDuration: const Duration(milliseconds: 600),  // 검색 바의 열림/닫힘 애니메이션 지속 시간
      transitionCurve: Curves.easeInOut,  // 애니메이션의 커브 설정
      physics: BouncingScrollPhysics(),  // 스크롤 동작을 바운싱으로 설정
      transition: CircularFloatingSearchBarTransition(),  // 검색 바의 열림/닫힘 애니메이션을 원형으로 설정
      debounceDelay: const Duration(milliseconds: 500),  // 검색어 입력 중 콜백 함수 딜레이 설정
      queryStyle: TextStyle(fontSize: 15, color: ColorFamily.black, fontFamily: FontFamily.mapleStoryLight), // 검색어 입력 스타일. (검색된 항목의 title과 동일하게 설정)
      onQueryChanged: (query) {  // 검색어가 변경될 때 호출되는 콜백 함수
        print('검색어 입력 중: $query');
      },

      // 검색 바를 위한 TextController 설정
      controller: FloatingSearchBarController(),

      /*
      // 검색 바가 클릭되면 왼쪽에 뒤로가기 버튼 표시
      onFocusChanged: (isFocused) {
        setState(() {});
      },

      // 검색 바의 왼쪽에 표시될 액션 버튼들
      leadingActions: [
        FloatingSearchBarAction.back(
          showIfClosed: false,
        ),
      ],
      */

      // 검색 바에 표시될 액션 버튼들
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,  // 검색 바가 열렸을 때, 검색 아이콘 여부 설정
          child: CircularButton(
            icon: SvgPicture.asset('lib/assets/icons/search.svg'),  // 검색 아이콘 설정
            onPressed: () {
              print('검색 버튼 클릭');
            },
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,  // 검색 바가 닫혔을 때 검색 아이콘 여부 설정
        ),
      ],


      // 검색 결과를 표시할 위젯을 빌드하는 함수
      builder: (context, transition) {
        return Consumer<FootPrintDatePlanSlidableProvider>(
          builder: (context, provider, child) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),  // 검색 결과 리스트의 모서리를 둥글게 설정
              child: Material(
                color: Colors.white,  // 검색 결과 리스트의 배경색 설정
                elevation: 1.0,  // 검색 결과 리스트의 그림자 높이 설정
                child: Container(
                  height:  MediaQuery.of(context).size.height * 0.3 ,
                  child: SingleChildScrollView(
                    child: Column(
                      //mainAxisSize: MainAxisSize.min,  // 검색 결과 리스트의 크기에 맞게 최소화하여 설정
                      children: List.generate(provider.items.length, (index) {
                        final item = provider.items[index];
                        return makeListView(item, index);
                      }),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  // 검색된 항목 아이템
  Widget makeListView(Item item, int index){
    return Consumer<FootPrintDatePlanSlidableProvider>(
      builder: (context, provider, child) {
        return Container(
          child: Column(
            children: [
              Slidable(
                key: ValueKey(index),
                endActionPane: ActionPane(
                  motion: ScrollMotion(),
                  extentRatio: 0.25,
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        provider.removeItem(index);
                        Slidable.of(context)?.close();

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('삭제 되었습니다.'),
                          ),
                        );
                      },
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      label: '삭제',
                    ),
                  ],
                ),
                // 각 아이템을 위한 설정
                child: makeSlidable(item, index),
              ),
              const Divider(
                height: 0.5,
                color: ColorFamily.gray,
              ),
            ],
          ),
        );
      },
    );
  }

  // 검색된 항목을 슬라이드 항목으로
  Widget makeSlidable(Item item, int index){
    return Consumer<FootPrintDatePlanSlidableProvider>(
      builder: (context, provider, child) {
        return Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(item.title, style: TextStyle(fontSize: 15, color: ColorFamily.black, fontFamily: FontFamily.mapleStoryLight)),
                        SizedBox(width: 10),
                        Text('지하철역', style: TextStyle(fontSize: 10, color: ColorFamily.gray, fontFamily: FontFamily.mapleStoryLight)),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text('서울 송파구 올림픽로 240', style: TextStyle(fontSize: 12, color: ColorFamily.black, fontFamily: FontFamily.mapleStoryLight)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
