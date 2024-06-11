import 'package:flutter/material.dart';
import 'package:woo_yeon_hi/dao/ledger_dao.dart';
import 'package:woo_yeon_hi/model/ledger_model.dart';

class LedgerProvider extends ChangeNotifier{
  final LedgerDao _ledgerDao = LedgerDao();
  List<Ledger> _ledgers = [];

  List<Ledger> get ledgers => _ledgers;

  LedgerProvider() {
    fetchLedgers();
  }

  // table_calendar 파일 에서 사용.
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  DateTime get selectedDay => _selectedDay;
  DateTime get focusedDay => _focusedDay;

  // 포커스 업데이트
  void setSelectedAndFocusedDay(DateTime focusedDay) {
    _selectedDay = focusedDay;
    _focusedDay = focusedDay;
    notifyListeners();
  }

  void setSelectedDay(DateTime day) {
    _selectedDay = day;
    notifyListeners();
  }

  void setFocusedDay(DateTime day) {
    _focusedDay = day;
    notifyListeners();
  }

  // 데이터 가져오기
  Future<void> fetchLedgers() async {
    try {
      _ledgers = await _ledgerDao.getLedgerData();
      notifyListeners();
      print('가져오기 확인: $_ledgers');
    } catch (error) {
      print('가계부 데이터 호출 중에 오류 $error');
    }
  }

  // 데이터 추가
  Future<void> addLedger(Ledger ledger) async {
    try {
      await _ledgerDao.saveLedger(ledger)
        .then((value) => print('가계부 데이터 저장 성공 ${ledger}'));
      fetchLedgers(); // 데이터를 새로고침
    } catch (error) {
      print('가계부 데이터 저장 중 오류 $error');
    }
  }

  // // 데이터 업데이트
  // Future<void> updateLedger(Ledger ledger) async {
  //   try {
  //     await _ledgerDao.updateLedger(ledger);
  //     fetchLedgers(); // 데이터를 새로고침
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  //
  // // 데이터 삭제
  // Future<void> deleteLedger(int ledgerIdx) async {
  //   try {
  //     await _ledgerDao.deleteLedger(ledgerIdx);
  //     fetchLedgers(); // 데이터를 새로고침
  //   } catch (e) {
  //     print(e);
  //   }
  // }

}

// Carousel 슬라이더 상태관리
class LedgerCarouselProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> items = [
    {
      'texts1': ['5월 지출 현황'],
      'texts2': ['1,550,000 원'],
      'texts3': ['지난달보다 '],
      'texts4': ['150,500 원 '],
      'texts5': ['더 쓰고 있어요'],
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

  // 전체 선택 상태를 반환
  bool get allChecked => _checkedItems.every((item) => item);

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