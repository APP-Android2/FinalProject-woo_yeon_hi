import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FootprintProvider extends ChangeNotifier{
  // 탭 전환
  int _currentPageIndex = 0;

  int get currentPageIndex => _currentPageIndex;

  void setCurrentPageIndex(int index){
    _currentPageIndex = index;
    notifyListeners();
  }


}

class FootprintHistoryProvider extends ChangeNotifier{
  // 포토 맵 ExpansionTile 상태 관리
  List<bool> _isExpandedList = [];

  FootprintHistoryProvider(int itemCount){
    _isExpandedList.add(true);
    for (int i = 1; i < itemCount; i++) {
      _isExpandedList.add(false);
    }
  }

  List<bool> get isExpandedList => _isExpandedList;

  void setExpansionState(int index, bool isExpanded) {
    _isExpandedList[index] = isExpanded;
    notifyListeners();
  }

  void expandAll() {
    _isExpandedList = List.filled(_isExpandedList.length, true);
    notifyListeners();
  }

  void collapseAll() {
    _isExpandedList = List.filled(_isExpandedList.length, false);
    notifyListeners();
  }
}

class FootPrintHistoyDetailProvider extends ChangeNotifier{
  List<bool> _isMoreList = [];

  FootPrintHistoyDetailProvider(int itemCount){
    for(int i = 0; i< itemCount; i++){
      _isMoreList.add(true);
    }
  }

  List<bool> get isMoreList => _isMoreList;

  void setMoreState(int index, bool isMore){
    _isMoreList[index] = isMore;
    notifyListeners();
  }
}

class FootprintHistoryEditProvider extends ChangeNotifier{
  String? _selectedPlace;
  String? _date;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  String? get selectedPlace => _selectedPlace;
  String? get date => _date;
  TextEditingController get titleController => _titleController;
  TextEditingController get contentController => _contentController;

  void setPlace(String place){
    _selectedPlace = place;
    notifyListeners();
  }

  void setDate(String date){
    _date = date;
    notifyListeners();
  }

  void setTitle(String title){
    _titleController.text = title;
    notifyListeners();
  }

  void setContent(String content){
    _contentController.text = content;
    notifyListeners();
  }
}