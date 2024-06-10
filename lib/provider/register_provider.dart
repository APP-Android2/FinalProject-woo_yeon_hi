import 'package:flutter/cupertino.dart';

class CodeConnectProvider extends ChangeNotifier {

  bool _isCodeGenerated = false;
  bool _isCodeExpired = false;
  String _randomCodeText = "";
  TextEditingController _codeTextEditController = TextEditingController();

  bool get isCodeGenerated => _isCodeGenerated;
  bool get isCodeExpired => _isCodeExpired;
  String get randomCodeText => _randomCodeText;
  TextEditingController get codeTextEditController => _codeTextEditController;

  void setIsCodeGenerated(bool bool){
    _isCodeGenerated = bool;
    notifyListeners();
  }

  void setIsCodeExpired(bool bool){
    _isCodeExpired = bool;
    notifyListeners();
  }

  void setRandomCodeText(String randomCode){
    _randomCodeText = randomCode;
    notifyListeners();
  }

  void setCodeText(String randomCode){
    _randomCodeText = randomCode;
    notifyListeners();
  }
}