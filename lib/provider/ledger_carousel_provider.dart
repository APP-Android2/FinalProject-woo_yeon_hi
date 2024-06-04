import 'package:flutter/material.dart';

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