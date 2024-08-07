import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DiaryProvider extends ChangeNotifier{
  final TextEditingController _titleTextEditController = TextEditingController();
  final TextEditingController _contentTextEditController = TextEditingController();
  XFile? _image;

  TextEditingController get titleTextEditController => _titleTextEditController;
  TextEditingController get contentTextEditController => _contentTextEditController;
  XFile? get image => _image;

  bool checkProvider(){
    if(titleTextEditController.text.isNotEmpty || contentTextEditController.text.isNotEmpty || image != null){
      return true;
    }else{
      return false;
    }
  }

  void resetProvider(){
    _titleTextEditController.clear();
    _contentTextEditController.clear();
    _image = null;
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

  @override
  void dispose() {
    _titleTextEditController.dispose();
    _contentTextEditController.dispose();
    super.dispose();
  }
}