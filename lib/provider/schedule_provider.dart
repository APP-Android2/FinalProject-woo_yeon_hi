import 'package:flutter/cupertino.dart';

class ScheduleProvider extends ChangeNotifier {
  final TextEditingController _titleController = TextEditingController(); // 일정 제목
  final TextEditingController _memoController = TextEditingController();  // 일정 메모

  TextEditingController get titleController => _titleController;
  TextEditingController get memoController => _memoController;

  void setTitleController(String title){
    _titleController.text = title;
    notifyListeners();
  }

  void setMemoController(String memo){
    _memoController.text = memo;
    notifyListeners();
  }

  void providerNotify(){
    notifyListeners();
  }
}

