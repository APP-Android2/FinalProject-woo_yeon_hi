import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:woo_yeon_hi/dao/diary_dao.dart';

import '../model/diary_model.dart';
import '../utils.dart';

// 교환일기 메인 프로바이더
class DiaryProvider extends ChangeNotifier{
  List<String> _editorType = ["전체", "나", "상대방"];
  List<bool> _isSelected_editor = [true, false, false];
  List<String> _sortType = ["최신순", "오래된순"];
  List<bool> _isSelected_sort = [true, false];
  String _startPeriod = "";
  String _endPeriod = "";
  final TextEditingController _startPeriodController = TextEditingController(text: "");
  final TextEditingController _endPeriodController = TextEditingController(text: "");
  List<String> _filterList = ["전체", "최신순"];

  int? _diaryUserIdx;
  List<Diary> _diaryData = [];

  List<String> get editorType => _editorType;
  String get startPeriod => _startPeriod;
  String get endPeriod => _endPeriod;
  TextEditingController get startPeriodController => _startPeriodController;
  TextEditingController get endPeriodController => _endPeriodController;
  List<String> get sortType => _sortType;
  List<bool> get isSelected_editor => _isSelected_editor;
  List<bool> get isSelected_sort => _isSelected_sort;
  List<String> get filterList => _filterList;
  List<Diary> get diaryData => _diaryData;
  int? get diaryUserIdx => _diaryUserIdx;

  Future<List<Diary>> getDiary(int user_idx) async {
    _diaryData.clear();

    int? user_idx = _diaryUserIdx;

    int filter_editor = _isSelected_editor.indexWhere((element) => element);
    int filter_sort = _isSelected_sort.indexWhere((element) => element);

    String filter_start = _startPeriod;
    String filter_end = _endPeriod;

    if(filter_start.isNotEmpty && filter_end.isNotEmpty){
      DateTime pd1 = stringToDate(_startPeriod);
      DateTime pd2 = stringToDate(_endPeriod);
      if (pd1.compareTo(pd2) < 0) {
        filter_start = _startPeriod;
        filter_end = _endPeriod;
      }else{
        filter_start = _endPeriod;
        filter_end = _startPeriod;
      }
    }

    var mapList = await getDiaryData(user_idx, filter_editor, filter_sort, filter_start, filter_end);

    for(var mapData in mapList){
      _diaryData.add(Diary.fromData(mapData));
    }

    return _diaryData;
  }

  void setUserIdx(int? idx){
    _diaryUserIdx = idx;
  }

  void setStartPeriod(String date){
    _startPeriod = date;
  }

  void setEndPeriod(String date){
    _endPeriod = date;
  }

  void setStartControllerText(String text){
    _startPeriodController.text = text;
  }

  void setEndControllerText(String text){
    _endPeriodController.text = text;
  }

  void setSelected_editor(List<bool> values){
    _isSelected_editor = values;
  }

  void setSelected_sort(List<bool> values){
    _isSelected_sort = values;
  }

  void removeFilterListByIndex(int index){
    _filterList.removeAt(index);
    notifyListeners();
  }

  void updateSelected_editor(int index, bool value){
    _isSelected_editor[index] = value;
  }

  void updateSelected_sort(int index, bool value){
    _isSelected_sort[index] = value;
  }

  void setFilterList(List<String> value){
    _filterList = value;
  }

  void addFilterListItem(String item){
    _filterList.add(item);
  }

  void providerNotify(){
    notifyListeners();
  }
}

// 교환일기 작성 프로바이더
class DiaryEditProvider extends ChangeNotifier{
  final TextEditingController _titleTextEditController = TextEditingController();
  final TextEditingController _contentTextEditController = TextEditingController();
  XFile? _image;
  int _weatherType = 0;

  TextEditingController get titleTextEditController => _titleTextEditController;
  TextEditingController get contentTextEditController => _contentTextEditController;
  XFile? get image => _image;
  int get weatherType => _weatherType;

  // 제목과 내용, 이미지 중 하나라도 작성되었는지 검사합니다.
  bool checkProvider(){
    if(titleTextEditController.text.isNotEmpty || contentTextEditController.text.isNotEmpty || image != null){
      return true;
    }else{
      return false;
    }
  }

  // 제목과 내용, 이미지가 다 작성되었는지 검사합니다.
  bool checkValid(){
    if(titleTextEditController.text.isNotEmpty && contentTextEditController.text.isNotEmpty && image != null){
      return true;
    }else{
      return false;
    }
  }

  void resetProvider(){
    _titleTextEditController.clear();
    _contentTextEditController.clear();
    _image = null;
    _weatherType = 0;
  }

  void setTitleController(String title){
    _titleTextEditController.text = title;
    notifyListeners();
  }

  void setContentController(String content){
    _contentTextEditController.text = content;
    notifyListeners();
  }

  void setImage(XFile? imagePath){
    _image = imagePath;
    notifyListeners();
  }

  void setWeather(int type){
    _weatherType = type;
    notifyListeners();
  }

  void providerNotify(){
    notifyListeners();
  }
}