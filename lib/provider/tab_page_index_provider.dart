import 'package:flutter/material.dart';

class TabPageIndexProvider extends ChangeNotifier{

  // 눈에 보여질 화면의 순서값
  // 하단 내비게이션바의 선택한 메뉴 번호
  int _currentPageIndex = 2;

  int get currentPageIndex => _currentPageIndex;

  // 사용자가 입력한 검색어를 담을 변수
  String _searchKeyword = "";

  String get searchKeyword => _searchKeyword;


  void setCurrentPageIndex(int index){
    _currentPageIndex = index;
    notifyListeners();
  }

  void setKeyword(String keyword){
    _searchKeyword = keyword;
    // 모든 리스너를 동작시킨다.
    notifyListeners();
  }
}