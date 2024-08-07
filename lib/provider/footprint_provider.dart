import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:woo_yeon_hi/model/enums.dart';
import 'package:woo_yeon_hi/model/place_info.dart';

/// 탭 전환 상태 관리 프로바이더
class FootprintProvider extends ChangeNotifier{

  int _currentPageIndex = 0;

  int get currentPageIndex => _currentPageIndex;

  void setCurrentPageIndex(int index){
    _currentPageIndex = index;
    notifyListeners();
  }


}

/// 포토 맵 목록 상태 관리 프로바이더
class FootprintPhotoMapProvider extends ChangeNotifier{
  List<String> _photoMapNameList = [];

  List<String> get photoMapNameList => _photoMapNameList;

  FootprintPhotoMapProvider(List<String> nameList){
    for(var name in nameList){
      _photoMapNameList.add(name);
    }
  }

  void setName(int index, String name){
    _photoMapNameList[index] = name;
    notifyListeners();
  }

  void removeItem(int index){
    _photoMapNameList.removeAt(index);
    notifyListeners();
  }
}

/// 히스토리 목록 ExpansionTile 상태 관리 프로바이더
class FootprintHistoryProvider extends ChangeNotifier{

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

/// 히스토리 내용 더보기 버튼 상태 관리 프로바이더
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

/// 히스토리 작성 상태 관리 프로바이더
class FootprintHistoryEditProvider extends ChangeNotifier{
  String? _selectedPlace;
  String? _date;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  String? get selectedPlace => _selectedPlace;
  String? get date => _date;
  TextEditingController get titleController => _titleController;
  TextEditingController get contentController => _contentController;

  void setPlace(String? place){
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

/// 포토맵 오버레이 상태관리 프로바이더
class FootprintPhotoMapOverlayProvider extends ChangeNotifier{
  MapType? _mapType;
  OverlayInfo? _overlayInfo;
  Map<int, PlaceInfo> _polygonInfos = {};
  List<NPolygonOverlay> _polygonOverlays = [];
  List<NMarker> _markers = [];

  MapType? get mapType => _mapType;
  OverlayInfo? get overlayInfo => _overlayInfo;
  Map<int, PlaceInfo> get polygonInfos => _polygonInfos;
  List<NPolygonOverlay> get polygonOverlays => _polygonOverlays;
  List<NMarker> get markers => _markers;

  FootprintPhotoMapOverlayProvider(int type){
    setMapType(type);
    setOverlayInfo();
  }

  void setMapType(int type){
    _mapType = MapType.fromType(type);
    notifyListeners();
  }

  void setOverlayInfo(){
    if(mapType != null){
      _overlayInfo = OverlayInfo.fromType(mapType!.type);
      notifyListeners();
    }
  }

  void addInfo(int id, PlaceInfo info){
    _polygonInfos[id] = info;
    notifyListeners();
  }

  void addOverlay(NPolygonOverlay overlay){
    _polygonOverlays.add(overlay);
    notifyListeners();
  }

  void addMarker(NMarker marker){
    _markers.add(marker);
    notifyListeners();
  }

  void clearMarker(){
    _markers.clear();
    notifyListeners();
  }

}

// 데이트 플랜 메인 화면 상태관리
class FootPrintSlidableProvider extends ChangeNotifier {
  final List<Item> _items = List<Item>.generate(5, (index) => Item(title: "제주도 여행 ${index + 1}"));

  // List<Item> _items = [
  //   Item(title: 'Item 1'),
  //   Item(title: 'Item 2'),
  //   Item(title: 'Item 3'),
  //   Item(title: 'Item 4'),
  //   Item(title: 'Item 5'),
  //   Item(title: 'Item 6'),
  //   Item(title: 'Item 7'),
  // ];

  List<Item> get items => _items;

  void addItem(String title) {
    _items.add(Item(title: title));
    notifyListeners();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void toggleCompleteItem(int index) {
    _items[index].isCompleted = !_items[index].isCompleted;
    notifyListeners();
  }
}

// 데이트 플랜 메인 화면 상태관리
class Item {
  final String title;
  bool isCompleted;

  Item({required this.title, this.isCompleted = false});
}

// 데이트 플랜 작성 화면 슬라이드 상태관리
class FootPrintDatePlanSlidableProvider extends ChangeNotifier {
  final List<Item> _items = List<Item>.generate(5, (index) => Item(title: "방이역 ${index + 1}"));

  List<Item> get items => _items;

  void addItem(String title) {
    _items.add(Item(title: title));
    notifyListeners();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }
}

// 데이트 플랜 DraggableSheet 상태관리
class FootprintDraggableSheetProvider extends ChangeNotifier {

  // 상세 화면에서 사용할 입력 컨트롤러
  final TextEditingController memoTitleController = TextEditingController();
  final TextEditingController memoSubController = TextEditingController();

  // sheet 키
  final GlobalKey _sheetKey = GlobalKey();
  final DraggableScrollableController _controller = DraggableScrollableController();
  List<String> _items = ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5'];

  DraggableSheetState() {
    _controller.addListener(_onChanged);
  }

  GlobalKey get sheetKey => _sheetKey;
  DraggableScrollableController get controller => _controller;
  List<String> get items => _items;

  void _onChanged() {
    final currentSize = _controller.size;
    if (currentSize <= 0.05) collapse();
  }

  void collapse() => _animateSheet(sheet.snapSizes!.first);
  void anchor() => _animateSheet(sheet.snapSizes!.last);
  void expand() => _animateSheet(sheet.maxChildSize);
  void hide() => _animateSheet(sheet.minChildSize);

  void _animateSheet(double size) {
    _controller.animateTo(
      size,
      duration: const Duration(milliseconds: 50),
      curve: Curves.easeInOut,
    );
  }

  void addItem(String item) {
    _items.add(item);
    notifyListeners();
  }

  void removeItem(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  DraggableScrollableSheet get sheet => (_sheetKey.currentWidget as DraggableScrollableSheet);
}