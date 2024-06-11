import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class dDayAddProvider extends ChangeNotifier{
  List<bool> _isChecked = [];

  List<bool> get isChecked => _isChecked;

  dDayAddProvider(int itemCount){
    for(int i = 0; i< itemCount; i++){
      _isChecked.add(false);
    }
  }

  void toggleCheck(int index){
    _isChecked[index] = !_isChecked[index];
    notifyListeners();
  }
}

class dDayMakeCustomProvider extends ChangeNotifier{
  TextEditingController _title = TextEditingController();
  TextEditingController _content = TextEditingController();
  List<bool> _isChecked = [true, false];
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();

  TextEditingController get title => _title;
  TextEditingController get content => _content;
  List<bool> get isChecked => _isChecked;
  DateTime? get selectedDay => _selectedDay;
  DateTime get focusedDay => _focusedDay;

  void checkedChange(){
    _isChecked[0] = !_isChecked[0];
    _isChecked[1] = !_isChecked[1];
    notifyListeners();
  }

  void setSelectedDay(DateTime day){
    _selectedDay = day;
    notifyListeners();
  }

  void setfocusedDay(DateTime day){
    _focusedDay = day;
    notifyListeners();
  }
}

// 날짜 계산용 오늘 날짜
DateTime _today(){
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
}