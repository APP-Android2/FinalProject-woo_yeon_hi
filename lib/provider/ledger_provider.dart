import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:woo_yeon_hi/dao/ledger_dao.dart';
import 'package:woo_yeon_hi/model/ledger_model.dart';

class LedgerProvider extends ChangeNotifier{
  // LedgerDao 인스턴스
  final LedgerDao _ledgerDao = LedgerDao();
  List<Ledger> _ledgers = [];

  List<Ledger> get ledgers => _ledgers;

  LedgerProvider() {
    fetchLedgers();
    carouselSliderInitialData();
  }

  // 상단 베너 텍스트에 콤마
  String formatNumber(int number) {
    final formatter = NumberFormat('#,###');
    return formatter.format(number);
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

  // Carousel_Slider에서 사용 (상단 베너)
  int _currentIndex = 0;
  bool _isLoading = true;

  int get currentIndex => _currentIndex;
  bool get isLoading => _isLoading;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  // 상단 베너 로딩 데이터
  final List<Map<String, dynamic>> _itemsSetting = [{'texts1': ['']}, {'image': ''}];
  List<Map<String, dynamic>> get itemsSetting => _itemsSetting;

  // 상단 베너
  final List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items => _items;

  // 상단 베너 Text1
  void updateTexts1(int index, List<String> newTexts1) {
    if (index >= 0 && index < _items.length && _items[index].containsKey('texts1')) {
      _items[index]['texts1'] = newTexts1;
      notifyListeners();
    }
  }

  // 상단 베너 Text2
  void updateTexts2(int index, List<String> newTexts2) {
    if (index >= 0 && index < _items.length && _items[index].containsKey('texts2')) {
      _items[index]['texts2'] = newTexts2;
      notifyListeners();
    }
  }

  // 상단 베너 Text4
  void updateTexts4(int index, List<String> newTexts4) {
    if (index >= 0 && index < _items.length && _items[index].containsKey('texts4')) {
      _items[index]['texts4'] = newTexts4;
      notifyListeners();
    }
  }

  // 상단 베너 초기화
  Future<void> carouselSliderInitialData() async {
    _isLoading = true;
    notifyListeners();

    try {
      DateTime now = DateTime.now();
      List<Ledger> ledgers = await _ledgerDao.getMonthlyLedgerData(now);
      List<Ledger> previousLedgers = await _ledgerDao.getPreviousMonthLedgerData(now);

      int currentMonthSum = ledgers
          .where((ledger) => ledger.ledgerType.type == 0)
          .fold(0, (sum, ledger) => sum + ledger.ledgerAmount);

      int previousMonthSum = previousLedgers
          .where((ledger) => ledger.ledgerType.type == 0)
          .fold(0, (sum, ledger) => sum + ledger.ledgerAmount);

      _items.clear();
      _items.add({
        'texts1': ['${now.month}월 지출 현황'],
        'texts2': ['${formatNumber(currentMonthSum)} 원'],
        'texts3': ['지난달보다 '],
        'texts4': [currentMonthSum > previousMonthSum ? '${formatNumber(currentMonthSum - previousMonthSum)} 원' : '0 원'],
        'texts5': [' 더 쓰고 있어요'],
        'icon': 'lib/assets/icons/expand.svg',
      });

      _items.add({
        'image': 'lib/assets/images/ledger_coupon1.png',
      });

      _items.add({
        'image': 'lib/assets/images/ledger_coupon2.png',
      });

    } catch (e) {
      print("상단 베너 초기화 오류: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  // 상단 베너 업데이트
  Future<void> updateTextsOnMonthChange(DateTime newFocusedDay) async {
    try {
      List<Ledger> currentMonthLedgers = await _ledgerDao.getMonthlyLedgerData(newFocusedDay);
      List<Ledger> previousMonthLedgers = await _ledgerDao.getPreviousMonthLedgerData(newFocusedDay);

      int currentMonthSum = currentMonthLedgers
          .where((ledger) => ledger.ledgerType.type == 0)
          .fold(0, (sum, ledger) => sum + ledger.ledgerAmount);

      int previousMonthSum = previousMonthLedgers
          .where((ledger) => ledger.ledgerType.type == 0)
          .fold(0, (sum, ledger) => sum + ledger.ledgerAmount);

      updateTexts2(0, ['${formatNumber(currentMonthSum)} 원']);
      updateTexts4(0, [currentMonthSum > previousMonthSum ? '${formatNumber(currentMonthSum - previousMonthSum)} 원' : '0 원']);

    } catch (e) {
      print("상단 베너 업데이트 오류: $e");
    }

    updateTexts1(0, ['${newFocusedDay.month}월 지출 현황']);
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

  // 데이터 상세 보기
  List<Ledger> _selectedLedgerDate = [];
  List<Ledger> get selectedLedgerDate => _selectedLedgerDate;

  Future<void> readLedger(String ledgerDate) async {
    try{
      _selectedLedgerDate = await _ledgerDao.readLedger(ledgerDate);
      notifyListeners();
    } catch (error){
      print('가계부 데이터 상세 보기 중 오류 $error');
    }
  }

  // 데이터 수정
  Future<void> updateLedger(Ledger ledger) async {
    try {
      await _ledgerDao.updateLedger(ledger);
      fetchLedgers(); // 데이터를 새로고침
    } catch (error) {
      print('가계부 데이터 업데이트 중 오류 $error');
    }
  }

  // 데이터 삭제 (상태 값 업데이트)
  Future<void> deleteLedger(Ledger ledger) async {
    try {
      await _ledgerDao.updateLedgerState(ledger);
      fetchLedgers(); // 데이터를 새로고침
    } catch (error) {
      print('가계부 데이터 삭제 중 오류 $error');
    }
  }

}

// 체크박스 상태관리
class LedgerCheckBoxProvider extends ChangeNotifier{
  // 개별 체크박스의 상태를 저장하는 리스트
  List<bool> _checkedItems = List<bool>.filled(10, false);

  // 개별 체크박스
  List<bool> get checkedItems => _checkedItems;

  // 전체 체크박스 상태 확인
  bool get allChecked => _checkedItems.every((item) => item);

  // 전체 체크박스 상태 변경
  void toggleSelectAll(bool value) {
    // 개별 체크박스의 상태를 전체 체크박스와 동일하게 설정
    _checkedItems = List<bool>.filled(10, value);
    // provider에 연결된 모든 리스너를 동작 (상태 변경 알림)
    notifyListeners();
  }

  // 개별 체크박스 상태 변경
  void toggleCheck(int index) {
    _checkedItems[index] = !_checkedItems[index];
    notifyListeners();
  }
}