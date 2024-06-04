import 'package:flutter/material.dart';

class LedgerProvider extends ChangeNotifier{

}

// Carousel 슬라이더 상태관리
class LedgerCarouselProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> items = [
    {
      'texts1': ['5월 지출 현황'],
      'texts2': ['1,550,000 원'],
      'texts3': ['지난달보다 150,500 원 더 쓰고 있어요'],
      'icon': 'lib/assets/icons/expand.svg',
    },
    {
      'image': 'lib/assets/images/ledger_test01.png',
    },
    {
      'image': 'lib/assets/images/ledger_test02.png',
    },
  ];

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}

// 체크박스 상태관리
class LedgerCheckBoxProvider extends ChangeNotifier{

  // 체크 상태를 저장하는 리스트
  List<bool> _checkedItems = List<bool>.filled(10, false);

  // 체크된 아이템 리스트를 반환
  List<bool> get checkedItems => _checkedItems;

  // 인덱스에 해당하는 항목의 체크 상태를 토글
  void toggleCheck(int index) {
    _checkedItems[index] = !_checkedItems[index];
    // provider에 연결된 모든 리스너를 동작 (상태 변경 알림)
    notifyListeners();
  }

  // 전체 항목의 체크 상태를 변경
  void toggleAll(bool value) {
    _checkedItems = List<bool>.filled(10, value);
    notifyListeners();
  }
}